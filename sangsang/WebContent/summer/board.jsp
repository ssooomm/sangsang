<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- 화면 유연하게 -->
	<meta name="viewport"
		content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>board</title>
	<!-- 부트스트랙 파일 저장한거 가져옴 -->
	<link rel="stylesheet" href="./resources/css/bootstrap.MYmin.css">
	<!-- 부트스트랩 말고 직접 만든 css -->
	<link rel="stylesheet" href="./resources/css/custom.css">
	<link rel="stylesheet" href="./resources/css/boardCss.css">
	<!-- 이모티콘 가져옴 -->
	<script src="https://kit.fontawesome.com/7e85906bdf.js" crossorigin="anonymous"></script>	
</head>

<body>
<!-- *************위에 메뉴바************** -->	
	<%
		int pageNumber = 1; //기본페이지
		if(request.getParameter("pageNumber")!=null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	
	%>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");
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
					<li class="nav-item"><a class="nav-link active" href="board.jsp">게시판</a></li>
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

<!--*******메인 화면********* -->
	<div class="container">
		<div class="row">
			<div class="board_title">
	            <strong>공지사항</strong>
	            <p>공지사항을 빠르고 정확하게 안내해 드립니다.</p>
	        </div>
		</div>
		
		<div class="row">
		
			<table class="table board_list">
				<thead class="top">
					<tr>
						<th class="num">번호</th>
						<th class="title">제목</th>
						<th class="writer">작성자</th>
						<th class="date">작성일</th>
					</tr>
				</thead>
				<tbody>
				<%
					BoardDAO boardDAO = new BoardDAO();
					ArrayList<Board> list = boardDAO.getList(pageNumber);
					for(int i=0;i<list.size();i++){
				%>
				
					<tr>
						<td><%=list.get(i).getbID() %></td>
						<td><a href="board_view.jsp?bID=<%=list.get(i).getbID()%>"><%=list.get(i).getbTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>;") %></a></td>
						<td><%=list.get(i).getUserID() %></td>
						<td><%=list.get(i).getbDate().substring(0,11)+list.get(i).getbDate().substring(11,13)+"시"+ list.get(i).getbDate().substring(14,16)+"분" %></td>
					</tr>
				<%
					}
				%>	
				</tbody>
				
			</table>
			<%-- <%
				if(pageNumber != 1){
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber-1 %>" class="btn btn-success btn-arrow-left">이전</a>
			<%		
				}if(bbsDAO.nextPage(pageNumber+1)){	 //다음 페이지 존재하는지
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber+1 %>" class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
			%> --%>			
		</div>
		
		<div class="row">
			<div class="board_page">
				<ul class="pagination pagination-sm justify-content-center">				
<%
if(pageNumber <= 1){
%>
					<li class="page-item disabled">
					<a class="page-link">&laquo;</a>
					</li>					
<%		
}else{
%>
					<li class="page-item">
					<a class="page-link" href="board.jsp?pageNumber=<%=pageNumber-1 %>">&laquo;</a>
					</li>
<%
} 
%>	
<%
if(boardDAO.nextPage(pageNumber+1)){ //다음 페이지 존재하는지
%>	
					<li class="page-item">				
					<a class="page-link" href="board.jsp?pageNumber=<%=pageNumber+1 %>">&raquo;</a>
					</li>
<%		
}else{
%>
					<li class="page-item disabled">				
					<a class="page-link">&raquo;</a>
					</li>
<%
} 
%>	
					<!-- 
					<li class="page-item active"><a class="page-link" href="#">1</a>
					</li>
					<li class="page-item"><a class="page-link" href="#">2</a></li>
					<li class="page-item"><a class="page-link" href="#">3</a></li>
					<li class="page-item"><a class="page-link" href="#">4</a></li>
					<li class="page-item"><a class="page-link" href="#">5</a></li>
					 -->
				</ul>
				<button type="button" class="btn btn-primary float-end" onclick="location.href='board_write.jsp'">등록</button>
			</div>		
		</div>
				
		<!-- <div class="row">
			<div class="bt_wrap">
            	<button type="button" class="btn btn-primary" onclick="location.href='board_write.jsp'">등록</button>
            </div>		
		</div> -->
		
	</div>
	<script src="./resources/js/jquery.min.js"></script>
	<script src="./resources/js/popper.js"></script>
	<script src="./resources/js/bootstrap.min.js"></script>
	
</body>
</html>