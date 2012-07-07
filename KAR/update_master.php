<HTML>
<?php
	//DO NOT BREAK THIS FILE.
	print "Attemping to pull from origin/master.<BR />";
	
	system("git pull origin master", $output);
	
	if ($output == null) {
		print "There was an error pulling from origin/master. Contact Ravi.";
	} else {
		print $output;
	}

?>
</HTML>