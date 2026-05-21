# Sistem Inventori Pengadaan

Ini adalah aplikasi web sederhana untuk manajemen inventori dan penjualan, yang dibangun menggunakan PHP Native dan MySQL. Project ini dibuat owner guna melkaukan pembelajaran, khususnya dalam memahami logika CRUD, pembuatan Stored Procedure di database, dan interaksi antar tabel yang cukup kompleks.

## Fitur Utama

- **Master Data**: Kelola data barang, satuan, vendor, dan user.
- **Transaksi**:
  - **Pengadaan**: Membuat daftar pesanan (PO) ke vendor.
  - **Penerimaan**: Mencatat barang masuk dari vendor dan otomatis menambah stok.
  - **Penjualan**: Kasir untuk barang keluar dengan penghitungan subtotal otomatis.
  - **Retur**: Mencatat barang yang dikembalikan.
- **Laporan**: Terdapat fitur Kartu Stok untuk melacak histori keluar/masuk barang.

## Tech Stack

- **Backend**: PHP 8.x (Native OOP)
- **Database**: MySQL (Menggunakan Views & Stored Procedures)
- **Frontend**: HTML, CSS, Bootstrap 5

## Cara Menjalankan Project (Local)

Project ini sangat mudah dijalankan menggunakan XAMPP atau Laragon.

1. **Import Database**
   - Buat database baru di phpMyAdmin dengan nama `db_inventori_baru`.
   - Import file `db_inventori_baru.sql` yang ada di dalam folder `database/` ke dalam database tersebut.

2. **Jalankan Aplikasi**
   - Letakkan folder project ini di dalam folder `htdocs` (XAMPP) atau `www` (Laragon).
   - Pastikan konfigurasi username dan password database di file `config/DBConnection.php` sudah sesuai dengan komputer Anda (defaultnya user: `root`, password kosong).
   - Akses via browser: `http://localhost/pbd_project_copy/views/login.php`

---
*Silakan clone dan pelajari project ini jika dirasa bermanfaat.*
