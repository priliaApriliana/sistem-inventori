USE db_inventori_baru;

-- 1. Tabel satuan
CREATE TABLE satuan (
    idsatuan CHAR (10) PRIMARY KEY,
    nama_satuan VARCHAR(45) NOT NULL,
    status TINYINT NOT NULL
);

INSERT INTO satuan (idsatuan, nama_satuan, status) VALUES
('S001', 'Unit', 1),
('S002', 'Botol', 1),
('S003', 'Sachet', 1),
('S004', 'Pack', 1),
('S005', 'Dus', 1);
SELECT * FROM satuan;

-- 2. Tabel vendor
CREATE TABLE vendor (
    idvendor CHAR (10) PRIMARY KEY,
    nama_vendor VARCHAR(100) NOT NULL,
    badan_hukum CHAR(1) NOT NULL,
    status CHAR(1) NOT NULL
);

INSERT INTO vendor (idvendor, nama_vendor, badan_hukum, status) VALUES
('V001', 'PT Indofood Sukses Makmur', 'Y', 'A'),
('V002', 'PT Unilever Indonesia', 'Y', 'A'),
('V003', 'CV Maju Bersama', 'N', 'A'),
('V004', 'PT Mayora Indah', 'Y', 'A'),
('V005', 'CV Sejahtera Mandiri', 'N', 'A');
SELECT * FROM vendor;

-- 3. Tabel role
CREATE TABLE role (
    idrole CHAR (10) PRIMARY KEY,
    nama_role VARCHAR(100) NOT NULL
);

INSERT INTO role (idrole, nama_role) VALUES
('R001', 'Super Admin'),
('R002', 'Admin Penjualan');
SELECT * FROM role;

-- 4. Tabel user
CREATE TABLE user (
    iduser CHAR (10) PRIMARY KEY,
    username VARCHAR(45) NOT NULL,
    password VARCHAR(100) NOT NULL,
    idrole CHAR (10) NOT NULL,
    FOREIGN KEY (idrole) REFERENCES role(idrole)
);

INSERT INTO user (iduser, username, password, idrole) VALUES
('U001', 'superadmin', 'superadmin123', 'R001'),
('U002', 'admin', 'admin123', 'R002');
SELECT * FROM user;

-- 5. Tabel barang
CREATE TABLE barang (
    idbarang CHAR (10) PRIMARY KEY,
    jenis CHAR(1) NOT NULL,
    nama VARCHAR(45) NOT NULL,
    idsatuan CHAR (10) NOT NULL,
    status TINYINT NOT NULL,
    harga INT NOT NULL,
    FOREIGN KEY (idsatuan) REFERENCES satuan(idsatuan)
);

INSERT INTO barang (idbarang, jenis, nama, idsatuan, status, harga) VALUES
('B001', 'F', 'Indomie Goreng', 'S003', 1, 3500),
('B002', 'F', 'Aqua 600ml', 'S002', 1, 5000),
('B003', 'F', 'Teh Botol Sosro 350ml', 'S002', 1, 6000),
('B004', 'H', 'Sabun Lifebuoy 70gr', 'S001', 1, 4500),
('B005', 'H', 'Shampoo Sunsilk 170ml', 'S002', 1, 18000),
('B006', 'F', 'Roti Sari Roti Tawar', 'S001', 1, 15000),
('B007', 'S', 'Pulpen Standard AE7', 'S001', 1, 4000),
('B008', 'S', 'Buku Tulis 58 Lembar', 'S001', 1, 8000),
('B009', 'C', 'Detergen Rinso 800gr', 'S004', 1, 22000),
('B010', 'C', 'Minyak Goreng Bimoli 1L', 'S002', 1, 20000);
SELECT * FROM barang;

-- 6. Tabel margin_penjualan
CREATE TABLE margin_penjualan (
    idmargin_penjualan CHAR (10) PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    persen DOUBLE NOT NULL,
    status TINYINT NOT NULL,
    iduser CHAR (10) NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (iduser) REFERENCES user(iduser)
);

INSERT INTO margin_penjualan (idmargin_penjualan, persen, status, iduser) VALUES
('M001', 5.0, 1, 'U001'),
('M002', 10.0, 1, 'U001'),
('M003', 15.0, 1, 'U002');
SELECT * FROM margin_penjualan;

-- 7. Tabel pengadaan
CREATE TABLE pengadaan (
    idpengadaan INT auto_increment PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_iduser CHAR (10) NOT NULL,
    status CHAR(1) NOT NULL DEFAULT 'P',
    vendor_idvendor CHAR (10) NOT NULL,
    subtotal_nilai INT NOT NULL,
    ppn INT NOT NULL,
    total_nilai INT NOT NULL,
    FOREIGN KEY (user_iduser) REFERENCES user(iduser),
    FOREIGN KEY (vendor_idvendor) REFERENCES vendor(idvendor)
);
DESCRIBE pengadaan;
-- 8. Tabel detail_pengadaan
CREATE TABLE detail_pengadaan (
    iddetail_pengadaan INT AUTO_INCREMENT PRIMARY KEY,
    harga_satuan INT NOT NULL,
    jumlah INT NOT NULL,
    sub_total INT NOT NULL,
    idbarang CHAR (10) NOT NULL,
    idpengadaan INT NOT NULL,
    FOREIGN KEY (idbarang) REFERENCES barang(idbarang),
    FOREIGN KEY (idpengadaan) REFERENCES pengadaan(idpengadaan)
);
DESCRIBE detail_pengadaan;
-- 9. Tabel penerimaan
CREATE TABLE penerimaan (
    idpenerimaan INT AUTO_INCREMENT PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status CHAR(1) NOT NULL DEFAULT 'P',
    idpengadaan INT NOT NULL,
    iduser CHAR (10) NOT NULL,
    FOREIGN KEY (idpengadaan) REFERENCES pengadaan(idpengadaan),
    FOREIGN KEY (iduser) REFERENCES user(iduser)
);
DESCRIBE penerimaan;
-- 10 detail_penerimaan
CREATE TABLE detail_penerimaan (
    iddetail_penerimaan INT AUTO_INCREMENT PRIMARY KEY,
    idpenerimaan INT NOT NULL,
    barang_idbarang CHAR (10) NOT NULL,
    jumlah_terima INT NOT NULL,
    harga_satuan_terima INT NOT NULL,
    sub_total_terima INT NOT NULL,
    FOREIGN KEY (idpenerimaan) REFERENCES penerimaan(idpenerimaan),
    FOREIGN KEY (barang_idbarang) REFERENCES barang(idbarang)
);
DESCRIBE detail_penerimaan;
-- 11. Tabel retur_barang 
CREATE TABLE retur_barang (
    idretur INT AUTO_INCREMENT PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    idpenerimaan INT NOT NULL,
    iduser CHAR (10) NOT NULL,
    FOREIGN KEY (idpenerimaan) REFERENCES penerimaan(idpenerimaan),
    FOREIGN KEY (iduser) REFERENCES user(iduser)
);
DESCRIBE retur_barang;
CREATE TABLE detail_retur (
    iddetail_retur CHAR (10) PRIMARY KEY,
    jumlah INT NOT NULL,
    alasan VARCHAR(200) NOT NULL,
    idretur INT NOT NULL,
    iddetail_penerimaan INT NOT NULL,
    FOREIGN KEY (idretur) REFERENCES retur_barang(idretur),
    FOREIGN KEY (iddetail_penerimaan) REFERENCES detail_penerimaan(iddetail_penerimaan)
);
DESCRIBE detail_retur;
CREATE TABLE penjualan (
    idpenjualan CHAR (10) PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    subtotal_nilai INT NOT NULL,
    ppn INT NOT NULL,
    total_nilai INT NOT NULL,
    iduser CHAR (10) NOT NULL,
    idmargin_penjualan CHAR (10) NOT NULL,
    FOREIGN KEY (iduser) REFERENCES user(iduser),
    FOREIGN KEY (idmargin_penjualan) REFERENCES margin_penjualan(idmargin_penjualan)
);
DESCRIBE penjualan;

CREATE TABLE detail_penjualan (
    iddetail_penjualan INT AUTO_INCREMENT PRIMARY KEY,
    harga_satuan INT NOT NULL,
    jumlah INT NOT NULL,
    subtotal INT NOT NULL,
    penjualan_idpenjualan CHAR (10) NOT NULL,
    idbarang CHAR (10) NOT NULL,
    FOREIGN KEY (penjualan_idpenjualan) REFERENCES penjualan(idpenjualan),
    FOREIGN KEY (idbarang) REFERENCES barang(idbarang)
);
DESCRIBE detail_penjualan;
CREATE TABLE kartu_stok (
    idkartu_stok INT AUTO_INCREMENT PRIMARY KEY,
    jenis_transaksi CHAR(1) NOT NULL,
    masuk INT NOT NULL,
    keluar INT NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    idtransaksi VARCHAR(20) NOT NULL,
    idbarang CHAR (10) NOT NULL,
    FOREIGN KEY (idbarang) REFERENCES barang(idbarang)
);
DESCRIBE kartu_stok;

