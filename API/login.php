<?php

header("Access-Control-Allow-Origin: header");
header("Access-Control-Allow-Origin: *");

include 'koneksi.php';

$username = $_POST['username'];
$password = md5($_POST['password']);

$query = "SELECT * FROM users WHERE username = '$username' AND password = '$password'";
$result = mysqli_query($koneksi, $query);

if ($result) {
    $row_count = mysqli_num_rows($result);

    if ($row_count > 0) {
        $response = array(
            'status' => 'success',
            'message' => 'Login berhasil',
            'data' => mysqli_fetch_assoc($result)

        );
    } else {
        $response = array(
            'status' => 'failed',
            'message' => 'username atau password salah'
        );
    }
} else {
    $response = array(
        'status' => 'failed',
        'message' => 'Terjadi kesalahan saat melakukan query'
    );
}

header('Content-Type: application/json');
echo json_encode($response);

mysqli_close($koneksi);

?>