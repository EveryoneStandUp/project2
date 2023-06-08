<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
</head>
<body>

	<my:navBar> </my:navBar>

	<div class="container-lg">
		<div class="row justify-content-center">
			<div class="col-12 col-md-8 col-lg-6">
				<h1>로 그 인 🐾🐾</h1>
				<form method="post">
					<div class="mb-3">
						<label for="" class=form-label">아이디</label>
						<input class="form-control" type="text" name="username" />
					</div>
					<div class="mb-3">
						<label for="" class=form-label">패스워드</label>
						<input class="form-control" type="password" name="password" />
					</div>
					<div class="mb-3">
						<input class="btn btn-success" type="submit" value="로그인">
					</div>
				</form>
			</div>
		</div>
	</div>

</body>
</html>