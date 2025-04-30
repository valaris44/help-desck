<!-- filepath: c:\xampp\htdocs\meu-sistema-prefeitura\registrar-adm.php -->
<?php
session_start();
$chave_temporaria = '030344'; // Troque por uma chave forte

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['chave'])) {
    $chave = $_POST['chave'] ?? '';
    if ($chave !== $chave_temporaria) {
        $erro = "Chave de acesso inválida.";
    } else {
        $_SESSION['adm_registro_autorizado'] = true;
        header('Location: registrar-adm.php?autorizado=1');
        exit;
    }
}

if (isset($_GET['autorizado']) && ($_SESSION['adm_registro_autorizado'] ?? false) === true) {
    // Exibe formulário de registro de administrador
    ?>
    <!DOCTYPE html>
    <html lang="pt-BR">

    <head>
        <meta charset="UTF-8">
        <title>Registrar Administrador</title>
        <link rel="stylesheet" href="styles.css">
    </head>

    <body>
        <main class="container">
            <h1>Registrar Administrador</h1>
            <form action="backend/register.php" method="POST" autocomplete="off">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" required>
                <label for="matricula">Matrícula:</label>
                <input type="text" id="matricula" name="matricula" required>
                <label for="email">E-mail:</label>
                <input type="email" id="email" name="email" required>
                <label for="area_atuacao">Área de Atuação:</label>
                <input type="text" id="area_atuacao" name="area_atuacao" required>
                <label for="senha">Senha:</label>
                <input type="password" id="senha" name="senha" required>
                <label for="confirmar_senha">Confirmar Senha:</label>
                <input type="password" id="confirmar_senha" name="confirmar_senha" required>
                <input type="hidden" name="tipo" value="admin">
                <button type="submit">Registrar Administrador</button>
            </form>
        </main>
    </body>

    </html>
    <?php
    unset($_SESSION['adm_registro_autorizado']);
    exit;
}
?>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">
    <title>Chave de Acesso - Registrar Administrador</title>
    <link rel="stylesheet" href="styles.css">
</head>

<body>
    <main class="container">
        <h1>Registrar Administrador</h1>
        <form method="POST" autocomplete="off">
            <label for="chave">Chave de acesso temporária:</label>
            <input type="password" id="chave" name="chave" required>
            <button type="submit">Acessar</button>
        </form>
        <?php if (!empty($erro)): ?>
            <div class="alert"><?php echo htmlspecialchars($erro); ?></div>
        <?php endif; ?>
    </main>
</body>

</html>