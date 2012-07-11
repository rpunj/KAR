<?php
require_once './KARWrapper/db.php';

$DB = new Database();

if ($DB->is_connected()) {
	echo "Success";
}

?>