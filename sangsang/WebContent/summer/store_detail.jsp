<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="store.Store" %>
<%@ page import="store.StoreDAO" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
	<!-- 화면 유연하게 -->
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>welcome</title>
	<!-- 부트스트랙 파일 저장한거 가져옴 -->
	<link rel="stylesheet" href="./resources/css/bootstrap.MYmin.css">
	<!-- 부트스트랩 말고 직접 만든 css -->
	<link rel="stylesheet" href="./resources/css/custom.css">
	<!-- 이모티콘 가져옴 -->
	<script src="https://kit.fontawesome.com/7e85906bdf.js" crossorigin="anonymous"></script>
		
	<title>Stores</title>
	<script type="text/javascript"
		src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gi3c0u68hv">
	</script>
	
	<!-- <script type="text/javascript">
	function addToList(){
		if(confirm("가게를 저장하시겠습니까?")){
			document.addForm.submit();
		}else{
			document.addForm.reset();
		}
	}
</script> -->
	<style>
		#map{
		width:auto;
		height:300px;
		margin:0 auto;
		padding:5px;
		border: 1px solid #ccc;
		}
		.modal{
			text-align:center;
		}
		@media screen and (min-width: 768px) { 
	        .modal:before {
	                display: inline-block;
	                vertical-align: middle;
	                content: " ";
	                height: 100%;
	        }
		}
 
		 .modal-dialog {
	        display: inline-block;
	        text-align: left;
	        vertical-align: middle;
		}
		</style>
</head>
<body>
<%
	int storeID = 0;
	if(request.getParameter("storeID")!=null){
		storeID = Integer.parseInt(request.getParameter("storeID"));
	}
	if(storeID==0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 상세페이지입니다.')");
		script.println("location.href = 'welcome.jsp'");
		script.println("</script>");
	
	}
	Store store = new StoreDAO().getStore(storeID);
	String storeKind = store.getStoreKind();
%>

<!-- *************위에 메뉴바************** -->	
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
					<li class="nav-item">
						<a class="nav-link <%if(storeKind.equals("음식점"))out.println("active");%>" href="store_rst.jsp">음식점</a></li>
					<li class="nav-item">
						<a class="nav-link <%if(storeKind.equals("카페"))out.println("active");%>" href="store_cafe.jsp">카페</a></li>
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

