<?php

header("Access-Control-Allow-Origin: *");
include 'koneksi.php';

$res = array();
$id = $_POST['id'];
$nama = $_POST['nama'];
$tgl_lahir = $_POST['tgl_lahir'];
$asal = $_POST['asal'];
$jk = $_POST['jk'];
$deskripsi = $_POST['deskripsi'];
$foto = $_POST['foto'];

$cek = "SELECT * FROM tbsejarawan WHERE nama = '$nama' AND id != $id";
$result = mysqli_query($koneksi, $cek);
if (mysqli_num_rows($result) > 0) {
    $res['is_success'] = false;
    $res['value'] = 2;
    $res['message'] = "Nama sudah ada, Gagal Edit Sejarawan.";
} else {
    $sql = "UPDATE tbsejarawan SET nama = '$nama', tgl_lahir = '$tgl_lahir', asal = '$asal', jk = '$jk', deskripsi = '$deskripsi', foto = '$foto' WHERE id=$id";
    $isSuccess = $koneksi->query($sql);

    if ($isSuccess) {
        $cek = "SELECT * FROM tbsejarawan WHERE id = $id";
        $result = mysqli_fetch_array(mysqli_query($koneksi, $cek));
        $res['is_success'] = true;
        $res['value'] = 1;
        $res['message'] = "Berhasil edit sejarawan";
        $res['nama'] = $result['nama'];
        $res['tgl_lahir'] = $result['tgl_lahir'];
        $res['asal'] = $result['asal'];
        $res['jk'] = $result['jk'];
        $res['deskripsi'] = $result['deskripsi'];
        $res['foto'] = $result['foto'];
    } else {
        $res['is_success'] = false;
        $res['value'] = 0;
        $res['message'] = "Gagal edit pegawai";
    }
}

echo json_encode($res);

?>
