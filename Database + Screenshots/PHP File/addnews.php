<?php
header("Access-Control-Allow-Origin: *");
header("Cache-Control: no-cache, no-store, max-age=0, must-revalidate");
header("X-Content-Type-Options: nosniff");

include 'con.php';

// Pastikan variabel POST tersedia sebelum digunakan
if(isset($_POST["judul"]) && isset($_POST["deskripsi"]) && isset($_POST["tanggal"]) && isset($_FILES['url_image'])) {
    $title = $_POST["judul"];
    $content = $_POST["deskripsi"];
    $date = $_POST["tanggal"];
    $namafile = $_FILES['url_image']['name'];
    $tmp_name = $_FILES['url_image']['tmp_name'];

    // Direktori tujuan untuk menyimpan file
    $target_dir = 'archive/';

    // Pastikan direktori tujuan tersedia
    if (!file_exists($target_dir)) {
        mkdir($target_dir, 0777, true);
    }

    // Periksa apakah file gambar berhasil diunggah
    if(move_uploaded_file($tmp_name, $target_dir . $namafile)) {
        try {
            $statement = $database_connection->prepare("INSERT INTO `news_catalog` (`id`, `title`, `desc`, `img`, `date`) VALUES (NULL,?,?,?,?)");
            $statement->execute([$title, $content, $target_dir . $namafile, $date]);
            echo "Data berhasil ditambah";
        } catch (PDOException $e) {
            // Tangani kesalahan PDO
            echo "Database error: " . $e->getMessage();
        } catch (Exception $e) {
            // Tangani kesalahan umum
            echo "General error: " . $e->getMessage();
        }
    } else {
        echo "Gagal mengunggah file gambar.";
    }
} else {
    echo "Data yang diperlukan tidak tersedia.";
}
?>