<!--*******메인 화면********* -->
	<div class="container">
		<div class="row">
			<div class="col-md-6 align-self-center">
				<div class="row g-0">
					<div class="col-sm-4 border border-1" style="border-color:#aaa !important">
						<img src="./resources/images/<%= store.getStoreName() %>1.jpg"  class="img-fluid">
					</div>
					<div class="col-sm-4 border border-start-0 border-1" style="border-color:#aaa !important">
						<img src="./resources/images/<%= store.getStoreName() %>2.jpg"  class="img-fluid">
					</div>
					<div class="col-sm-4 border border-start-0 border-1" style="border-color:#aaa !important">
						<img src="./resources/images/<%= store.getStoreName() %>3.jpg"  class="img-fluid">
					</div>
				</div>
				<%-- <%@ include file="store_map.jsp"%> --%>
				<div id=map class="border border-top-0 border-1" style="border-color:#aaa !important">
				<script>
					var store1 = new naver.maps.LatLng(<%=store.getCoordinate()%>),
					    map = new naver.maps.Map('map', {
					        center: store1.destinationPoint(0, 0),
					        zoom: 18
					    }),
					    marker = new naver.maps.Marker({
					        map: map,
					        position: store1
					    });
				
				</script>
				</div>
			</div>
			
			<div class="col-md-6 align-self-center">
				
				<div class="row m-1">
					
					<a href="<%if(storeKind.equals("음식점"))out.println("store_rst.jsp"); else out.println("store_cafe.jsp");%>">
						<i class="fas fa-arrow-left"></i>
					</a>
					<h2>
						<%=store.getStoreName()%> 
						<a data-toggle="modal" href="#addList"><i class="fas fa-bookmark"></i></a>
					</h2>
					<p><span class="badge bg-danger"><%=store.getStoreKind()%></span>&nbsp;
						<span class="badge bg-danger"><%=store.getDetailKind()%></span>
					</p>
					<p><b>근처 역: </b><%=store.getStoreArea()%></p>
					<p><b>주소: </b><%=store.getAddress()%></p>
					<p><b>전화번호: </b><%=store.getPhoneNumber()%></p>
					<p><b>메뉴: </b><%=store.getMenu()%></p>
					<hr>
					<%-- <p><%=store.getIntro()%></p> --%>
					<h5><i class="fas fa-quote-left"></i>&nbsp;<%=store.getIntro()%>&nbsp;<i class="fas fa-quote-right"></i></h5>
					<p><%=store.getContent()%></p>
				</div>
				
					
					
				<div class="row">
					<div class="col-sm-6">
					<a data-toggle="modal" href="#addReview" class="btn btn-warning" style="width:100%">리뷰작성 &raquo;</a>
					</div>
					<div class="col-sm-6">
					<a class="btn btn-info" href="review.jsp?storeKind=<%=store.getStoreKind()%>&searchType=최신순&search=<%=store.getStoreName()%>" style="width:100%">리뷰보기 &raquo;</a>
					</div>
					<!-- <p style="text-align:center;">
						<a href="./store_rst.jsp" class="btn btn-secondary"> 가게 목록 &raquo;</a>
					</p> -->
				</div>	
			</div>
		</div>
	</div>
	
	<!-- *****모달********** -->
	<div class="modal fade" id="addList" tabindex="-1" role="dialog"
		aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title"></h5>
					<button type="button" class="btn-close" data-dismiss="modal" aria-label="Close">
  						<span aria-hidden="true"></span>
  					</button>
				</div>
				<div class="modal-body">
					<form action="./mypage_addAction.jsp?storeID=<%=store.getStoreID()%>" method="post">
					<h5>나의 찜 목록에 추가하시겠습니까?</h5>
					<!-- <h2 align="center">찜 성공!</h2> -->
					<div class="modal-footer">
					<button type="submit" class="btn btn-primary">확인</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					</div>
					</form>
				</div>
				
			</div>
			
		</div>
	</div>
	
	
	<div class="modal fade" id="addReview" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">리뷰등록</h5>
					<button type="button" class="btn-close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true"></span>
					</button>
				</div>
				
				<div class="modal-body">
					<form action="./reviewRegisterAction.jsp" method="post">					
						<div class="row mb-2">
							<div class="form-group col-sm-6">
								<input type="text" name="storeKind" class="form-control" value="<%= storeKind %>" readonly>
							</div>
							<div class="form-group col-sm-6">
								<input type="text" name="detailKind" class="form-control" value="<%= store.getDetailKind() %>" readonly>
							</div>
						</div>

						<div class="row mt-4">
							<div class="form-group col-sm-6">
								<label>지역</label> 
								<input type="text" name="storeArea" class="form-control" value="<%= store.getStoreArea() %>" readonly>
							</div>
							<div class="form-group col-sm-6">
								<label>가게명</label> 
								<input type="text" name="storeName" class="form-control" value="<%= store.getStoreName() %>" readonly>
							</div>
						</div>

						<div class="row mt-4">
							<div class="form-group col-sm-3">
								<label>종합</label>
								<select name = "totalScore" class="form-control">
									<option value="5" selected>5</option>
									<option value="4">4</option>
									<option value="3">3</option>
									<option value="2">2</option>
									<option value="1">1</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>맛</label>
								<select name = "taste" class="form-control">
									<option value="5" selected>5</option>
									<option value="4">4</option>
									<option value="3">3</option>
									<option value="2">2</option>
									<option value="1">1</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>서비스</label>
								<select name = "service" class="form-control">
									<option value="5" selected>5</option>
									<option value="4">4</option>
									<option value="3">3</option>
									<option value="2">2</option>
									<option value="1">1</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>분위기</label>
								<select name = "atmosphere" class="form-control">
									<option value="5" selected>5</option>
									<option value="4">4</option>
									<option value="3">3</option>
									<option value="2">2</option>
									<option value="1">1</option>
								</select>
							</div>
						</div>
						<div class="form-group mt-4">
							<label>제목</label> 
							<input type="text" name="reviewTitle" class="form-control" maxlength="30">
						</div>
						<div class="form-group mt-4">
							<label>내용</label>
							<textarea name="reviewContent" class="form-control"
								maxlength="2048" style="height: 180px;"></textarea>
						</div>							
			
						<div class="modal-footer">
							<button type = "button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">등록하기</button>
						</div>
					</form>
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