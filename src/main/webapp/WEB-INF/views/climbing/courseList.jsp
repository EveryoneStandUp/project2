<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="my" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gasoek+One&family=Orbit&display=swap" rel="stylesheet">
</head>
<body>
	<my:navBarClimbing></my:navBarClimbing>

	<div class="container-lg">
		<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="https://bucket0503-qqwweerr11223344.s3.ap-northeast-2.amazonaws.com/project/climbingMate/%EC%BA%90%EB%9F%AC%EC%85%801.jpg" class="d-block w-100" height="500px" alt="...">
				</div>
				<div class="carousel-item">
					<img src="https://bucket0503-qqwweerr11223344.s3.ap-northeast-2.amazonaws.com/project/climbingMate/%EC%BA%90%EB%9F%AC%EC%85%802.jpg" class="d-block w-100" height="500px" alt="...">
				</div>
				<div class="carousel-item">
					<img src="https://bucket0503-qqwweerr11223344.s3.ap-northeast-2.amazonaws.com/project/climbingMate/%EC%BA%90%EB%9F%AC%EC%85%803.jpg" height="500px" alt="...">
				</div>
			</div>
			<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>

		<div class="container-lg">
			<h2>추천 코스</h2>
			<br />
			<ul>
				<div style="display: flex; justify-content: flex-start; align-items: center; margin-bottom: 10px;">
					<a href="courseList">
						<button type="button" class="btn btn-success" style="margin-right: 10px;">전체 보기</button>
					</a>
					<button type="button" class="btn btn-success" style="pointer-events: none;">🌄지역별 보기</button>
					<form action="/climbing/courseList" class="d-flex" role="todaySearch">
						<input id="searchInput" value="${param.courseSearch}" name="todaySearch" class="form-control" type="todaySearch" placeholder="Search" aria-label="todaySearch" style="width: 300px">
						<button id="search" class="btn btn-outline-success" type="submit">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
					</form>
					<span style="margin-left: 520px;">
						<button type="button" class="btn btn-success" onclick="location.href='courseAdd'">코스 등록하기</button>
				</div>
			</ul>

			<br />

			<div id="todayListData" class="row">
				<c:forEach items="${climbingCourseList}" var="board" varStatus="status">
					<div class="col-md-4">
						<div class="card todayCard">
							<div onclick="location.href='todayId/${board.id}'">
								<div class="card-body">
									<h5 class="card-title">🏕🏕 ${board.title}</h5>

									<div class="mb-3">
										<label for="" class="form-label">작성자</label>
										<span id="writerData${status.index + 1}" type="text" class="form-control">${board.writer}</span>
									</div>
									<div class="mb-3">
										<label for="" class="form-label">본문</label>
										<span id="addressText" class="form-control">${board.body}</span>
									</div>
									<div class="mb-3">
										<label for="" class="form-label">업로드 시간</label>
										<span id="timeText" class="form-control">${board.inserted}</span>
									</div>
									<c:forEach items="${board.fileName }" var="fileName" varStatus="status">
										<c:if test="${status.count lt 2 }">
											<div>
												<img class="img-thumbnail" src="${bucketUrl}/climbingCourse/${board.id}/${fileName}" alt="" style="width: 450px; height: 260px !important;" />
											</div>
										</c:if>
									</c:forEach>
								</div>

							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>


		<sec:authorize access="isAuthenticated()">
			<my:chatBtn></my:chatBtn>
			<script src="/js/groupChat.js"></script>
			<script src="/js/chat.js" charset="UTF-8"></script>
		</sec:authorize>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js" integrity="sha512-pumBsjNRGGqkPzKHndZMaAG+bir374sORyzM3uulLV14lN5LyykqNk8eEeUlUkB3U0M4FApyaHraT65ihJhDpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

		<style>
.card {
	margin-bottom: 20px;
}

.card-member {
	border: 4px solid #56B37F;
}

.card-nonMember {
	border: 4px solid #646EFF;
}

.todayCard {
	border: 4px solid #DCEBFF;
}

h2 {
	font-family: 'Gasoek One', sans-serif;
	font-family: 'Orbit', sans-serif;
}
</style>
</body>
</html>