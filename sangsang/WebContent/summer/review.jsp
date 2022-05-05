<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="review.Review" %>
<%@ page import="review.ReviewDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- 화면 유연하게 -->
	<meta name="viewport"
		content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>review</title>
	<!-- 부트스트랙 파일 저장한거 가져옴 -->
	<link rel="stylesheet" href="./resources/css/bootstrap.MYmin.css">
	<!-- 부트스트랩 말고 직접 만든 css -->
	<link rel="stylesheet" href="./resources/css/custom.css">
	<!-- 이모티콘 가져옴 -->
	<script src="https://kit.fontawesome.com/7e85906bdf.js"
		crossorigin="anonymous"></script>	
	<style>
		.star_rating {font-size:0; letter-spacing:-4px;}
		.star_rating a {
		    font-size:22px;
		    letter-spacing:0;
		    display:inline-block;
		    margin-left:5px;
		    color:#ccc;
		    text-decoration:none;
		}
		.star_rating i {
			color: #ccc;
		}
		.star_rating a:first-child {margin-left:0;}
		.star_rating a.on i {color:#777;}
		
		#high{
			display:inline-block; 
			width:auto;
		}
	</style>
	
</head>

<body>
	<!-- *********메뉴바********* -->
<%-- <%@ include file="nav3.jsp"%> --%>	
<%
	request.setCharacterEncoding("UTF-8");
	String storeKind="전체";
	String searchType="최신순";
	String search=""; //기본적으로 어떤 내용도 검색 안함
	int pageNumber = 0;
	if(request.getParameter("storeKind") != null){
		storeKind = request.getParameter("storeKind");
	}
	if(request.getParameter("searchType") != null){
		searchType = request.getParameter("searchType");
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
					<li class="nav-item"><a class="nav-link active" href="review.jsp">리뷰</a></li>
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

<!-- *********서치하는곳************ -->
	<section class="container">
		<form method="get" action="./review.jsp" class="form-inline mt-3">
			<!-- <select name="areaDivide" class="form-select" id="high" >
				<option value="전체">전체</option>
				<option value="성신">성신</option>
				<option value="한성">한성</option>
				<option value="혜화">혜화</option>
			</select>  -->
			<select name="storeKind" class="form-select" id="high">
				<option value="전체">전체</option>
				<option value="음식점" <% if(storeKind.equals("음식점"))out.println("selected"); %>>음식점</option>
				<option value="카페" <% if(storeKind.equals("카페"))out.println("selected"); %>>카페</option>
			</select> 
			<select name="searchType" class="form-select" id="high">
				<option value="최신순">최신순</option>
				<option value="추천순" <% if(searchType.equals("추천순"))out.println("selected"); %>>추천순</option>
			</select> 
			<input type="text" name="search" class="form-control mx-2" id="high"
				placeholder="내용을 입력하세요." value="<% if(search != null) out.println(search); %>">
			<button type="submit" class="btn btn-outline-primary mx-1">검색</button>
			<a class="btn btn-danger mx-1" data-toggle="modal" href="#regModalRst">리뷰등록</a>
			<!-- <a class="btn btn-primary mx-1" data-toggle="modal" href="#regModalCafe">카페 리뷰등록</a> -->
			<!-- <a class="btn btn-danger mx-1" data-toggle="modal" href="#reportModal">신고</a> -->
		</form>

<!-- **********리뷰보이는곳************ -->
<%
	ArrayList <Review> reviewList = new ArrayList<Review>();
	reviewList = new ReviewDAO().getList(storeKind, searchType, search, pageNumber);

	if(reviewList != null){	
		for(int i=0; i<reviewList.size(); i++){
			if(i == 5) break;
			Review review = reviewList.get(i);
%>
		<div class = "card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left"><%= review.getDetailKind() %>&nbsp;<small><%= review.getStoreArea() %></small></div>
					<div class="col-4 text-end">
						종합&nbsp;<span style="color:red;"><%= review.getTotalScore() %></span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					<%= review.getReviewTitle() %>&nbsp;<small>(<%= review.getStoreName() %>)</small>
				</h5>
				<p class="card-text"><%= review.getReviewContent() %></p>
				<div class="row">
					<div class="col-9 text-right">
						맛&nbsp;<span style="color:red"><%= review.getTaste() %></span>
						서비스&nbsp;<span style="color:red"><%= review.getService() %></span>
						분위기&nbsp;<span style="color:red"><%= review.getAtmosphere() %></span>
						<span style="color:green";>(추천:<%= review.getLikeCount() %>)</span>
					</div>
					<div class="col-3 text-end">
						<a onclick="return confirm('추천하시겠습니까?')" href="./review_likeAction.jsp?reviewID=<%=review.getReviewID()%>">추천</a>
						<a onclick="return confirm('삭제하시겠습니까?')" href="./review_deleteAction.jsp?reviewID=<%=review.getReviewID()%>">삭제</a>
					</div>
				</div>
			</div>
		</div>
		
		
<%
		}
	}
%>
		
	</section>
	
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
		<a class="page-link" href="./review.jsp?storeKind=<%= URLEncoder.encode(storeKind, "UTF-8")%>&searchType=
		<%=URLEncoder.encode(searchType,"UTF-8")%>&search = <%= URLEncoder.encode(search,"UTF-8")%>&pageNumber=
		<%=pageNumber -1 %>">이전</a>
		</li>
<%
	}
