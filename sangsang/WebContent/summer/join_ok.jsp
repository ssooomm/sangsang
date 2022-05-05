<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- 화면 유연하게 -->
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>join_ok</title>
	<!-- 부트스트랙 파일 저장한거 가져옴 -->
	<link rel="stylesheet" href="./resources/css/bootstrap.MYmin.css">
	<!-- 부트스트랩 말고 직접 만든 css -->
	<link rel="stylesheet" href="./resources/css/custom.css">
	<!-- 이모티콘 가져옴 -->
	<script src="https://kit.fontawesome.com/7e85906bdf.js" crossorigin="anonymous"></script>
	
</head>
<body>
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
					<li class="nav-item"><a class="nav-link" href="board.jsp">게시판</a></li>
					<li class="nav-item"><a class="nav-link" href="review.jsp">리뷰</a></li>
				</ul>
				<ul class="navbar-nav float-end">		
	
<%
	if(userID == null){  //로그인 안됨
%>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown"> 회원가입 </a>

					<div class="dropdown-menu" aria-labelledby="dropdown">
						<a class="dropdown-item" href="welcome.jsp">로그인</a> 
						<a class="dropdown-item" href="join.jsp">회원가입</a>
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

<main class="container">
	<div style="text-align:center">
		<div class="m-5">
			<h1><%=userID%>님 환영합니다!</h1>
		</div>		
		<div class="m-5"style="font-size:0;">
			<button type="button" class="w-30 btn btn-lg btn-outline-secondary mx-2" onclick="location.href='store_rst.jsp'">
			음식점 둘러보기</button>
			<button type="button" class="w-30 btn btn-lg btn-outline-info mx-2" onclick="location.href='store_cafe.jsp'">
			카페 둘러보기</button>
		</div>	
	</div>
</main>

<%@ include file="footer.jsp"%>
	<!-- 부트스트랙 js 작동 위해 -->
	<script src="./resources/js/jquery.min.js"></script>
	<script src="./resources/js/popper.js"></script>
	<script src="./resources/js/bootstrap.min.js"></script>
</body>
</html>