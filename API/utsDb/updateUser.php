<?php

  header("Access-Control-Allow-Origin: header");
  header("Access-Control-Allow-Origin: *");

  include 'koneksi.php';

  $id = $_POST['id'];
  $username = $_POST['username'];
  $fullname = $_POST['fullname'];
  $email = $_POST['email'];
  $password = md5($_POST['password']);

  $query = "UPDATE users SET username = '$username', email = '$email', password = '$password', fullname = '$fullname' WHERE id=$id";
  $result = mysqli_query($koneksi, $query);

  if ($result) {
    $response = array(
        'status' => 'success',
        'message' => 'Data berhasil diupdate'
    );
  } else {
      $response = array(
          'status' => 'failed',
          'message' => 'Gagal mengupdate data'
      );
  }

  echo json_encode($response);

  mysqli_close($koneksi);

 ?>