-- Jenis Transaksi: 'M' = Masuk, 'K' = Keluar

-- yg transaksi blm aku insert semua -----------------------------------------

-- table view -----------------------------------------------------------------------------
-- 1. View All Satuan (Semua data aktif dan tidak aktif)
CREATE OR REPLACE VIEW v_satuan_all AS
SELECT 
    idsatuan AS kode_satuan,
    nama_satuan,
    CASE 
        WHEN status = 1 THEN 'Aktif'
        ELSE 'Nonaktif'
    END AS status_satuan
FROM satuan
ORDER BY nama_satuan;

-- 2 View Satuan Aktif (status = 1)
CREATE OR REPLACE VIEW v_satuan_aktif AS
SELECT 
    idsatuan AS kode_satuan,
    nama_satuan,
    'Aktif' AS status_satuan
FROM satuan
WHERE status = 1
ORDER BY nama_satuan;


-- 3. View All Vendor (Semua data aktif dan tidak aktif)
CREATE OR REPLACE VIEW v_vendor_all AS
SELECT 
    idvendor AS kode_vendor,
    nama_vendor,
    badan_hukum,
    CASE 
        WHEN badan_hukum = 'Y' THEN 'Ya (Berbadan Hukum)'
        ELSE 'Tidak (Non badan Hukum)'
    END AS jenis_vendor,
    status,
    CASE 
        WHEN status = 'A' THEN 'Aktif'
        ELSE 'Nonaktif'
    END AS status_vendor
FROM vendor
ORDER BY nama_vendor;

-- 4. View Vendor Aktif (status = 'A')
CREATE OR REPLACE VIEW v_vendor_aktif AS
SELECT 
    idvendor AS kode_vendor,
    nama_vendor,
    badan_hukum,
    CASE 
        WHEN badan_hukum = 'Y' THEN 'Ya (Berbadan Hukum)'
        ELSE 'Tidak (Non Badan Hukum)'
    END AS jenis_vendor,
    status,
    'Aktif' AS status_vendor
FROM vendor
WHERE status = 'A'
ORDER BY nama_vendor;

-- 5. View All Barang (Semua data aktif dan tidak aktif)
CREATE OR REPLACE VIEW v_barang_all AS
SELECT 
    b.idbarang AS kode_barang,
    b.nama AS nama_barang,
    s.nama_satuan AS satuan,
    b.harga AS harga_satuan,
    b.jenis,
    CASE 
        WHEN b.jenis = 'F' THEN 'Food & Beverage'
        WHEN b.jenis = 'H' THEN 'Health & Beauty'
        WHEN b.jenis = 'S' THEN 'Stationary'
        WHEN b.jenis = 'C' THEN 'Cleaning & Household'
        ELSE 'Lainnya'
    END AS kategori,
    b.status,
    CASE 
        WHEN b.status = 1 THEN 'Aktif'
        ELSE 'Nonaktif'
    END AS status_barang
FROM barang b
INNER JOIN satuan s ON b.idsatuan = s.idsatuan
ORDER BY b.nama;

-- 6. View Barang Aktif (status = 1)
CREATE OR REPLACE VIEW v_barang_aktif AS
SELECT 
    b.idbarang AS kode_barang,
	b.nama AS nama_barang,
    s.nama_satuan AS satuan,
    b.harga AS harga_satuan,
    b.jenis,
    CASE 
        WHEN b.jenis = 'F' THEN 'Food & Beverage'
        WHEN b.jenis = 'H' THEN 'Health & Beauty'
        WHEN b.jenis = 'S' THEN 'Stationary'
        WHEN b.jenis = 'C' THEN 'Cleaning & Household'
        ELSE 'Lainnya'
    END AS kategori,
    b.status,
    'Aktif' AS status_barang
FROM barang b
INNER JOIN satuan s ON b.idsatuan = s.idsatuan
WHERE b.status = 1
ORDER BY b.nama;

-- 7. View All Margin Penjualan (Semua data aktif dan tidak aktif)
DROP VIEW IF EXISTS v_margin_penjualan_all;
CREATE OR REPLACE VIEW v_margin_penjualan_all AS
SELECT 
    mp.idmargin_penjualan AS kode_margin,
    mp.iduser,                                -- 💥 WAJIB
    u.username AS dibuat_oleh,
    mp.persen AS persen_margin,
    mp.status,
    CASE 
        WHEN mp.status = 1 THEN 'Aktif'
        ELSE 'Nonaktif'
    END AS status_margin,
    DATE(mp.created_at) AS tanggal_dibuat,
    DATE(mp.updated_at) AS tanggal_diupdate
FROM margin_penjualan mp
INNER JOIN user u ON mp.iduser = u.iduser
ORDER BY mp.created_at DESC;

-- 8. View Margin Penjualan Aktif (status = 1)
DROP VIEW IF EXISTS v_margin_penjualan_aktif;
CREATE OR REPLACE VIEW v_margin_penjualan_aktif AS
SELECT 
    mp.idmargin_penjualan AS kode_margin,
    mp.iduser,                                -- 💥 WAJIB
    u.username AS dibuat_oleh,
    mp.persen AS persen_margin,
    DATE(mp.created_at) AS tanggal_dibuat,
    DATE(mp.updated_at) AS tanggal_diupdate,
    mp.status,
    'Aktif' AS status_margin
FROM margin_penjualan mp
INNER JOIN user u ON mp.iduser = u.iduser
WHERE mp.status = 1
ORDER BY mp.created_at DESC;

-- 9. View All Role
CREATE OR REPLACE VIEW v_role AS
SELECT 
    idrole AS kode_role,
    nama_role
FROM role
ORDER BY nama_role;

-- 10. View All User dengan join ke role
CREATE OR REPLACE VIEW v_user AS
SELECT 
    u.iduser AS kode_user,
    u.username,
    u.password,
    u.idrole,
    r.nama_role AS role
FROM user u
INNER JOIN role r ON u.idrole = r.idrole
ORDER BY r.nama_role, u.username;

-- 11 Menampilkan riwayat transaksi stok (log detail) bisa banyak baris untuk 1 barang
DROP VIEW IF EXISTS v_kartu_stok_detail;
CREATE OR REPLACE VIEW v_kartu_stok_detail AS
SELECT 
    ks.idkartu_stok AS idstok,
    ks.created_at AS tanggal,
    b.idbarang,
    b.nama AS nama_barang,
    s.nama_satuan,
    CASE 
        WHEN ks.jenis_transaksi = 'P' THEN 'Penerimaan'
        WHEN ks.jenis_transaksi = 'J' THEN 'Penjualan'
        WHEN ks.jenis_transaksi = 'R' THEN 'Retur Barang'
        ELSE 'Transaksi Lain'
    END AS transaksi,
    ks.masuk,
    ks.keluar,
    ks.stock AS stok_akhir
FROM kartu_stok ks
JOIN barang b ON ks.idbarang = b.idbarang
JOIN satuan s ON b.idsatuan = s.idsatuan;


-- 12. menampilkan penerimaan all
CREATE OR REPLACE VIEW v_penerimaan_all AS
SELECT 
    p.idpenerimaan AS kode_penerimaan,
    pg.idpengadaan AS kode_pengadaan,
    v.nama_vendor AS vendor,
    u.username AS petugas,
    p.status,
    CASE 
        WHEN p.status = 'P' THEN 'Pending'
        WHEN p.status = 'S' THEN 'Selesai'
        WHEN p.status = 'R' THEN 'Revisi'
        WHEN p.status = 'C' THEN 'Batal'
        ELSE 'Tidak Diketahui'
    END AS status_penerimaan,
    DATE_FORMAT(p.created_at, '%d-%m-%Y %H:%i') AS tanggal_penerimaan
FROM penerimaan p
INNER JOIN pengadaan pg ON p.idpengadaan = pg.idpengadaan
INNER JOIN vendor v ON pg.vendor_idvendor = v.idvendor
INNER JOIN user u ON p.iduser = u.iduser;

-- 13.
CREATE OR REPLACE VIEW v_penerimaan_aktif AS
SELECT * FROM v_penerimaan_all WHERE status = 'S';

