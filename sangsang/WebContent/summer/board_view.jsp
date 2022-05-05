<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.Board" %>
<%@ page import="board.BoardDAO" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- 화면 유연하게 -->
	<meta name="viewport"
		content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>welcome</title>
	<!-- 부트스트랙 파일 저장한거 가져옴 -->
	<link rel="stylesheet" href="./resources/css/bootstrap.MYmin.css">
	<!-- 부트스트랩 말고 직접 만든 css -->
	<link rel="stylesheet" href="./resources/css/custom.css">
	<link rel="stylesheet" href="./resources/css/boardCss.css">
	<!-- 이모티콘 가져옴 -->
	<script src="https://kit.fontawesome.com/7e85906bdf.js" crossorigin="anonymous"></script>
</head>

<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");
		}
		/* int pageNumber = 1; //기본페이지
		if(request.getParameter("pageNumber")!=null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		} */
		int bID = 0;
		if(request.getParameter("bID")!=null){
			bID = Integer.parseInt(request.getParameter("bID"));
		}
		if(bID==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
	
		}
		Board board = new BoardDAO().getBoard(bID);
	
	%>
	
<!-- *******메뉴바********* -->
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
	
<!-- *********게시판 내용************* -->
	<div class="container">
		<div class="row">			
	        <div class="board_title">
	            <strong>공지사항</strong>
	            <p>공지사항을 빠르고 정확하게 안내해 드립니다.</p>
	        </div>
		</div>
		
		<div class="row">
			<table class="table board_view">
				<tbody>
					<tr class="title">
						<td colspan="2"><%=board.getbTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>;") %></td>
					</tr>
					<tr class="info">
						<td><strong>작성자</strong>&nbsp;&nbsp;<%=board.getUserID() %></td>						
						<td><strong>작성일</strong>&nbsp;&nbsp;<%=board.getbDate().substring(0,11)+board.getbDate().substring(11,13)+"시"+ board.getbDate().substring(14,16)+"분" %></td>
					</tr>
					<tr class="cont">
						<td colspan="2">
						<%=board.getbContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>;") %>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
		<div class="row">   
            <div class="bt_wrap">
            	<button type="button" class="btn btn-primary mx-1" onclick="location.href='board.jsp'">목록</button>              
                <%
					if(userID != null && userID.equals(board.getUserID())){ //글 작성자가 본인
				%>				
				<button type="button" class="btn btn-outline-primary mx-1 float-end" onclick="location.href='board_deleteAction.jsp?bID=<%=bID%>'">삭제</button>
				<button type="button" class="btn btn-outline-primary mx-1 float-end" onclick="location.href='board_update.jsp?bID=<%=bID%>'">수정</button>
				
				<%
					}
				%>                
            </div>
        </div>		
	</div>
    
	<%@ include file="footer.jsp"%>
	
	<!-- 부트스트랙 js 작동 위해 -->
	<script src="./resources/js/jquery.min.js"></script>
	<script src="./resources/js/popper.js"></script>
	<script src="./resources/js/bootstrap.min.js"></script>
</body>
</html>