%>
		
<%
	if(reviewList.size()< 6){ 
%>
		<li class="page-item disabled">
		<a class="page-link">다음</a>
		</li>
<%
	}else{	//다음페이지로			
%>
		<li class="page-item">
		<a class="page-link" href="./review.jsp?storeKind=<%= URLEncoder.encode(storeKind, "UTF-8")%>&searchType=
		<%=URLEncoder.encode(searchType,"UTF-8")%>&search = <%= URLEncoder.encode(search,"UTF-8")%> &pageNumber=
		<%=pageNumber +1 %>">다음</a>
		</li>
<%
	}
%>		
	</ul>
		
<!-- **********모달************** -->	
	<div class="modal fade" id="regModalRst" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
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
							<div class="col-sm-6">							
								<label class="form-check-label"> 
								<input type="radio" class="form-check-input" name="storeKind" 
								id="rst" value="음식점" checked> 음식점
								</label>
							</div>
							<div class="col-sm-6">
								<label class="form-check-label"> 
								<input type="radio" class="form-check-input" name="storeKind" 
								id="cafe" value="카페"> 카페
								</label>
							</div>
						</div>

						<div class="row">
							<div class="form-group col-sm-6">
								<select name="detailKind" class="form-control" id="rstKind">
									<option value="한식">한식</option>
									<option value="양식">양식</option>
									<option value="중식">중식</option>
									<option value="일식">일식</option>
								</select>
							</div>
							<div class="form-group col-sm-6">
								<select name="detailKind" class="form-control" id="cafeKind" disabled>
									<option value="커피">커피</option>
									<option value="디저트">디저트</option>
									<option value="빵">빵</option>
								</select>
							</div>
						</div>

						<div class="row mt-4">
							<div class="form-group col-sm-6">
								<label>지역</label> 
								<select name="storeArea" class="form-control">
									<option value="성신">성신</option>
									<option value="한성" selected>한성</option>
									<option value="혜화">혜화</option>
								</select>
							</div>
							
							<div class="form-group col-sm-6">
								<label>가게명</label> 
								<input type="text" name="storeName" class="form-control" maxlength="15">
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

<!-- 
						<div class="form-group mt-2">
							<label>평점</label>
							<p class="star_rating">
								<a href="#" class="on"><i class="fas fa-star"></i></a> <a
									href="#" class="on"><i class="fas fa-star"></i></a> <a href="#"
									class="on"><i class="fas fa-star"></i></a> <a href="#"><i
									class="fas fa-star"></i></a> <a href="#"><i class="fas fa-star"></i></a>
							</p>
						</div>
 -->
			
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
	
	<!-- <script>
		$(".star_rating a").click(function() {
		    $(this).parent().children("a").removeClass("on");
		    $(this).addClass("on").prevAll("a").addClass("on");
		    return false;
		});
	</script> -->
	
	<script type="text/javascript">
	$(document).ready(function(){
		  $('input:radio[name="storeKind"]').click(function(){
		    if($("input[name='storeKind']:checked").val() == "음식점"){
		      $("#rstKind").removeAttr('disabled');
		      $('#cafeKind').attr('disabled', 'true');
		    }else if($("input[name='storeKind']:checked").val() == "카페"){
			   $('#rstKind').attr('disabled', 'true');
			   $("#cafeKind").removeAttr('disabled');
		    }
		  });
		});
	</script>	
</body>
</html>