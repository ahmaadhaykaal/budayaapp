<?php

$koneksi = mysqli_connect("localhost", "root", "", "dbuts");

if($koneksi){

	// echo "Database berhasil konek";
	
} else {
	echo "gagal Connect";
}

?>