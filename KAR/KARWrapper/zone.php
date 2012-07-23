<?php
require_once 'KARWrapper/db.php';

class Zone extends DBObject {
	
	function __construct($db) {
		if (is_a($db, "Database") && $db->is_connected()) {
			$this->db = $db;
		}
		else {
			throw new DBRuntimeException("Not a database or not connected");
		}
	}
	
	function get_all() {
		
	}
	
}

class ZoneRow extends DBRow {
	
}

?>