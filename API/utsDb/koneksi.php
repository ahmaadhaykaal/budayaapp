<?php

$koneksi = mysqli_connect("localhost", "root", "", "dbuts1");

if($koneksi){

	//echo "Database berhasil konek";
	
} else {
	echo "gagal Connect";
}

?>