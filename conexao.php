<?php
$host = 'localhost';
$user = 'root';
$pass = ''; // ou sua senha do MySQL
$db = 'sistema_prefeitura';

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die('Erro de conexão: ' . $conn->connect_error);
}
?>