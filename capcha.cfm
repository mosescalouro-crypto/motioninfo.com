

<!DOCTYPE html>	
<html>
	<head>
		<script src='https://www.google.com/recaptcha/api.js'></script>
	</head>
	<body>
		<form method="post" action=capcha2.cfm>
			UserName:
			<input type="text" name="username">
			<br><br>
			Password:
			<input type="password" name="password">
			<br><br>
			<div class="g-recaptcha" data-sitekey="6LeXLB4UAAAAAGa_1eewlmCcduelDR4CAT_WAsLm"></div>
			<input type="submit" value="Submit" name="submit">
			
		</form>
	</body>
</html>	
