<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- 화면 유연하게 -->
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>join</title>
	<!-- 부트스트랙 파일 저장한거 가져옴 -->
	<link rel="stylesheet" href="./resources/css/bootstrap.MYmin.css">
	<!-- 부트스트랩 말고 직접 만든 css -->
	<link rel="stylesheet" href="./resources/css/custom.css">
	<!-- 이모티콘 가져옴 -->
	<script src="https://kit.fontawesome.com/7e85906bdf.js" crossorigin="anonymous"></script>
		
	<!-- <style>
		main {
			display:flex;
  			align-items:center;
		}	
	</style> -->
</head>
<body>
<!-- *************위에 메뉴바************** -->	
<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
%>

	<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
		<div class="container-fluid">
			<a class="navbar-brand" href="<%if(userID == null){out.println("welcome.jsp");}else{out.println("welcome_login.jsp");}%>">
			<img src="./resources/images/boogi.png" alt="" width="40" height="43" class="d-inline-block align-text-middle" id="logo">
		    	한성맛집
			</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarColor01" aria-controls="navbarColor01"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>

			<div class="collapse navbar-collapse" id="navbarColor01">
				<ul class="navbar-nav me-auto">
					<li class="nav-item">
						<a class="nav-link" href="home.jsp">Home
							<!-- <span class="visually-hidden">(current)</span> -->
						</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="store_rst.jsp">음식점</a></li>
					<li class="nav-item"><a class="nav-link" href="store_cafe.jsp">카페</a></li>
					<li class="nav-item"><a class="nav-link" href="review.jsp">리뷰</a></li>
					<li class="nav-item"><a class="nav-link" href="board.jsp">게시판</a></li>
				</ul>
				<ul class="navbar-nav float-end">	
					
<%
	if(userID == null){  //로그인 안됨
%>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle active" id="dropdown" data-toggle="dropdown"> 회원가입 </a>

					<div class="dropdown-menu" aria-labelledby="dropdown">
						<a class="dropdown-item" href="welcome.jsp">로그인</a> 
						<a class="dropdown-item active" href="join.jsp">회원가입</a>
					</div>
				</li>
<%
	} else {
%>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown"> 회원관리 </a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
						<a class="dropdown-item" href="mypage.jsp">마이페이지</a>
						<a class="dropdown-item" href="logoutAction.jsp">로그아웃</a>
					</div>
				</li>
<%
}
%>
				</ul>
			</div>
		</div>
	</nav>

<!--*******메인 화면********* -->
<main class="container">
	<div class="row w-100 justify-content-md-center">
		<!-- <div class="col-md-3"></div> -->
			<div class="col-md-6">
				<div class="card bg-light border-light mb-3 h-100">
					<div class="card-body">
						<h4 class="my-3 fw-normal text-center">회원가입</h4>
						
						<form class="form-signin"  action="joinAction.jsp" method="post">
							<div class="form-group">
								<label class="form-label mt-1">ID</label>
								<div class="form-floating mb-3">
									<input type="text" class="form-control" id="joinID"  
									placeholder="아이디를 입력하세요." name="userID" maxlength="20" required autofocus> 
									<label for="joinID">아이디를 입력하세요.</label>
								</div>
								<label class="form-label">Password</label>
								<div class="form-floating mb-3">
									<input type="password" class="form-control" id="joinPW"
										 placeholder="비밀번호를 입력하세요." name="userPassword" maxlength="20" required> 
									<label for="joinPW">비밀번호를 입력하세요.</label>
								</div>
								<label class="form-label">Name</label>
								<div class="form-floating mb-3">
									<input type="text" class="form-control" id="joinName" 
									placeholder="이름" name="userName" maxlength="5" required> 
									<label for="joinName">이름을 입력하세요.</label>
								</div>
								<label class="form-label">Email</label>				
								<div class="form-floating mb-3">
									<input type="email" class="form-control" id="joinEmail" 
									placeholder="이메일" name="userEmail" maxlength="20" required> 
									<label for="joinEmail">이메일을 입력하세요.ex)xxx@xxx.com</label>
								</div>
								<label class="form-label">Born</label>
								<div class="form-floating mb-4">
									<input type="date" class="form-control" id="joinName" 
									placeholder="생년월일" name="userBorn" required> 
									<label for="joinName">생년월일 8자리를 입력하세요. ex)2000-08-14</label>
								</div>
							</div>
							<div class="form-group" style="text-align:center;">
								<div class="btn-group" data-toggle="buttons">
									<label class="btn btn-primary active">
										<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
									</label>
									<label class="btn btn-primary">
										<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
									</label>
								</div>
							</div>
							<input type="submit" class="w-100 btn btn-lg btn-outline-warning mt-3" value="회원가입">
						</form>
					</div>
				</div>
			</div>
			<!-- <div class="col-md-3"></div> -->
		</div>
	</main>
		
	<%@ include file="footer.jsp"%>
		<!-- 부트스트랙 js 작동 위해 -->
	<script src="./resources/js/jquery.min.js"></script>
	<script src="./resources/js/popper.js"></script>
	<script src="./resources/js/bootstrap.min.js"></script>	
				
</body>
</html>