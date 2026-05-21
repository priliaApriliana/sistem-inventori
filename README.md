# 💊 Sistem Informasi Inventori Farmasi

![PHP](https://img.shields.io/badge/PHP-Native-777BB4?style=flat-square&logo=php&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-Database-4479A1?style=flat-square&logo=mysql&logoColor=white)
![Bootstrap](https://img.shields.io/badge/Bootstrap-5-7952B3?style=flat-square&logo=bootstrap&logoColor=white)

Sistem Informasi Inventori Farmasi (Apotek) adalah aplikasi manajemen stok obat, pengadaan, dan penjualan yang dibangun menggunakan PHP Native (Object-Oriented) dan MySQL. Project ini mendemonstrasikan implementasi CRUD kompleks, penggunaan Stored Procedure, Views, dan arsitektur Model-View.

## ✨ Fitur Utama

- **📊 Dashboard Analitik:** Ringkasan total barang, user, vendor, pengadaan, penerimaan, dan pendapatan penjualan.
- **📦 Manajemen Barang & Satuan:** Pengelolaan katalog obat/barang beserta satuan dinamis.
- **🏢 Manajemen Vendor:** Pendataan *supplier* (vendor) untuk proses pengadaan.
- **🛒 Transaksi Pengadaan (PO):** Pencatatan pesanan ke vendor dengan sistem perhitungan otomatis.
- **📥 Penerimaan Barang:** Verifikasi barang masuk dari vendor berdasarkan dokumen pengadaan.
- **💰 Transaksi Penjualan:** Modul kasir/penjualan dengan sistem margin keuntungan (HPP).
- **🔄 Retur Barang:** Pengembalian barang yang cacat/kadaluarsa.
- **📝 Kartu Stok:** Laporan mutasi barang (masuk/keluar) secara akurat.
- **🔐 Autentikasi & Otorisasi:** Sistem login dengan manajemen role (Super Admin, dll).

## 🛠️ Teknologi yang Digunakan

*   **Backend:** PHP 8.x (Native OOP)
*   **Database:** MySQL (Memanfaatkan Views & Stored Procedures)
*   **Frontend:** HTML5, Vanilla CSS, Bootstrap 5, Bootstrap Icons
*   **Arsitektur:** Native MVC-Pattern (Classes, Views, Scripts)

## 🚀 Panduan Instalasi (Localhost)

Aplikasi ini sangat mudah dijalankan di komputer lokal menggunakan **Laragon** atau **XAMPP**.

### 1. Persiapan Database
1. Buka `phpMyAdmin` atau `HeidiSQL`.
2. Buat database baru bernama: `db_inventori_baru`
3. Import file database yang sudah disediakan di folder:
   `database/db_inventori_baru.sql`
   *(Catatan: File SQL ini mengandung tabel, views, stored procedures, dan function bawaan)*

### 2. Konfigurasi Aplikasi
1. Clone / Download repository ini ke dalam folder `htdocs` (jika pakai XAMPP) atau `www` (jika pakai Laragon).
2. Pastikan susunan foldernya seperti ini: `c:/laragon/www/pbd_project_copy/`
3. Konfigurasi database ada di file `config/DBConnection.php`. Secara default sudah disetting menggunakan username `root` tanpa password. Silakan sesuaikan jika konfigurasi MySQL Anda berbeda.

```php
// config/DBConnection.php
private string $servername = "localhost";
private string $username   = "root";
private string $password   = "";
private string $dbname     = "db_inventori_baru";
```

### 3. Menjalankan Aplikasi
1. Nyalakan Apache dan MySQL di XAMPP/Laragon.
2. Buka browser dan akses: `http://localhost/pbd_project_copy/views/login.php`
3. Gunakan akun default yang ada di database untuk login (Atau Anda bisa melihat tabel `user` untuk daftar akun).

## 📂 Struktur Direktori

*   `/assets` - Berisi file statis (CSS, JS, Icons).
*   `/classes` - Berisi Class PHP (Model dan Logic untuk interaksi database).
*   `/config` - Konfigurasi koneksi database.
*   `/database` - File dump `.sql` untuk instalasi.
*   `/scripts` - Script pemroses data (seperti handler login/logout).
*   `/views` - Halaman UI (User Interface) berformat PHP.

## 👨‍💻 Author

Project ini dikembangkan sebagai portofolio implementasi PHP Native untuk manajemen sistem informasi kompleks.

---
*Dibuat dengan ❤️ untuk kemajuan sistem informasi kesehatan.*
