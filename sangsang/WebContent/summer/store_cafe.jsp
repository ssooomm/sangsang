<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="store.Store" %>
<%@ page import="store.StoreDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
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
	<!-- 이모티콘 가져옴 -->
	<script src="https://kit.fontawesome.com/7e85906bdf.js" crossorigin="anonymous"></script>
	
	<style>
	.bd-placeholder-img {
		font-size: 1.125rem;
		text-anchor: middle;
		-webkit-user-select: none;
		-moz-user-select: none;
		-ms-user-select: none;
		user-select: none;
	}
	
	/* MARKETING CONTENT
	-------------------------------------------------- */
	
	/* Center align the text within the three columns below the carousel */
	.marketing .col-lg-4 {
		margin-top: 1.5rem;
		margin-bottom: 1.5rem;
		text-align: center;
	}
	
	.marketing h2 {
		font-weight: 400;
	}
	
	.marketing .col-lg-4 p {
		margin-right: .75rem;
		margin-left: .75rem;
	}
	
	/* RESPONSIVE CSS
	-------------------------------------------------- */
	@media ( min-width : 768px) {
		.bd-placeholder-img-lg {
			font-size: 3.5rem;
		}
	}
	</style>
</head>

<body>
<%-- <%@ include file="nav3.jsp"%> --%>
<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
%>

	<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
		<div class="container-fluid">
			
<!-- #042D6F -->
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
					<li class="nav-item"><a class="nav-link active" href="store_cafe.jsp">카페</a></li>
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

<%
	request.setCharacterEncoding("UTF-8");
	String storeKind="카페";
	String storeArea = "지역";
	String detailKind="종류";
	String search = "";
	int pageNumber = 0;
	if(request.getParameter("storeArea") != null){
		storeArea = request.getParameter("storeArea");
	}
	if(request.getParameter("detailKind") != null){
		detailKind = request.getParameter("detailKind");
	}
	if(request.getParameter("search") != null){
		search = request.getParameter("search");
	}
	if(request.getParameter("pageNumber") != null){
		try{
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}catch(Exception e){
			System.out.println("검색 페이지 번호 오류"); //정수형 아닌 경우 오류
		}
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}	

%>

	<div class=" bg-light p-3 ">
		<form method="get" action="./store_cafe.jsp" class="row mx-5 px-5">
			<div class="col-md-2">
				<select name="storeArea" class="form-select mx-1">
				<option value="지역">지역</option>
				<option value="성신" <%if(storeArea.equals("성신"))out.println("selected"); %>>성신</option>
				<option value="한성" <%if(storeArea.equals("한성"))out.println("selected"); %>>한성</option>
				<option value="혜화" <%if(storeArea.equals("혜화"))out.println("selected"); %>>혜화</option>
				</select>
			</div>
			<div class="col-md-2">
				<select name="detailKind" class="form-select mx-1">
				<option value="종류">종류</option>
				<option value="커피" <%if(detailKind.equals("커피"))out.println("selected"); %>>커피</option>
				<option value="디저트" <%if(detailKind.equals("디저트"))out.println("selected"); %>>디저트</option>
				<option value="빵" <%if(detailKind.equals("빵"))out.println("selected"); %>>빵</option>
				</select>
			</div>
			<div class="col-md-6">
				<input type="text" name="search" class="form-control mx-1"
				placeholder = "가게명,메뉴로 찾아보세요." value="<% if(search != null) out.println(search); %>">
			</div>
			<div class="col-md-2">
				<button type="submit" class="btn btn-outline-primary mx-1">검색</button>
			</div>
		</form>
	</div>
	
	<div class="container marketing">
<%
	ArrayList <Store> storeList = new ArrayList<Store>();
	storeList = new StoreDAO().getList(storeKind, storeArea, detailKind, search, pageNumber);

	if(storeList !=null){
		for(int i=0; i<storeList.size(); i++){
			if(i==6) break;
			Store store = storeList.get(i);
%>
<%
			if(i%3==0){
%>			
		<div class="row">
<%
			}
%>		
			<div class="col-lg-4">
	 			<img class="bd-placeholder-img rounded-circle m-2" src="./resources/images/<%= store.getStoreName() %>.jpg" width="140" height="140">
				<h2><%= store.getStoreName() %></h2>
				<p><%= store.getMenu() %></p>
				<p>
					<a class="btn btn-secondary" href="store_detail.jsp?storeID=<%=store.getStoreID()%>">View details &raquo;</a>
				</p>
			</div>
			<!-- /.col-lg-4 -->
<%
			if(i%3==2){
%>		
		</div>
		<!-- /.row -->		
<%
			}
		}
	}

%>			
	</div>
	<!-- /.container -->

	<ul class="pagination pagination-sm justify-content-center mt-3">
		
<%
	if(pageNumber<=0){ //뒤로 갈 수 없음
%>
		<li class="page-item disabled">
		<a class="page-link">이전</a>
		</li>
<%
	} else { //1페이지 이상 뒤로 갈 수 있는 페이지 존재				
%>
		<li class="page-item">
		<a class="page-link" href="./store_rst.jsp?storeArea=<%= URLEncoder.encode(storeArea, "UTF-8")%>&detailKind=
		<%=URLEncoder.encode(detailKind,"UTF-8")%>&search = <%= URLEncoder.encode(search,"UTF-8")%>&pageNumber=
		<%=pageNumber -1 %>">이전</a>
		</li>
<%
	}
%>
		
<%
	if(storeList.size()< 7){ 
%>
		<li class="page-item disabled">
		<a class="page-link">다음</a>
		</li>
<%
	}else{	//다음페이지로			
%>
		<li class="page-item">
		<a class="page-link" href="./store_rst.jsp?storeArea=<%= URLEncoder.encode(storeArea, "UTF-8")%>&detailKind=
		<%=URLEncoder.encode(detailKind,"UTF-8")%>&search = <%= URLEncoder.encode(search,"UTF-8")%> &pageNumber=
		<%=pageNumber+1%>">다음</a>
		</li>
<%
	}
%>		
	</ul>	


	<%@ include file="footer.jsp"%>
	
	<!-- 부트스트랙 js 작동 위해 -->
	<script src="./resources/js/jquery.min.js"></script>
	<script src="./resources/js/popper.js"></script>
	<script src="./resources/js/bootstrap.min.js"></script>
</body>
</html>