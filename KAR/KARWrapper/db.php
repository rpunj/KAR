<?php

require_once 'db_settings.php';

class Database
{
	protected $db_host;
	protected $db_name;
	protected $db_username;
	protected $db_password;
	protected $db_connected;
	protected $db_object;
	
	function __construct()
	{
		$this->db_host = get_db_host();
		$this->db_name = get_db_name();
		$this->db_username = get_db_username();
		$this->db_password = get_db_password();
		
		$this->db_object = new mysqli($this->db_host, $this->db_username, $this->db_password, $this->db_name);
		if ($this->db_object->connect_errno) {
			throw new DBConnectionException("MySQL Connection Error: ". $this->db_object->connect_error);
		} else {
			$this->db_connected = TRUE;
		}	
	}
	
	function is_connected() {
		return $this->db_connected;
	}
}

class DBConnectionException extends Exception {
	function __toString(){
		return __CLASS__.": [{$this->code}]: {$this->message}\n";
	}
}

?>