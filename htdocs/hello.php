<?php
echo "<h1>Hello 👋</h1>";
echo "<p>PHP is working correctly!</p>";

// Display PHP info
echo "<h2>Server Info</h2>";
echo "PHP Version: " . phpversion() . "<br>";
echo "System: " . php_uname() . "<br>";

// Test database connection
echo "<h2>Database Connection Test</h2>";

try {
    $pdo = new PDO(
        "mysql:host=db;dbname=app;charset=utf8mb4",
        "app",
        "app",
        [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
    );

    echo "✅ Successfully connected to the database!";

} catch (Exception $e) {
    echo "❌ Connection error: " . htmlspecialchars($e->getMessage());
}
?>