-- 14.
CREATE OR REPLACE VIEW v_penerimaan_nonaktif AS
SELECT * FROM v_penerimaan_all WHERE status <> 'A';

-- 15. View Semua Pengadaan (All)
DROP VIEW IF EXISTS v_pengadaan_all;
CREATE OR REPLACE VIEW v_pengadaan_all AS
SELECT 
    p.idpengadaan AS kode_pengadaan,
    DATE(p.timestamp) AS tanggal_pengadaan,
    v.idvendor AS kode_vendor,
    v.nama_vendor,
    u.username AS petugas,
    p.subtotal_nilai,
    p.ppn,
    p.total_nilai,
    p.status,
    CASE 
        WHEN p.status = 'P' THEN 'Pending'
        WHEN p.status = 'S' THEN 'Selesai'
        WHEN p.status = 'R' THEN 'Revisi'
        WHEN p.status = 'C' THEN 'Cancel'
        ELSE CONCAT('Status tidak dikenali (', p.status, ')')
    END AS status_pengadaan
FROM pengadaan p
INNER JOIN vendor v ON p.vendor_idvendor = v.idvendor
INNER JOIN user u ON p.user_iduser = u.iduser
ORDER BY p.timestamp DESC;
SELECT idpengadaan, status FROM pengadaan;


-- 16. View Pengadaan yang berstatus pending saja //tidak dipake
CREATE OR REPLACE VIEW v_pengadaan_pending AS
SELECT 
    p.idpengadaan AS kode_pengadaan,
    DATE(p.timestamp) AS tanggal_pengadaan,
    v.nama_vendor,
    u.username AS petugas,
    p.subtotal_nilai,
    p.ppn,
    p.total_nilai,
    p.status,
    'Pending' AS status_pengadaan
FROM pengadaan p
JOIN vendor v ON p.vendor_idvendor = v.idvendor
JOIN user u ON p.user_iduser = u.iduser
WHERE p.status = 'P'
ORDER BY p.timestamp DESC;


-- 17. view penjualan all
CREATE OR REPLACE VIEW v_penjualan_all AS
SELECT 
    p.idpenjualan,
    p.created_at AS tanggal,
    u.username AS kasir,
    p.subtotal_nilai AS subtotal,
    p.ppn AS nilai_ppn,
    10 AS ppn_persen,                
    p.total_nilai AS total
FROM penjualan p
JOIN user u ON u.iduser = p.iduser
ORDER BY p.idpenjualan DESC;

-- 18. view detail penjualan // ga dipake
CREATE OR REPLACE VIEW v_detail_penjualan AS
SELECT
    dp.iddetail_penjualan,
    dp.penjualan_idpenjualan AS idpenjualan,
    dp.idbarang,
    b.nama AS nama_barang,
    dp.jumlah,
    dp.harga_satuan,
    dp.subtotal
FROM detail_penjualan dp
JOIN barang b ON b.idbarang = dp.idbarang
ORDER BY dp.iddetail_penjualan DESC;

-- 19. view retur barang
CREATE OR REPLACE VIEW v_retur_all AS
SELECT 
    r.idretur,
    r.created_at AS tanggal,
    r.idpenerimaan,
    u.username AS petugas
FROM retur_barang r
JOIN user u ON u.iduser = r.iduser
ORDER BY r.idretur DESC;

-- 20. view 
CREATE OR REPLACE VIEW v_retur_detail AS
SELECT 
    dr.iddetail_retur,
    dr.idretur,
    b.idbarang,
    b.nama AS nama_barang,
    dr.jumlah,
    dr.alasan,
    r.created_at AS tanggal
FROM detail_retur dr
JOIN retur_barang r ON r.idretur = dr.idretur
JOIN detail_penerimaan dp ON dr.iddetail_penerimaan = dp.iddetail_penerimaan
JOIN barang b ON dp.barang_idbarang = b.idbarang
ORDER BY dr.iddetail_retur DESC;










