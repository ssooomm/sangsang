<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");
		}
	%>
	
	
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
		<div class="container-fluid">
			<div class="navbar__logo">
				<i class="fas fa-hamburger"></i> 
<%
	if(userID == null){  //로그인 안됨
%>				
				<a class="navbar-brand" href="welcome.jsp">한성맛집</a>
<%
	} else { //로그인 됨
%>		
				<a class="navbar-brand" href="welcome_login.jsp">한성맛집</a>	
<%
	}
%>			
			</div>

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
					<li class="nav-item"><a class="nav-link  active" href="board.jsp">게시판</a></li>
					<li class="nav-item"><a class="nav-link" href="review.jsp">리뷰</a></li>
					
					<li class="nav-item">
						<a id="icons" href="#"><i class="fab fa-instagram"></i></a>
					</li>
					<li class="nav-item">
						<a id="icons" href="#"><i class="fab fa-facebook-square"></i></a>
					</li>
					
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
						<a class="dropdown-item" href="#">마이페이지</a>
						<a class="dropdown-item" href="logoutAction.jsp">로그아웃</a>
					</div>
				</li>
<%
}
%>
				</ul>
				<form class="d-flex">
					<input class="form-control me-sm-2" type="text"
						placeholder="Search">
					<button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
				</form>

			</div>
		</div>
	</nav>