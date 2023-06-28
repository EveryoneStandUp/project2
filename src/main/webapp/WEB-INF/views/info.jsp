<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<style>
		.container-lg {
			width: 500px;
			margin: 0 auto; /* Center the container horizontally */
			margin-top: 100px; /* Add top margin for spacing */
		}

		.btn-success {
			background-color: #00C73C;
			border-color: #00C73C;
		}

		.btn-success:hover {
			background-color: #00A237;
			border-color: #00A237;
		}

		.form-label {
			margin-bottom: 0.5rem;
			font-weight: bold;
		}

		.mb-3 {
			margin-bottom: 1rem;
		}

		#checkIdBtn, #checkNickNameBtn, #checkEmailBtn {
			margin-top: 0.5rem;
		}

		/* Custom styles for the bordered container */
		.registration-container {
			border: 1px solid #ced4da;
			border-radius: 0.25rem;
			padding: 1rem;
			background-color: white;
			margin-bottom: 2rem;
			width: 600px; /* Adjust the width as desired */
			margin: 0 auto;
		}
	</style>
</head>
<body>

<my:navBar></my:navBar>

<my:alert></my:alert>

<div class="container-lg">
	<div class="row justify-content-center">
		<div class="registration-container">
			<h1><img src="https://bucket0503-qqwweerr11223344.s3.ap-northeast-2.amazonaws.com/project/signup/%ED%9A%8C%EC%9B%90%EC%A0%95%EB%B3%B4.png" alt="" /></h1>
			<!-- .mb-3*4>label+input -->
			<div class="mb-3">
				<label class="form-label" for=""><img src="https://bucket0503-qqwweerr11223344.s3.ap-northeast-2.amazonaws.com/project/signup/%EC%95%84%EC%9D%B4%EB%94%94.png" alt="" /></label>
				<input class="form-control" type="text" value="${member.userId }" name="userId" readonly />
			</div>
			<div class="mb-3">
				<label class="form-label" for=""><img style="margin-left: -1px;" src="https://bucket0503-qqwweerr11223344.s3.ap-northeast-2.amazonaws.com/project/signup/%EB%B3%84%EB%AA%85.png" alt="" /></label>
				<input class="form-control" type="text" value="${member.nickName }" name="nickName" readonly />
			</div>
			<div class="mb-3">
				<label class="form-label" for=""><img src="https://bucket0503-qqwweerr11223344.s3.ap-northeast-2.amazonaws.com/project/signup/%EC%83%9D%EC%9D%BC.png" alt="" /></label>
				<input class="form-control" type="text" value="${member.birth }" name="birth" readonly />
			</div>
			<div class="mb-3">
				<label class="form-label" for=""><img style="margin-left: -4px;" src="https://bucket0503-qqwweerr11223344.s3.ap-northeast-2.amazonaws.com/project/signup/%EC%84%B1%EB%B3%84.png" alt="" /></label>
				<input class="form-control" type="text" value="${member.gender }" name="gender" readonly />
			</div>
			<div class="mb-3">
				<label class="form-label" for=""><img style="margin-left: -3px;" src="https://bucket0503-qqwweerr11223344.s3.ap-northeast-2.amazonaws.com/project/signup/%EC%A3%BC%EC%86%8C.png" alt="" /></label>
				<input class="form-control" type="text" value="${member.address }" name="address" readonly />
			</div>
			<div class="mb-3">
				<label class="form-label" for=""><img src="https://bucket0503-qqwweerr11223344.s3.ap-northeast-2.amazonaws.com/project/signup/%EC%A0%84%ED%99%94%EB%B2%88%ED%98%B8.png" alt="" /></label>
				<input class="form-control" type="text" value="${member.phone }" name="phone" readonly />
			</div>
			<div class="mb-3">
				<label class="form-label" for=""><img style="margin-left: -3px;" src="https://bucket0503-qqwweerr11223344.s3.ap-northeast-2.amazonaws.com/project/signup/%EC%9D%B4%EB%A9%94%EC%9D%BC.png" alt="" /></label>
				<input class="form-control" type="text" value="${member.email }" name="email" readonly />
			</div>
			<div class="mb-3">
				<label class="form-label" for=""><img style="margin-left: -1px;" src="https://bucket0503-qqwweerr11223344.s3.ap-northeast-2.amazonaws.com/project/signup/%EC%86%8C%EA%B0%9C.png" alt="" /></label>
				<input class="form-control" type="text" value="${member.introduce }" name="introduce" readonly />
			</div>
			<a class="btn btn-dark" href="/modify?userId=${member.userId }">Modify</a>
			<button type="button" data-bs-toggle="modal" class="btn btn-danger" data-bs-target="#confirmModal">Withdrawal</button>
		</div>
	</div>
</div>
<%-- <div class="d-none">
   <form id="removeForm" action="/remove" method="post">
      <input type="text" name="id" value="${member.id }" />
   </form>
</div> --%>

<!-- 탈퇴 확인Modal -->
<div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h1 class="modal-title fs-5" id="exampleModalLabel">탈퇴 확인</h1>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="removeForm" action="/remove" method="post">
					<input type="hidden" name="id" value="${member.userId }" />
					<label for="passwordInput1" class="form-label">암호</label>
					<input id="passwordInput1" type="password" name="password" class="form-control" />
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">아니오</button>
				<button type="submit" form="removeForm" class="btn btn-danger">예</button>
			</div>
		</div>
	</div>
</div>

<sec:authorize access="isAuthenticated()">
	<my:chatBtn></my:chatBtn>
	<script src="/js/groupChat.js"></script>
	<script src="/js/chat.js" charset="UTF-8"></script>
</sec:authorize>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</body>
</html>