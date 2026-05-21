<?php
class DBConnection {
    // Konfigurasi koneksi (Dinamis dari Vercel / Fallback ke Local)
    private string $servername = "localhost";
    private string $username   = "root";
    private string $password   = "";
    private string $dbname     = "db_inventori_baru";

    private mysqli $dbconn;

    public function __construct() {
        // Ambil konfigurasi dari Environment Variables (Vercel) jika ada
        $this->servername = getenv('DB_HOST') ?: $this->servername;
        $this->username   = getenv('DB_USER') ?: $this->username;
        $this->password   = getenv('DB_PASS') !== false ? getenv('DB_PASS') : $this->password;
        $this->dbname     = getenv('DB_NAME') ?: $this->dbname;
        // buat koneksi ke MySQL
        $this->dbconn = new mysqli($this->servername, $this->username, $this->password, $this->dbname);

        // cek koneksi
        if ($this->dbconn->connect_error) {
            die(" Koneksi database gagal: " . $this->dbconn->connect_error);
        }

        // pastikan koneksi menggunakan UTF-8 (biar aman untuk teks Indonesia)
        $this->dbconn->set_charset("utf8mb4");
    }

    // method untuk ambil koneksi (digunakan di class lain)
    public function getConnection(): mysqli {
        return $this->dbconn;
    }

    // optional: method untuk menutup koneksi (kalau mau manual)
    public function close(): void {
        if ($this->dbconn) {
            $this->dbconn->close();
        }
    }
}
?>
