<?php
session_start();
require_once(__DIR__ . '/../classes/User.php');

$username = isset($_POST['username']) ? trim($_POST['username']) : '';
$password = $_POST['password'] ?? '';
$confirm = $_POST['password_confirm'] ?? '';

if ($username === '' || $password === '' || $confirm === '') {
    $_SESSION['error'] = "Semua field wajib diisi.";
    header("Location: ../views/forgot_password.php");
    exit();
}

if ($password !== $confirm) {
    $_SESSION['error'] = "Konfirmasi password tidak cocok.";
    header("Location: ../views/forgot_password.php");
    exit();
}

$userClass = new User();
$updated = $userClass->updatePasswordByUsername($username, $password);

if ($updated) {
    $_SESSION['success'] = "Password berhasil direset. Silakan login.";
    header("Location: ../views/login.php");
    exit();
}

$_SESSION['error'] = "Username tidak ditemukan atau gagal reset password.";
header("Location: ../views/forgot_password.php");
exit();
?>