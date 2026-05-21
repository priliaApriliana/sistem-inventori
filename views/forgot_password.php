<?php
session_start();
$resetError = null;
$resetSuccess = null;
if (isset($_SESSION['error'])) {
    $resetError = $_SESSION['error'];
    unset($_SESSION['error']);
}
if (isset($_SESSION['success'])) {
    $resetSuccess = $_SESSION['success'];
    unset($_SESSION['success']);
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password | Sistem Informasi Farmasi</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <!-- Google Font: Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #e8f5e8 0%, #c8e6c9 100%);
            overflow: hidden;
        }

        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            padding: 40px 30px;
            width: 100%;
            max-width: 420px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            position: relative;
            overflow: hidden;
        }

        .avatar {
            width: 90px;
            height: 90px;
            background: #ccc;
            border-radius: 50%;
            margin: 0 auto 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            color: #666;
            border: 4px solid rgba(255, 255, 255, 0.4);
        }

        h2 {
            text-align: center;
            color: #2e7d32;
            font-weight: 600;
            margin-bottom: 30px;
            font-size: 28px;
        }

        .form-control {
            background: rgba(255, 255, 255, 0.4);
            border: none;
            border-radius: 12px;
            padding: 14px 16px 14px 48px;
            height: 52px;
            font-size: 15px;
            backdrop-filter: blur(5px);
            box-shadow: inset 0 2px 5px rgba(0,0,0,0.05);
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.6);
            box-shadow: 0 0 0 0.2rem rgba(76, 175, 80, 0.25);
            border: none;
        }

        .input-group-text {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            background: transparent;
            border: none;
            color: #4caf50;
            z-index: 10;
        }

        .form-group {
            position: relative;
            margin-bottom: 20px;
        }

        .forgot-password {
            color: #2e7d32;
            font-size: 14px;
            text-decoration: none;
            font-weight: 500;
        }

        .forgot-password:hover {
            text-decoration: underline;
            color: #1b5e20;
        }

        .btn-login {
            background: #2e7d32;
            color: white;
            border: none;
            border-radius: 12px;
            padding: 14px;
            font-size: 16px;
            font-weight: 600;
            width: 100%;
            margin-top: 20px;
            transition: all 0.3s;
        }

        .btn-login:hover {
            background: #1b5e20;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(46, 125, 50, 0.3);
        }

        @media (max-width: 480px) {
            .login-card {
                padding: 30px 20px;
            }
        }
    </style>
</head>
<body>

<div class="login-container">
    <div class="login-card">
        <div class="avatar">
            <i class="bi bi-key"></i>
        </div>

        <h2>Reset Password</h2>

        <?php if ($resetError): ?>
            <div class="alert alert-danger py-2" role="alert">
                <?php echo htmlspecialchars($resetError, ENT_QUOTES, 'UTF-8'); ?>
            </div>
        <?php endif; ?>

        <?php if ($resetSuccess): ?>
            <div class="alert alert-success py-2" role="alert">
                <?php echo htmlspecialchars($resetSuccess, ENT_QUOTES, 'UTF-8'); ?>
            </div>
        <?php endif; ?>

        <form action="../scripts/forgot_password_post.php" method="POST">
            <div class="form-group">
                <span class="input-group-text"><i class="bi bi-person"></i></span>
                <input type="text" name="username" class="form-control" placeholder="Username" required>
            </div>

            <div class="form-group">
                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                <input type="password" name="password" class="form-control" placeholder="New Password" required>
            </div>

            <div class="form-group">
                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                <input type="password" name="password_confirm" class="form-control" placeholder="Confirm New Password" required>
            </div>

            <button type="submit" class="btn btn-login">
                <i class="bi bi-check2-circle me-2"></i> RESET PASSWORD
            </button>
        </form>

        <div class="text-center mt-3">
            <a href="login.php" class="forgot-password">Back to Login</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>