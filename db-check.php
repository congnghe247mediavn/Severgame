<?php
// TEMPORARY database connection test. Upload only to a private test location and DELETE after use.
header('Content-Type: text/plain; charset=utf-8');
mysqli_report(MYSQLI_REPORT_OFF);
$host = 'DB_HOST_HERE';
$user = 'DB_USER_HERE';
$pass = 'DB_PASSWORD_HERE';
$name = 'DB_NAME_HERE';
$db = @new mysqli($host, $user, $pass, $name);
if ($db->connect_errno) {
    http_response_code(500);
    echo "DB CONNECT FAILED\n";
    echo "Error number: " . (int)$db->connect_errno . "\n";
    echo "Check MySQL hostname, database name, username, password, and whether the database was created in the hosting panel.\n";
    exit;
}
$db->set_charset('utf8mb4');
echo "DB CONNECT OK\n";
$required = ['nguoichoi','log','doanhthu','phien_ngocrong','phien_chanle','phien_baucua','cuoc_ngocrong','cuoc_chanle','cuoc_baucua'];
foreach ($required as $table) {
    $safe = $db->real_escape_string($table);
    $res = $db->query("SHOW TABLES LIKE '$safe'");
    echo $table . ': ' . (($res && $res->num_rows > 0) ? 'FOUND' : 'MISSING') . "\n";
}
$db->close();
