<?php
/**
 * Vercel PHP Bridge (Front Controller)
 * 
 * Script ini berfungsi sebagai jembatan agar Vercel Serverless Function 
 * bisa mengeksekusi semua file PHP di project ini tanpa melebihi batas
 * limitasi 12 function di tier gratis Vercel.
 */

// 1. Dapatkan path dari URL yang direquest
$request_uri = $_SERVER['REQUEST_URI'];
$parsed_url = parse_url($request_uri);
$path = $parsed_url['path'] ?? '/';

// 2. Default routing ke index.php jika root diakses
if ($path === '/' || $path === '') {
    $path = '/views/index.php';
}

// 3. Cari tahu letak file asli di direktori sistem
$base_dir = realpath(__DIR__ . '/..');
$file_path = $base_dir . $path;

// 4. Set variabel lingkungan server agar project lama tidak bingung
$_SERVER['DOCUMENT_ROOT'] = $base_dir;
$_SERVER['SCRIPT_FILENAME'] = $file_path;
$_SERVER['PHP_SELF'] = $path;

// 5. Cek apakah file ada dan berekstensi .php
if (file_exists($file_path) && is_file($file_path)) {
    $ext = pathinfo($file_path, PATHINFO_EXTENSION);
    
    if ($ext === 'php') {
        // Pindah direktori kerja ke folder tempat file tersebut berada
        // Ini penting agar require_once('../config/DBConnection.php') tetap jalan!
        chdir(dirname($file_path));
        
        // Eksekusi file aslinya
        require $file_path;
    } else {
        // Jika file bukan PHP (misal user akses /assets/style/style.css secara langsung)
        // Vercel sebenarnya sudah handle di routes vercel.json, 
        // tapi ini sekadar pengaman.
        $mime_types = [
            'css' => 'text/css',
            'js'  => 'application/javascript',
            'png' => 'image/png',
            'jpg' => 'image/jpeg',
            'jpeg'=> 'image/jpeg',
            'gif' => 'image/gif',
            'svg' => 'image/svg+xml'
        ];
        
        if (array_key_exists($ext, $mime_types)) {
            header('Content-Type: ' . $mime_types[$ext]);
        }
        readfile($file_path);
    }
} else {
    // File tidak ditemukan
    http_response_code(404);
    echo "<h1>404 Not Found</h1>";
    echo "<p>Halaman atau file <code>" . htmlspecialchars($path) . "</code> tidak ditemukan di server.</p>";
}
