#!/bin/bash

dd bs=${CONTENT_LENGTH}	> /tmp/post

cat << FIN 
Content-type: text/html

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	</head>
	<body>
		<form name="form" method="POST" action="/cgi-bin/form.cgi">
			郵便番号：<input type="text" name="zip" />
			<br>
			住所：<input type="text" name="addr" />
			<br>
			名前：<input type="text" name="name" />
			<br>
			<input type="submit" />
		</form>
	</body>
</html>
FIN
