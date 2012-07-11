<HTML>
<?php
	//DO NOT BREAK THIS FILE.
	print "Attemping to pull from origin/master.<BR />";
	
	exec("dir", $output, $flag);
	
	if (!$flag) {
		print "There was an error pulling from origin/master. Contact Ravi.";
	} else {
		echo $output;
	}

?>
</HTML>