-- funtion ----------------------------------------------------------
-- Function 1: Hitung Subtotal (harga 1 satuan x jumlah)
DELIMITER $$
CREATE FUNCTION fn_hitung_subtotal(
    p_harga_satuan INT,
    p_jumlah INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_subtotal INT;
    SET v_subtotal = p_harga_satuan * p_jumlah;
    RETURN v_subtotal;
END$$
DELIMITER ;

-- Function 2: Hitung pajak PPN 10% dari subtotal
DELIMITER $$
CREATE FUNCTION fn_hitung_ppn(p_subtotal INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_ppn INT;
    SET v_ppn = ROUND(p_subtotal * 0.10);
    RETURN v_ppn;
END$$
DELIMITER ;

-- Function 3: Hitung Total (Subtotal + PPN = total akhir)
DELIMITER $$
CREATE FUNCTION fn_hitung_total(
    p_subtotal INT,
    p_ppn INT
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_total INT;
    SET v_total = p_subtotal + p_ppn;
    RETURN v_total;
END$$
DELIMITER ;


-- Function 4: Cek Stok Barang
DELIMITER $$
CREATE FUNCTION fn_cek_stok_barang(p_idbarang CHAR(10))
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE v_stok INT DEFAULT 0;

    SELECT COALESCE(stock, 0)
    INTO v_stok
    FROM kartu_stok
    WHERE idbarang = p_idbarang
    ORDER BY idkartu_stok DESC
    LIMIT 1;

    RETURN v_stok;
END$$
DELIMITER ;

ALTER TABLE kartu_stok 
MODIFY stock INT NOT NULL DEFAULT 0;


-- Function 5: Hitung Harga Jual (Harga Modal + Margin%)
DELIMITER $$
CREATE FUNCTION fn_hitung_harga_jual(
    p_harga_modal INT,
    p_persen_margin DOUBLE
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_harga_jual INT;
    SET v_harga_jual = ROUND(p_harga_modal + (p_harga_modal * p_persen_margin / 100));
    RETURN v_harga_jual;
END$$
DELIMITER ;


-- Function 6: Generate ID Penjualan Otomatis
DELIMITER $$
CREATE FUNCTION fn_generate_id_penjualan()
RETURNS CHAR(10)
DETERMINISTIC
BEGIN
    DECLARE v_last_number INT;
    DECLARE v_new_id CHAR(10);
    
    SELECT COALESCE(MAX(CAST(SUBSTRING(idpenjualan, 3) AS UNSIGNED)), 0) INTO v_last_number
    FROM penjualan;
    
    SET v_new_id = CONCAT('PJ', LPAD(v_last_number + 1, 3, '0'));
    
    RETURN v_new_id;
END$$
DELIMITER ;

-- 6. bisa dipakai untuk laporan stok akhir tanpa lihat view
DELIMITER $$
CREATE FUNCTION fn_total_stok_barang(p_idbarang CHAR(10))
RETURNS INT
READS SQL DATA
DETERMINISTIC   		-- artinya untuk input yang sama hasilnya selalu sama
BEGIN
  DECLARE v_total INT;
  SELECT SUM(masuk - keluar) INTO v_total
  FROM kartu_stok WHERE idbarang = p_idbarang;
  RETURN IFNULL(v_total,0);
END$$
DELIMITER ;




-- STORED PROCEDURES UNTUK FORM PENGADAAN ------------------------------------

-- SP 1: Update Total Pengadaan ---------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE sp_update_total_pengadaan(
    IN p_idpengadaan INT
)
BEGIN
    DECLARE v_subtotal INT;
    DECLARE v_ppn INT;
    DECLARE v_total INT;
    
    -- Hitung subtotal dari semua detail
    SELECT COALESCE(SUM(sub_total), 0) INTO v_subtotal
    FROM detail_pengadaan
    WHERE idpengadaan = p_idpengadaan;
    
    -- Hitung PPN 10% menggunakan function
    SET v_ppn = fn_hitung_ppn(v_subtotal);
    
    -- Hitung total
    SET v_total = fn_hitung_total(v_subtotal, v_ppn);
    
    -- Update tabel pengadaan
    UPDATE pengadaan
    SET subtotal_nilai = v_subtotal,
        ppn = v_ppn,
        total_nilai = v_total
    WHERE idpengadaan = p_idpengadaan;
END$$
DELIMITER ;

-- SP 2: Get Vendor Aktif untuk Dropdown
DROP PROCEDURE IF EXISTS sp_get_vendor_dropdown$$
DELIMITER $$
CREATE PROCEDURE sp_get_vendor_dropdown()
BEGIN
    SELECT 
        idvendor,
        nama_vendor,
        CONCAT(idvendor, ' - ', nama_vendor) AS display_text
    FROM vendor
    WHERE status = 'A'
    ORDER BY nama_vendor ASC;
END$$
DELIMITER ;


-- SP 3: Get Barang Aktif untuk Dropdown
DROP PROCEDURE IF EXISTS sp_get_barang_dropdown$$
DELIMITER $$
CREATE PROCEDURE sp_get_barang_dropdown()
BEGIN
    SELECT 
        b.idbarang,
        b.nama,
        s.nama_satuan,
        b.harga,
        CONCAT(b.idbarang, ' - ', b.nama, ' (', s.nama_satuan, ') - Rp ', FORMAT(b.harga, 0)) AS display_text
    FROM barang b
    INNER JOIN satuan s ON b.idsatuan = s.idsatuan
    WHERE b.status = 1
    ORDER BY b.nama ASC;
END$$
DELIMITER ;


-- STORED PROCEDURES UNTUK FORM PENERIMAAN ------------------------------------------------

-- 4 sp buat nampiin pengadaan (hanya status pending) di dropdown saat melakukan transaksi penerimaan 
DROP PROCEDURE IF EXISTS sp_get_pengadaan_dropdown;
DELIMITER $$
CREATE PROCEDURE sp_get_pengadaan_dropdown()
BEGIN
    SELECT 
        p.idpengadaan,
        CONCAT('Pengadaan #', p.idpengadaan, ' - ', v.nama_vendor) AS display_text
    FROM pengadaan p
    JOIN vendor v ON v.idvendor = p.vendor_idvendor
    WHERE p.status = 'P'   -- hanya pengadaan Pending yang bisa diterima
    ORDER BY p.idpengadaan DESC;
END$$
DELIMITER ;


-- SP 5: Get Detail Pengadaan untuk Form Penerimaan
DROP PROCEDURE IF EXISTS sp_get_detail_pengadaan;
DELIMITER $$
CREATE PROCEDURE sp_get_detail_pengadaan(IN p_idpengadaan INT)
BEGIN
    SELECT 
        dp.iddetail_pengadaan,
        dp.idbarang,
        b.nama AS nama_barang,
        s.nama_satuan,
        dp.harga_satuan,

        -- jumlah yg dipesan
        dp.jumlah AS jumlah_dipesan,

        -- jumlah yg sudah diterima ( SUM semua penerimaan sebelumnya )
        COALESCE((
            SELECT SUM(dpen.jumlah_terima)
            FROM detail_penerimaan dpen
            JOIN penerimaan p ON p.idpenerimaan = dpen.idpenerimaan
            WHERE p.idpengadaan = dp.idpengadaan
              AND dpen.barang_idbarang = dp.idbarang
        ), 0) AS jumlah_sudah_terima,

        -- sisa yg boleh diterima
        (dp.jumlah - COALESCE((
            SELECT SUM(dpen.jumlah_terima)
            FROM detail_penerimaan dpen
            JOIN penerimaan p ON p.idpenerimaan = dpen.idpenerimaan
            WHERE p.idpengadaan = dp.idpengadaan
              AND dpen.barang_idbarang = dp.idbarang
        ), 0)) AS jumlah_sisa

    FROM detail_pengadaan dp
    INNER JOIN barang b ON dp.idbarang = b.idbarang
    INNER JOIN satuan s ON b.idsatuan = s.idsatuan
    WHERE dp.idpengadaan = p_idpengadaan
      AND (dp.jumlah -
          COALESCE((
                SELECT SUM(dpen.jumlah_terima)
                FROM detail_penerimaan dpen
                JOIN penerimaan p ON p.idpenerimaan = dpen.idpenerimaan
                WHERE p.idpengadaan = dp.idpengadaan
                  AND dpen.barang_idbarang = dp.idbarang
          ), 0)
      ) > 0;   -- Hanya tampilkan barang yg masih sisa
END$$
DELIMITER ;


-- 6. Ambil semua penerimaan (bisa aktif / nonaktif / all)
DROP PROCEDURE IF EXISTS sp_get_penerimaan;
DELIMITER $$
CREATE PROCEDURE sp_get_penerimaan(IN p_show VARCHAR(20))
BEGIN
    IF p_show = 'aktif' THEN
        SELECT * FROM v_penerimaan_aktif ORDER BY tanggal_penerimaan DESC;
    ELSEIF p_show = 'nonaktif' THEN
        SELECT * FROM v_penerimaan_nonaktif ORDER BY tanggal_penerimaan DESC;
    ELSE
        SELECT * FROM v_penerimaan_all ORDER BY tanggal_penerimaan DESC;
    END IF;
END$$
DELIMITER ;


-- STORED PROCEDURES UNTUK FORM PENJUALAN

-- SP 7: Get Margin Penjualan Aktif untuk Dropdown
DROP PROCEDURE IF EXISTS sp_get_margin_dropdown$$
DELIMITER $$
CREATE PROCEDURE sp_get_margin_dropdown()
BEGIN
    SELECT 
        idmargin_penjualan,
        persen,
        CONCAT('Margin ', persen, '%') AS display_text
    FROM margin_penjualan
    WHERE status = 1
    ORDER BY persen ASC;
END$$
DELIMITER ;


-- SP 8: Get Harga Jual Barang dengan Margin (menggunakan parameter OUT)
DROP PROCEDURE IF EXISTS sp_get_harga_jual$$
DELIMITER $$
CREATE PROCEDURE sp_get_harga_jual(
    IN p_idbarang CHAR(10),
    IN p_idmargin CHAR(10),
    OUT p_harga_jual INT
)
BEGIN
    DECLARE v_harga_modal INT;
    DECLARE v_persen_margin DOUBLE;
    
    -- Ambil harga modal
    SELECT harga INTO v_harga_modal
    FROM barang
    WHERE idbarang = p_idbarang;
    
    -- Ambil persen margin
    SELECT persen INTO v_persen_margin
    FROM margin_penjualan
    WHERE idmargin_penjualan = p_idmargin;
    
    -- Hitung harga jual menggunakan function
    SET p_harga_jual = fn_hitung_harga_jual(v_harga_modal, v_persen_margin);
END$$
DELIMITER ;

-- SP 9: Update Total Penjualan
DROP PROCEDURE IF EXISTS sp_update_total_penjualan$$
DELIMITER $$
CREATE PROCEDURE sp_update_total_penjualan(
    IN p_idpenjualan CHAR(10)
)
BEGIN
    DECLARE v_subtotal INT;
    DECLARE v_ppn INT;
    DECLARE v_total INT;
    
    -- Hitung subtotal dari semua detail
    SELECT COALESCE(SUM(subtotal), 0) INTO v_subtotal
    FROM detail_penjualan
    WHERE penjualan_idpenjualan = p_idpenjualan;
    
    -- Hitung PPN 10% menggunakan function
    SET v_ppn = fn_hitung_ppn(v_subtotal);
    
    -- Hitung total
    SET v_total = fn_hitung_total(v_subtotal, v_ppn);
    
    -- Update tabel penjualan
    UPDATE penjualan
    SET subtotal_nilai = v_subtotal,
        ppn = v_ppn,
        total_nilai = v_total
    WHERE idpenjualan = p_idpenjualan;
END$$
DELIMITER ;

-- SP 10: Get Barang dengan Stok untuk Penjualan
DROP PROCEDURE IF EXISTS sp_get_barang_with_stok$$
DELIMITER $$
CREATE PROCEDURE sp_get_barang_with_stok()
BEGIN
    SELECT 
        b.idbarang,
        b.nama,
        s.nama_satuan,
        b.harga,
        fn_cek_stok_barang(b.idbarang) AS stok_tersedia,
        CONCAT(b.idbarang, ' - ', b.nama, ' (Stok: ', fn_cek_stok_barang(b.idbarang), ')') AS display_text
    FROM barang b
    INNER JOIN satuan s ON b.idsatuan = s.idsatuan
    WHERE b.status = 1
    AND fn_cek_stok_barang(b.idbarang) > 0
    ORDER BY b.nama ASC;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_get_penjualan_by_id;
DELIMITER $$
CREATE PROCEDURE sp_get_penjualan_by_id(IN p_id CHAR(10))
BEGIN
    SELECT 
        p.idpenjualan,
        u.username AS petugas,
        u.username AS kasir,
        m.persen AS margin_persen,
        IFNULL(p.subtotal_nilai, 0) AS subtotal,
        IFNULL(p.ppn, 0) AS ppn,
        IFNULL(p.total_nilai, 0) AS total,
        DATE_FORMAT(p.created_at, '%d/%m/%Y %H:%i:%s') AS tanggal
    FROM penjualan p
    LEFT JOIN user u ON p.iduser = u.iduser
    LEFT JOIN margin_penjualan m ON p.idmargin_penjualan = m.idmargin_penjualan
    WHERE p.idpenjualan = p_id;
END$$
DELIMITER ;

-- STORED PROCEDURES UNTUK FORM RETUR

-- SP 11: Get Penerimaan untuk Dropdown Retur
DROP PROCEDURE IF EXISTS sp_get_penerimaan_dropdown;
DELIMITER $$
CREATE PROCEDURE sp_get_penerimaan_dropdown()
BEGIN
    SELECT 
        pen.idpenerimaan,
        pen.created_at,
        v.nama_vendor,
        CONCAT(
            'TR-', LPAD(pen.idpenerimaan, 4, '0'),
            ' - ', v.nama_vendor,
            ' - ', DATE_FORMAT(pen.created_at, '%d/%m/%Y')
        ) AS display_text
    FROM penerimaan pen
    INNER JOIN pengadaan p ON pen.idpengadaan = p.idpengadaan
    INNER JOIN vendor v ON p.vendor_idvendor = v.idvendor
    WHERE pen.status = 'S' 
    ORDER BY pen.created_at DESC;
END$$
DELIMITER ;


-- SP 12: Get Detail Penerimaan untuk Form Retur
DROP PROCEDURE IF EXISTS sp_get_detail_penerimaan$$
DELIMITER $$
CREATE PROCEDURE sp_get_detail_penerimaan(
    IN p_idpenerimaan INT
)
BEGIN
    SELECT 
        dpen.iddetail_penerimaan,
        dpen.barang_idbarang,
        b.nama AS nama_barang,
        s.nama_satuan,
        dpen.jumlah_terima,
        dpen.harga_satuan_terima,
        dpen.sub_total_terima
    FROM detail_penerimaan dpen
    INNER JOIN barang b ON dpen.barang_idbarang = b.idbarang
    INNER JOIN satuan s ON b.idsatuan = s.idsatuan
    WHERE dpen.idpenerimaan = p_idpenerimaan;
END$$
DELIMITER ;

-- 13. SP ambil detail pengadaan berdasarkan ID
DELIMITER $$
CREATE PROCEDURE sp_get_detail_pengadaan_by_id(IN p_idpengadaan INT)
BEGIN
    SELECT 
        dp.iddetail_pengadaan,
        dp.idbarang,
        b.nama AS nama_barang,
        s.nama_satuan,
        dp.harga_satuan,
        dp.jumlah,
        dp.sub_total
    FROM detail_pengadaan dp
    INNER JOIN barang b ON dp.idbarang = b.idbarang
    INNER JOIN satuan s ON b.idsatuan = s.idsatuan
    WHERE dp.idpengadaan = p_idpengadaan;
END$$
DELIMITER ;

-- 14. SP untuk otomatis menampilkan status Pending/diproses ketika kita membuat pengadaan baru
DROP PROCEDURE IF EXISTS sp_insert_pengadaan;
DELIMITER $$
CREATE PROCEDURE sp_insert_pengadaan(
    IN p_user_id CHAR(10),
    IN p_vendor_id CHAR(10),
    OUT p_idpengadaan INT
)
BEGIN
    -- status awal harus P (Pending)
    INSERT INTO pengadaan (user_iduser, status, vendor_idvendor, subtotal_nilai, ppn, total_nilai)
    VALUES (p_user_id, 'P', p_vendor_id, 0, 0, 0);

    SET p_idpengadaan = LAST_INSERT_ID();
END$$
DELIMITER ;


-- 15. 
DELIMITER $$
CREATE PROCEDURE sp_insert_detail_pengadaan(
    IN p_idpengadaan INT,
    IN p_idbarang CHAR(10),
    IN p_harga_satuan INT,
    IN p_jumlah INT
)
BEGIN
    DECLARE v_subtotal INT;
    SET v_subtotal = fn_hitung_subtotal(p_harga_satuan, p_jumlah);

    INSERT INTO detail_pengadaan (harga_satuan, jumlah, sub_total, idbarang, idpengadaan)
    VALUES (p_harga_satuan, p_jumlah, v_subtotal, p_idbarang, p_idpengadaan);

    CALL sp_update_total_pengadaan(p_idpengadaan);
END$$
DELIMITER ;

-- 16
DROP PROCEDURE IF EXISTS sp_get_user_dropdown;
DELIMITER $$
CREATE PROCEDURE sp_get_user_dropdown()
BEGIN
    SELECT 
        iduser,
        username,
        CONCAT(iduser, ' - ', username) AS display_text
    FROM user
    ORDER BY username ASC;
END$$
DELIMITER ;

-- 17
DROP PROCEDURE IF EXISTS sp_get_pengadaan_terbuka;
DELIMITER $$
CREATE PROCEDURE sp_get_pengadaan_terbuka()
BEGIN
    SELECT 
        p.idpengadaan,
        v.nama_vendor,
        p.status,
        CONCAT('PO-', LPAD(p.idpengadaan,4,'0'),' - ',v.nama_vendor) AS display_text
    FROM pengadaan p
    JOIN vendor v ON v.idvendor=p.vendor_idvendor
    WHERE p.status IN ('P','R');
END$$
DELIMITER ;

-- sp buat insert margin baru otomatis aktif yg margin lama otomatis nonaktif
DROP PROCEDURE IF EXISTS sp_insert_margin;
DELIMITER $$
CREATE PROCEDURE sp_insert_margin(
    IN p_id CHAR(10),
    IN p_persen DOUBLE,
    IN p_iduser CHAR(10)
)
BEGIN
    -- 1. Nonaktifkan semua margin lama
    UPDATE margin_penjualan SET status = 0;
    
    -- 2. Insert margin baru dengan status aktif
    INSERT INTO margin_penjualan (idmargin_penjualan, persen, iduser, status)
    VALUES (p_id, p_persen, p_iduser, 1);
END$$
DELIMITER ;

-- sp Buat Stored Procedure untuk hitung status penerimaan + pengadaan
DROP PROCEDURE IF EXISTS sp_update_status_penerimaan;
DELIMITER $$
CREATE PROCEDURE sp_update_status_penerimaan(IN p_idpenerimaan INT)
BEGIN
    DECLARE v_idpengadaan INT;
    DECLARE v_total_pesan INT;
    DECLARE v_total_terima INT;
    DECLARE v_status CHAR(1);

    -- Ambil id pengadaan dari penerimaan yang sedang diproses
    SELECT idpengadaan INTO v_idpengadaan
    FROM penerimaan
    WHERE idpenerimaan = p_idpenerimaan;

    -- Total pesan (dari detail pengadaan)
    SELECT SUM(jumlah) INTO v_total_pesan
    FROM detail_pengadaan
    WHERE idpengadaan = v_idpengadaan;

    -- Total terima (SEMUA penerimaan untuk pengadaan itu)
    SELECT SUM(dp.jumlah_terima) INTO v_total_terima
    FROM detail_penerimaan dp
    JOIN penerimaan p ON p.idpenerimaan = dp.idpenerimaan
    WHERE p.idpengadaan = v_idpengadaan;

    IF v_total_terima IS NULL THEN SET v_total_terima = 0; END IF;

    -- Tentukan status
    IF v_total_terima = 0 THEN 
        SET v_status = 'P';        -- belum terima apa-apa
    ELSEIF v_total_terima < v_total_pesan THEN
        SET v_status = 'P';        -- sebagian
    ELSEIF v_total_terima = v_total_pesan THEN
        SET v_status = 'S';        -- selesai
    ELSE
        SET v_status = 'R';        -- menerima lebih banyak
    END IF;

    -- Update SEMUA penerimaan yang terkait pengadaan tersebut
    UPDATE penerimaan
    SET status = v_status
    WHERE idpengadaan = v_idpengadaan;

    -- Update header pengadaan juga
    UPDATE pengadaan
    SET status = v_status
    WHERE idpengadaan = v_idpengadaan;

END$$
DELIMITER ;

-- sp Ini akan menghitung jumlah yang belum diterima per-barang.
DROP PROCEDURE IF EXISTS sp_get_barang_pengadaan_belum_terima;
DELIMITER $$
CREATE PROCEDURE sp_get_barang_pengadaan_belum_terima(IN p_idpengadaan INT)
BEGIN
    SELECT 
        dp.iddetail_pengadaan,
        dp.idbarang,
        b.nama AS nama_barang,
        s.nama_satuan,
        dp.harga_satuan,
        dp.jumlah AS jumlah_pesan,

        -- Total yang sudah diterima untuk barang ini
        COALESCE((
            SELECT SUM(dpen.jumlah_terima)
            FROM detail_penerimaan dpen
            JOIN penerimaan p ON p.idpenerimaan = dpen.idpenerimaan
            WHERE p.idpengadaan = p_idpengadaan
              AND dpen.barang_idbarang = dp.idbarang
        ), 0) AS total_terima,

        -- Sisa yang belum diterima
		dp.jumlah - COALESCE((
				SELECT SUM(dpr.jumlah_terima)
				FROM penerimaan pr
				JOIN detail_penerimaan dpr ON pr.idpenerimaan = dpr.idpenerimaan
				WHERE pr.idpengadaan = dp.idpengadaan
				AND dpr.barang_idbarang = dp.idbarang
			), 0) as sisa_belum_terima

    FROM detail_pengadaan dp
    JOIN barang b ON b.idbarang = dp.idbarang
    JOIN satuan s ON s.idsatuan = b.idsatuan
    WHERE dp.idpengadaan = p_idpengadaan
    HAVING sisa_belum_terima > 0;
END$$
DELIMITER ;

-- untuk mengambil data penerimaan berdasarkan ID yang buat nampilin dihalaman detail penerimaan
DROP PROCEDURE IF EXISTS sp_get_penerimaan_by_id;
DELIMITER $$
CREATE PROCEDURE sp_get_penerimaan_by_id(
    IN p_id INT
)
BEGIN
    SELECT 
        p.idpenerimaan AS kode_penerimaan,
        p.idpengadaan AS kode_pengadaan,
        v.nama_vendor AS vendor,
        u.username AS petugas,
        p.status,
        p.created_at AS tanggal_penerimaan
    FROM penerimaan p
    LEFT JOIN pengadaan pg ON p.idpengadaan = pg.idpengadaan
    LEFT JOIN vendor v ON pg.vendor_idvendor = v.idvendor
    LEFT JOIN user u ON p.iduser = u.iduser
    WHERE p.idpenerimaan = p_id;
END$$
DELIMITER ;





-- ==========================================
-- TRIGGER PENGADAAN
-- ==========================================

-- Trigger 1: BEFORE INSERT detail_pengadaan
-- Hitung subtotal otomatis menggunakan function
DROP TRIGGER IF EXISTS trg_before_insert_detail_pengadaan$$
DELIMITER $$
CREATE TRIGGER trg_before_insert_detail_pengadaan
BEFORE INSERT ON detail_pengadaan
FOR EACH ROW
BEGIN
    -- Hitung subtotal menggunakan function
    SET NEW.sub_total = fn_hitung_subtotal(NEW.harga_satuan, NEW.jumlah);
END$$
DELIMITER ;

-- Trigger 2: AFTER INSERT detail_pengadaan
-- Update total di header pengadaan menggunakan SP
DROP TRIGGER IF EXISTS trg_after_insert_detail_pengadaan$$
DELIMITER $$
CREATE TRIGGER trg_after_insert_detail_pengadaan
AFTER INSERT ON detail_pengadaan
FOR EACH ROW
BEGIN
    CALL sp_update_total_pengadaan(NEW.idpengadaan);
END$$
DELIMITER ;

-- Trigger 3: AFTER UPDATE detail_pengadaan
-- Update total di header pengadaan
DROP TRIGGER IF EXISTS trg_after_update_detail_pengadaan$$
DELIMITER $$
CREATE TRIGGER trg_after_update_detail_pengadaan
AFTER UPDATE ON detail_pengadaan
FOR EACH ROW
BEGIN
    -- Update sub_total jika ada perubahan harga atau jumlah
    IF OLD.harga_satuan <> NEW.harga_satuan OR OLD.jumlah <> NEW.jumlah THEN
        -- Update total di header
        CALL sp_update_total_pengadaan(NEW.idpengadaan);
    END IF;
END$$
DELIMITER ;

-- Trigger 4: AFTER DELETE detail_pengadaan
-- Update total di header pengadaan
DROP TRIGGER IF EXISTS trg_after_delete_detail_pengadaan$$
DELIMITER $$
CREATE TRIGGER trg_after_delete_detail_pengadaan
AFTER DELETE ON detail_pengadaan
FOR EACH ROW
BEGIN
    CALL sp_update_total_pengadaan(OLD.idpengadaan);
END$$
DELIMITER ;


-- ==========================================
-- TRIGGERS UNTUK penerimaan
-- ==========================================

-- Trigger 5: BEFORE INSERT detail_penerimaan
-- Hitung subtotal terima otomatis menggunakan function
DROP TRIGGER IF EXISTS trg_before_insert_detail_penerimaan;
DELIMITER $$
CREATE TRIGGER trg_before_insert_detail_penerimaan
BEFORE INSERT ON detail_penerimaan
FOR EACH ROW
BEGIN
    -- Hitung subtotal menggunakan function
    SET NEW.sub_total_terima = fn_hitung_subtotal(NEW.harga_satuan_terima, NEW.jumlah_terima);
END$$
DELIMITER ;

-- trg buat status di penerimaan, setelah dia menerima semua barang yang di pengadaan statusnya akan selesaai
DROP TRIGGER IF EXISTS trg_after_insert_detail_penerimaan;
DELIMITER $$
CREATE TRIGGER trg_after_insert_detail_penerimaan
AFTER INSERT ON detail_penerimaan
FOR EACH ROW
BEGIN
    DECLARE v_stok_sebelum INT DEFAULT 0;
    DECLARE v_stok_setelah INT DEFAULT 0;
	
	-- ============================
    -- 1. UPDATE STATUS PENGADAAN & PENERIMAAN
    -- ============================
    CALL sp_update_status_penerimaan(NEW.idpenerimaan);
    
	-- ============================
    -- 2. HITUNG STOK SEBELUM
    -- ============================
    -- Ambil stok sebelumnya, kalau NULL → 0
    SELECT COALESCE(
        (SELECT stock 
         FROM kartu_stok 
         WHERE idbarang = NEW.barang_idbarang
         ORDER BY idkartu_stok DESC
         LIMIT 1), 0)
    INTO v_stok_sebelum;

    -- ============================
    -- 3. UPDATE STOK SETELAH PENERIMAAN (MASUK)
    -- ============================
    -- Hitung stok setelah penerimaan
    SET v_stok_setelah = v_stok_sebelum + NEW.jumlah_terima;

    -- Insert record kartu stok
    INSERT INTO kartu_stok (
        jenis_transaksi,
        masuk,
        keluar,
        stock,
        created_at,
        idtransaksi,
        idbarang
    )
    VALUES (
        'P',                   -- Penerimaan
        NEW.jumlah_terima,    -- jumlah masuk
        0,                    -- keluar
        v_stok_setelah,       -- stok akhir
        NOW(),
        NEW.idpenerimaan,
        NEW.barang_idbarang
    );
END$$
DELIMITER ;









-- ==========================================
-- TRIGGERS UNTUK FORM RETUR
-- ==========================================

-- Trigger 9: AFTER INSERT detail_retur
-- Insert ke kartu_stok (Barang KELUAR karena retur) menggunakan OLD dan NEW
DROP TRIGGER IF EXISTS trg_after_insert_detail_retur;
DELIMITER $$
CREATE TRIGGER trg_after_insert_detail_retur
AFTER INSERT ON detail_retur
FOR EACH ROW
BEGIN
    DECLARE v_idbarang CHAR(10);
    DECLARE v_stok_sebelum INT;
    DECLARE v_stok_setelah INT;

    -- Ambil idbarang dari detail_penerimaan
    SELECT barang_idbarang INTO v_idbarang
    FROM detail_penerimaan
    WHERE iddetail_penerimaan = NEW.iddetail_penerimaan;

    -- Cek stok sebelumnya
    SET v_stok_sebelum = fn_cek_stok_barang(v_idbarang);

    -- Hitung stok setelah retur (stok berkurang)
    SET v_stok_setelah = v_stok_sebelum - IFNULL(NEW.jumlah, 0);

    -- Insert ke kartu_stok → transaksi Retur Barang
    INSERT INTO kartu_stok (
        jenis_transaksi, masuk, keluar, stock, idtransaksi, idbarang, created_at
    )
    VALUES (
        'R',
        0,
        NEW.jumlah,
        v_stok_setelah,
        NEW.idretur,
        v_idbarang,
        NOW()
    );
END$$
DELIMITER ;


-- ==========================================
-- TRIGGERS UNTUK FORM PENJUALAN
-- ==========================================

-- Trigger 10: BEFORE INSERT detail_penjualan
-- Validasi stok dan hitung subtotal menggunakan OLD dan NEW
DROP TRIGGER IF EXISTS trg_before_insert_detail_penjualan$$
DELIMITER $$
CREATE TRIGGER trg_before_insert_detail_penjualan
BEFORE INSERT ON detail_penjualan
FOR EACH ROW
BEGIN
    DECLARE v_stok_tersedia INT;
    
    -- Cek stok menggunakan function
    SET v_stok_tersedia = fn_cek_stok_barang(NEW.idbarang);
    
    -- Validasi stok
    IF v_stok_tersedia < NEW.jumlah THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stok tidak mencukupi untuk penjualan!';
    END IF;
    
    -- Hitung subtotal menggunakan function
    SET NEW.subtotal = fn_hitung_subtotal(NEW.harga_satuan, NEW.jumlah);
END$$
DELIMITER ;

-- Trigger 11: AFTER INSERT detail_penjualan
-- Kurangi stok dan update total penjualan menggunakan OLD dan NEW
DROP TRIGGER IF EXISTS trg_after_insert_detail_penjualan;
DELIMITER $$
CREATE TRIGGER trg_after_insert_detail_penjualan
AFTER INSERT ON detail_penjualan
FOR EACH ROW
BEGIN
    DECLARE v_stok_sebelum INT;
    DECLARE v_stok_setelah INT;

    -- Ambil stok sebelum
    SET v_stok_sebelum = fn_cek_stok_barang(NEW.idbarang);

    -- Hitung stok setelah penjualan (stok berkurang)
    SET v_stok_setelah = v_stok_sebelum - NEW.jumlah;

    -- Insert ke kartu_stok → transaksi Penjualan
    INSERT INTO kartu_stok (
        jenis_transaksi, masuk, keluar, stock, idtransaksi, idbarang, created_at
    )
    VALUES (
        'J',
        0,
        NEW.jumlah,
        v_stok_setelah,
        NEW.penjualan_idpenjualan,
        NEW.idbarang,
        NOW()
    );
    -- Update total penjualan
    CALL sp_update_total_penjualan(NEW.penjualan_idpenjualan);
END$$
DELIMITER ;


-- Trigger 12: AFTER UPDATE detail_penjualan
-- Update total penjualan menggunakan OLD dan NEW
DROP TRIGGER IF EXISTS trg_after_update_detail_penjualan$$
DELIMITER $$
CREATE TRIGGER trg_after_update_detail_penjualan
AFTER UPDATE ON detail_penjualan
FOR EACH ROW
BEGIN
    -- Hanya update jika ada perubahan harga atau jumlah
    IF OLD.harga_satuan <> NEW.harga_satuan OR OLD.jumlah <> NEW.jumlah THEN
        -- Update total
        CALL sp_update_total_penjualan(NEW.penjualan_idpenjualan);
    END IF;
END$$
DELIMITER ;

-- Trigger 13: AFTER DELETE detail_penjualan
-- Update total penjualan menggunakan OLD dan NEW
DROP TRIGGER IF EXISTS trg_after_delete_detail_penjualan$$
DELIMITER $$
CREATE TRIGGER trg_after_delete_detail_penjualan
AFTER DELETE ON detail_penjualan
FOR EACH ROW
BEGIN
    CALL sp_update_total_penjualan(OLD.penjualan_idpenjualan);
END$$
DELIMITER ;

-- ==========================================
-- TRIGGERS UNTUK margin penjualan
-- ==========================================

-- -------------ini yg aslinya di trg_db_inventori_baru aku taruh diawah ini , nanti mau saya rapikan --------------------------------------------------------------------------------------------------------------------------------------
-- TRIGGERS UNTUK FORM PENGADAAN -----------------------------------------

-- Trigger 1: BEFORE INSERT detail_pengadaan
-- Hitung subtotal otomatis menggunakan function
DROP TRIGGER IF EXISTS trg_before_insert_detail_pengadaan$$
DELIMITER $$
CREATE TRIGGER trg_before_insert_detail_pengadaan
BEFORE INSERT ON detail_pengadaan
FOR EACH ROW
BEGIN
    -- Hitung subtotal menggunakan function
    SET NEW.sub_total = fn_hitung_subtotal(NEW.harga_satuan, NEW.jumlah);
END$$
DELIMITER ;

-- Trigger 2: AFTER INSERT detail_pengadaan
-- Update total di header pengadaan menggunakan SP
DROP TRIGGER IF EXISTS trg_after_insert_detail_pengadaan$$
DELIMITER $$
CREATE TRIGGER trg_after_insert_detail_pengadaan
AFTER INSERT ON detail_pengadaan
FOR EACH ROW
BEGIN
    CALL sp_update_total_pengadaan(NEW.idpengadaan);
END$$
DELIMITER ;

-- Trigger 3: AFTER UPDATE detail_pengadaan
-- Update total di header pengadaan
DROP TRIGGER IF EXISTS trg_after_update_detail_pengadaan$$
DELIMITER $$
CREATE TRIGGER trg_after_update_detail_pengadaan
AFTER UPDATE ON detail_pengadaan
FOR EACH ROW
BEGIN
    -- Update sub_total jika ada perubahan harga atau jumlah
    IF OLD.harga_satuan <> NEW.harga_satuan OR OLD.jumlah <> NEW.jumlah THEN
        -- Update total di header
        CALL sp_update_total_pengadaan(NEW.idpengadaan);
    END IF;
END$$
DELIMITER ;

-- Trigger 4: AFTER DELETE detail_pengadaan
-- Update total di header pengadaan
DROP TRIGGER IF EXISTS trg_after_delete_detail_pengadaan$$
DELIMITER $$
CREATE TRIGGER trg_after_delete_detail_pengadaan
AFTER DELETE ON detail_pengadaan
FOR EACH ROW
BEGIN
    CALL sp_update_total_pengadaan(OLD.idpengadaan);
END$$
DELIMITER ;


-- ==========================================
-- TRIGGERS UNTUK penerimaan
-- ==========================================

-- Trigger 5: BEFORE INSERT detail_penerimaan
-- Hitung subtotal terima otomatis menggunakan function
DROP TRIGGER IF EXISTS trg_before_insert_detail_penerimaan;
DELIMITER $$
CREATE TRIGGER trg_before_insert_detail_penerimaan
BEFORE INSERT ON detail_penerimaan
FOR EACH ROW
BEGIN
    -- Hitung subtotal menggunakan function
    SET NEW.sub_total_terima = fn_hitung_subtotal(NEW.harga_satuan_terima, NEW.jumlah_terima);
END$$
DELIMITER ;

-- trg buat status di penerimaan, setelah dia menerima semua barang yang di pengadaan statusnya akan selesaai
DROP TRIGGER IF EXISTS trg_after_insert_detail_penerimaan;
DELIMITER $$
CREATE TRIGGER trg_after_insert_detail_penerimaan
AFTER INSERT ON detail_penerimaan
FOR EACH ROW
BEGIN
    DECLARE v_stok_sebelum INT DEFAULT 0;
    DECLARE v_stok_setelah INT DEFAULT 0;
	
	-- ============================
    -- 1. UPDATE STATUS PENGADAAN & PENERIMAAN
    -- ============================
    CALL sp_update_status_penerimaan(NEW.idpenerimaan);
    
	-- ============================
    -- 2. HITUNG STOK SEBELUM
    -- ============================
    -- Ambil stok sebelumnya, kalau NULL → 0
    SELECT COALESCE(
        (SELECT stock 
         FROM kartu_stok 
         WHERE idbarang = NEW.barang_idbarang
         ORDER BY idkartu_stok DESC
         LIMIT 1), 0)
    INTO v_stok_sebelum;

    -- ============================
    -- 3. UPDATE STOK SETELAH PENERIMAAN (MASUK)
    -- ============================
    -- Hitung stok setelah penerimaan
    SET v_stok_setelah = v_stok_sebelum + NEW.jumlah_terima;

    -- Insert record kartu stok
    INSERT INTO kartu_stok (
        jenis_transaksi,
        masuk,
        keluar,
        stock,
        created_at,
        idtransaksi,
        idbarang
    )
    VALUES (
        'P',                   -- Penerimaan
        NEW.jumlah_terima,    -- jumlah masuk
        0,                    -- keluar
        v_stok_setelah,       -- stok akhir
        NOW(),
        NEW.idpenerimaan,
        NEW.barang_idbarang
    );
END$$
DELIMITER ;









-- ==========================================
-- TRIGGERS UNTUK FORM RETUR
-- ==========================================

-- Trigger 9: AFTER INSERT detail_retur
-- Insert ke kartu_stok (Barang KELUAR karena retur) menggunakan OLD dan NEW
DROP TRIGGER IF EXISTS trg_after_insert_detail_retur;
DELIMITER $$
CREATE TRIGGER trg_after_insert_detail_retur
AFTER INSERT ON detail_retur
FOR EACH ROW
BEGIN
    DECLARE v_idbarang CHAR(10);
    DECLARE v_stok_sebelum INT;
    DECLARE v_stok_setelah INT;

    -- Ambil idbarang dari detail_penerimaan
    SELECT barang_idbarang INTO v_idbarang
    FROM detail_penerimaan
    WHERE iddetail_penerimaan = NEW.iddetail_penerimaan;

    -- Cek stok sebelumnya
    SET v_stok_sebelum = fn_cek_stok_barang(v_idbarang);

    -- Hitung stok setelah retur (stok berkurang)
    SET v_stok_setelah = v_stok_sebelum - IFNULL(NEW.jumlah, 0);

    -- Insert ke kartu_stok → transaksi Retur Barang
    INSERT INTO kartu_stok (
        jenis_transaksi, masuk, keluar, stock, idtransaksi, idbarang, created_at
    )
    VALUES (
        'R',
        0,
        NEW.jumlah,
        v_stok_setelah,
        NEW.idretur,
        v_idbarang,
        NOW()
    );
END$$
DELIMITER ;


-- ==========================================
-- TRIGGERS UNTUK FORM PENJUALAN
-- ==========================================

-- Trigger 10: BEFORE INSERT detail_penjualan
-- Validasi stok dan hitung subtotal menggunakan OLD dan NEW
DROP TRIGGER IF EXISTS trg_before_insert_detail_penjualan$$
DELIMITER $$
CREATE TRIGGER trg_before_insert_detail_penjualan
BEFORE INSERT ON detail_penjualan
FOR EACH ROW
BEGIN
    DECLARE v_stok_tersedia INT;
    
    -- Cek stok menggunakan function
    SET v_stok_tersedia = fn_cek_stok_barang(NEW.idbarang);
    
    -- Validasi stok
    IF v_stok_tersedia < NEW.jumlah THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stok tidak mencukupi untuk penjualan!';
    END IF;
    
    -- Hitung subtotal menggunakan function
    SET NEW.subtotal = fn_hitung_subtotal(NEW.harga_satuan, NEW.jumlah);
END$$
DELIMITER ;

-- Trigger 11: AFTER INSERT detail_penjualan
-- Kurangi stok dan update total penjualan menggunakan OLD dan NEW
DROP TRIGGER IF EXISTS trg_after_insert_detail_penjualan;
DELIMITER $$
CREATE TRIGGER trg_after_insert_detail_penjualan
AFTER INSERT ON detail_penjualan
FOR EACH ROW
BEGIN
    DECLARE v_stok_sebelum INT;
    DECLARE v_stok_setelah INT;

    -- Ambil stok sebelum
    SET v_stok_sebelum = fn_cek_stok_barang(NEW.idbarang);

    -- Hitung stok setelah penjualan (stok berkurang)
    SET v_stok_setelah = v_stok_sebelum - NEW.jumlah;

    -- Insert ke kartu_stok → transaksi Penjualan
    INSERT INTO kartu_stok (
        jenis_transaksi, masuk, keluar, stock, idtransaksi, idbarang, created_at
    )
    VALUES (
        'J',
        0,
        NEW.jumlah,
        v_stok_setelah,
        NEW.penjualan_idpenjualan,
        NEW.idbarang,
        NOW()
    );
    -- Update total penjualan
    CALL sp_update_total_penjualan(NEW.penjualan_idpenjualan);
END$$
DELIMITER ;


-- Trigger 12: AFTER UPDATE detail_penjualan
-- Update total penjualan menggunakan OLD dan NEW
DROP TRIGGER IF EXISTS trg_after_update_detail_penjualan$$
DELIMITER $$
CREATE TRIGGER trg_after_update_detail_penjualan
AFTER UPDATE ON detail_penjualan
FOR EACH ROW
BEGIN
    -- Hanya update jika ada perubahan harga atau jumlah
    IF OLD.harga_satuan <> NEW.harga_satuan OR OLD.jumlah <> NEW.jumlah THEN
        -- Update total
        CALL sp_update_total_penjualan(NEW.penjualan_idpenjualan);
    END IF;
END$$
DELIMITER ;

-- Trigger 13: AFTER DELETE detail_penjualan
-- Update total penjualan menggunakan OLD dan NEW
DROP TRIGGER IF EXISTS trg_after_delete_detail_penjualan$$
DELIMITER $$
CREATE TRIGGER trg_after_delete_detail_penjualan
AFTER DELETE ON detail_penjualan
FOR EACH ROW
BEGIN
    CALL sp_update_total_penjualan(OLD.penjualan_idpenjualan);
END$$
DELIMITER ;

-- ==========================================
-- TRIGGERS UNTUK margin penjualan
-- ==========================================

   


-- ==========================================
-- 
-- ==========================================

ALTER TABLE pengadaan MODIFY status CHAR(1) NOT NULL 
COMMENT 'P=Pending, S=Selesai, R=Revisi, C=Batal';

ALTER TABLE penerimaan MODIFY status CHAR(1) NOT NULL 
COMMENT 'P=Pending, S=Selesai, R=Revisi, C=Batal';

 ALTER TABLE penerimaan 
MODIFY status CHAR(1) NOT NULL DEFAULT 'P'
COMMENT 'P=Pending, S=Selesai, R=Revisi, C=Batal';

ALTER TABLE pengadaan 
MODIFY status CHAR(1) NOT NULL DEFAULT 'P'
COMMENT 'P=Pending, S=Selesai, R=Revisi, C=Batal';


SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

ALTER TABLE kartu_stok MODIFY jenis_transaksi CHAR(1)
COMMENT 'M=Masuk, K=Keluar, R=Retur';

SELECT idkartu_stok, jenis_transaksi, masuk, keluar, created_at
FROM kartu_stok
ORDER BY idkartu_stok DESC;

SELECT * FROM kartu_stok ORDER BY idkartu_stok DESC;
SHOW CREATE TRIGGER trg_after_insert_detail_penerimaan;  -- atau nama trigger kamu

UPDATE kartu_stok SET jenis_transaksi = 'P' WHERE jenis_transaksi = 'M';
UPDATE kartu_stok SET jenis_transaksi = 'J' WHERE jenis_transaksi = 'K';
ALTER TABLE kartu_stok
MODIFY jenis_transaksi VARCHAR(20);

UPDATE kartu_stok
SET jenis_transaksi = 'Pe'
WHERE jenis_transaksi IN ('P', 'M');

UPDATE kartu_stok
SET jenis_transaksi = 'Penjualan'
WHERE jenis_transaksi IN ('J', 'K');

UPDATE kartu_stok
SET jenis_transaksi = 'Retur Barang'
WHERE jenis_transaksi = 'R';

UPDATE penerimaan p
JOIN (
    SELECT 
        dp.idpenerimaan,
        SUM(dp.jumlah_terima) AS total_terima,
        SUM(pg.jumlah) AS total_pesan
    FROM detail_penerimaan dp
    JOIN penerimaan pn ON pn.idpenerimaan = dp.idpenerimaan
    JOIN detail_pengadaan pg2 ON pg2.idpengadaan = pn.idpengadaan
    JOIN detail_pengadaan pg ON pg.idpengadaan = pg2.idpengadaan 
         AND pg.idbarang = dp.barang_idbarang
    GROUP BY dp.idpenerimaan
) x ON x.idpenerimaan = p.idpenerimaan
SET p.status = 
    CASE
        WHEN x.total_terima = x.total_pesan THEN 'S'
        WHEN x.total_terima < x.total_pesan THEN 'P'
        WHEN x.total_terima > x.total_pesan THEN 'R'
    END;

ALTER TABLE penerimaan MODIFY status CHAR(1) NOT NULL 
COMMENT 'P=Pending, S=Selesai, R=Revisi, C=Batal';

SET SQL_SAFE_UPDATES = 0;

UPDATE penerimaan 
SET status = 'S'
WHERE idpenerimaan = 11;

SET SQL_SAFE_UPDATES = 1;

CALL sp_get_pengadaan_dropdown();
SELECT idpengadaan, status FROM pengadaan;
UPDATE pengadaan SET status = 'P';


UPDATE pengadaan SET status = 'P' WHERE status = 'A';

SELECT * FROM detail_penerimaan ORDER BY iddetail_penerimaan DESC;
