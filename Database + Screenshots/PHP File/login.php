<?php
header("Access-Control-Allow-Origin: *");
include 'con.php';

    $username = $_POST["user"];
    $password = $_POST["pwd"];
if (isset($username) && isset ($password)) {
    
    
    //Mengambil data penggguna dari database bedasarkan username
    $statement = $database_connection->prepare("SELECT id, username, password FROM user WHERE username = ?");
    $statement->execute([$username]);
    $user = $statement->fetch(PDO::FETCH_ASSOC);
    
    //Verifikasi kata sandi dengan menggunakan SHA1
    if ($user && sha1($password) === $user['password']) {
        //Jika Verifikasi berhasil, buat token sesi baru
        $session_token = bin2hex(random_bytes(16));
        
        // Perbarui token sesi didatabase
        $updateStatement = $database_connection->prepare("UPDATE user SET session_token = ? WHERE id = ?");
        $updateStatement->execute([$session_token, $user['id']]);
        
        // Mengembalikan respons JSON sukses dengan token sesi
        echo json_encode(['status' => 'success', 'session_token' => $session_token]);
    } else {
        // Jika Verifikasi gagal, kirim pesan kesalahan
        echo json_encode(['status' => 'error', 'message' => 'Kredensial tidak valid']);
    }
} else {
    //Jika permintaan tidak valid, kirim pesan kesalahan
    echo json_encode(['status' => 'error', 'message' => 'Permintaan tidak valid']);
}
?>