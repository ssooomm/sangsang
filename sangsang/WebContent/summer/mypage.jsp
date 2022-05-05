<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="save.SaveDAO" %>
<%@ page import="save.Save" %>
<%@ page import="store.StoreDAO" %>
<%@ page import="store.Store" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- 화면 유연하게 -->
	<meta name="viewport"
		content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>마이페이지</title>
	<!-- 부트스트랙 파일 저장한거 가져옴 -->
	<link rel="stylesheet" href="./resources/css/bootstrap.MYmin.css">
	<!-- 부트스트랩 말고 직접 만든 css -->
	<link rel="stylesheet" href="./resources/css/custom.css">
	<link rel="stylesheet" href="./resources/css/boardCss.css">
	<!-- 이모티콘 가져옴 -->
	<script src="https://kit.fontawesome.com/7e85906bdf.js" crossorigin="anonymous"></script>	
</head>

<body>
<%-- <%@ include file="nav3.jsp"%> --%>
<%
int pageNumber = 1; //기본페이지
	if(request.getParameter("pageNumber")!=null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	
	SaveDAO saveDAO = new SaveDAO();
	ArrayList<Save> list = saveDAO.getList(userID);
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
					<a class="nav-link active dropdown-toggle" id="dropdown" data-toggle="dropdown"> 회원관리 </a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
						<a class="dropdown-item active" href="mypage.jsp">마이페이지</a>
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

	<div class="container">
		<div class="row">
			<div class="board_title">
	            <strong><%=userID%>님 환영합니다!</strong>
	            <p>내가 찜한 가게를 확인해보세요.</p>
	        </div>
		</div>
		
		<div class="row">
			<ul class="nav nav-tabs">
			  <li class="nav-item">
			    <a class="nav-link  active" data-toggle="tab" href="#rst">음식점</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" data-toggle="tab" href="#cafe">카페</a>
			  </li>
			</ul>
		
			<div id="tabContent" class="tab-content">
				<div class="tab-pane fade show active" id="rst">
					<table class="table board_list mt-2">
						<thead class="top">
							<tr>
								<th>가게명</th>
								<th>종류</th>
								<th>위치</th>
								<th>소개</th>
								<th>비고</th>
							</tr>
						</thead>
						<tbody>
<%
	
	//StoreDAO storeDAO = new StoreDAO();
	//ArrayList<Store> storeList = new ArrayList<Store>();
	//Store store = new StoreDAO();
	for(int i=0; i < list.size(); i++){
		
		int storeID = list.get(i).getStoreID();
		if(storeID==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 storeID입니다.')");
			script.println("location.href = 'welcome.jsp'");
			script.println("</script>");
		
		}
		Store store = new StoreDAO().getStore(storeID);
		//storeList = storeDAO.getStoreList(storeID);
		if(store.getStoreKind().equals("음식점")){
%>
					<tr>
						<td><a href="store_detail.jsp?storeID=<%=storeID%>"><%=store.getStoreName()%></a></td>
						<td><%=store.getDetailKind()%> </td>
						<td><%=store.getStoreArea()%> </td>
						<td><%=store.getIntro() %></td>
						<td><a href="./mypage_deleteAction.jsp?storeID=<%= store.getStoreID() %>"
					class="badge bg-danger">삭제</a></td>
					</tr>
<%
		}
}
%> 	
				</tbody>
			</table>
		</div>
	
			<div class="tab-pane fade" id="cafe">
					<table class="table board_list mt-2">
						<thead class="top">
							<tr>
								<th>가게명</th>
								<th>종류</th>
								<th>위치</th>
								<th>소개</th>
								<th>비고</th>
							</tr>
						</thead>
						<tbody>
<%
	for(int i=0; i < list.size(); i++){
		int storeID = list.get(i).getStoreID();
		if(storeID==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 storeID입니다.')");
			script.println("location.href = 'welcome.jsp'");
			script.println("</script>");
		
		}
		Store store = new StoreDAO().getStore(storeID);
		//storeList = storeDAO.getStoreList(storeID);
		if(store.getStoreKind().equals("카페")){
%>
							<tr>
								<td><a href="store_detail.jsp?storeID=<%=storeID%>"><%=store.getStoreName()%></a></td>
								<td><%=store.getDetailKind()%> </td>
								<td><%=store.getStoreArea()%> </td>
								<td><%=store.getIntro() %></td>
								<td><a href="./mypage_deleteAction.jsp?storeID=<%= store.getStoreID() %>"
					class="badge bg-danger">삭제</a></td>
							</tr>
				
<%
		}
}
%> 	
						</tbody>
					</table>
				</div>	
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