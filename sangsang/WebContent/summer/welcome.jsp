<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="store.StoreDAO"%>
<%@ page import="store.Store" %> 
<%@ page import="java.util.*" %> 

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
	
</head>

<body>

<!-- *************위에 메뉴바************** -->	
	<%@ include file="nav.jsp"%>

<!--*******메인 화면********* -->
	<main class="container">
		<div class="row row-cols-1 row-cols-md-2 mb-3 text-center">
			
			<div class="col-md-6">
            	<div class="card bg-light border-light mb-3 h-100">
               
	               <div class="card-body">
	                  <h4 class="my-3 fw-normal">오늘의 맛집 추천</h4>
<% 
	//StoreDAO storeDAO = new StoreDAO();
	ArrayList <Store> randomList = new ArrayList<Store>();
	randomList = new StoreDAO().getRandomList();
	Random random = new Random();
	int num = (int)(random.nextInt(randomList.size())+1);
	
	//ArrayList <Store> recommendList = new ArrayList<Store>();
	//recommendList = new StoreDAO().getStoreList(num);
	Store recommend = new StoreDAO().getStore(num);
	Store store = new Store();
	//String storeName = store.getStoreName();
%>
		                  <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
		                     <div class="col p-4 d-flex flex-column position-static" >
		                        <strong class="d-inline-block mb-2 text-primary"><%= recommend.getStoreKind() %></strong>
		                        <h3 class="mb-0"><%= recommend.getStoreName() %></h3>
		                        <div class="mb-1 text-muted"><%= recommend.getStoreArea() %></div>
		                        <p class="card-text mb-auto"><%= recommend.getIntro() %></p>
		                     </div>
		                     <div class="col-auto d-none d-lg-block">
		                      <img src="./resources/images/<%= recommend.getStoreName() %>.jpg" width="200" height="200">
		                     </div>
		                  </div>
                  		  <button type="button" class="w-100 btn btn-lg btn-outline-warning my-3" onclick="location.href='store_detail.jsp?storeID=<%=recommend.getStoreID()%>'">Detail</button>
               		</div>
               	</div>
            </div>

			
			<div class="col-md-6">
				<div class="card bg-light border-light mb-3 h-100">
					<div class="card-body" style="text-align:center">
						<h4 class="my-3 fw-normal">Please sign in</h4>
						<%
						String error = request.getParameter("error");
						if (error != null) {
							out.println("<div class='alert alert-danger'>");
							out.println("아이디와 비밀번호를 확인해 주세요");
							out.println("</div>");
						}
						%>
						<form class="form-signin"  action="loginAction.jsp" method="post">
							<div class="form-group">
								<label class="form-label mt-4"></label>
								<div class="form-floating mb-3">
									<input type="text" class="form-control" id="floatingInput" 
									placeholder="ID" name="userID" required autofocus> 
									<label for="floatingInput">ID</label>
								</div>
								<div class="form-floating">
									<input type="password" class="form-control"
										id="floatingPassword" placeholder="Password" name="userPassword" required> 
									<label for="floatingPassword">Password</label>
								</div>
							</div>
							<input type="submit" class="w-100 btn btn-lg btn-outline-warning my-3" value="Login">
							<%@ include file="naverlogin.jsp"%>
						</form>
						
						<a data-toggle="modal" href="#regLogin" class="card-link float-end">회원가입</a>

					</div>
				</div>
			</div>
		</div>
	</main>

<!-- ********회원가입 폼 모달******* -->
	<div class="modal fade" id="regLogin" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="modal">회원가입</h5>
						<button type="button" class="btn-close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true"></span>
						</button>
					</div>
					
					<div class="modal-body">
						<form class="form-signin" action="joinAction.jsp" method="post">
							<div class="form-row">
								<div class="form-group mb-4">
								<label>ID</label>
								<input type="text" class="form-control"
										placeholder="학번을 입력하세요." name="userID" maxlength="20" required autofocus>
								</div>
								<div class="form-group mb-4">
								<label>Password</label>
								<input type="password" class="form-control" id="joinPW"
										placeholder="비밀번호를 입력하세요." name="userPassword" maxlength="20" required>
								</div>
								<div class="form-group mb-4">
								<label>Name</label>
								<input type="text" class="form-control" id="joinName"
										placeholder="이름을 입력하세요." name="userName" required>
								</div>
								<div class="form-group mb-4">
								<label>Email</label>
								<input type="email" class="form-control" id="joinName"
										placeholder="이메일을 입력하세요." name="userEmail" maxlength="20" required>
								</div>
								<div class="form-group mb-4">
								<label>Born</label>
								<input type="date" class="form-control" id="joinName"
										placeholder="2000-08-14" name="userBorn" required>
								</div>
							</div>

							<div class="row">
								<div class="from-group col-sm-6">
									<label>성별</label>
									<div class="form-check">							
										<label class="form-check-label"> 
										<input type="radio" class="form-check-input" name="userGender" 
										 value="남자" checked> 남성
										</label>
									</div>
									<div class="form-check">
										<label class="form-check-label"> 
										<input type="radio" class="form-check-input" name="userGender" 
										 value="여자"> 여성
										</label>
									</div>
								</div>								 
							</div>
						
							<div class="modal-footer">
							<button type = "button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">가입하기</button>
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>
		

	<div class="container">
		<div class="text-center">
			<h5>
				"Welcome to Hansung!
			</h5>
			<%
			//response.setIntHeader("Refresh", 5);
			Date day = new java.util.Date();
			String am_pm;
			int hour = day.getHours();
			int minute = day.getMinutes();
			int second = day.getSeconds();
			if (hour / 12 == 0) {
				am_pm = "AM";
			} else {
				am_pm = "PM";
				hour = hour - 12;
			}
			String CT = hour + ":" + minute + ":" + second + " " + am_pm;
			out.println("현재 접속  시각: " + CT + "\n");
			%>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
	
	<!-- 부트스트랙 js 작동 위해 -->
	<script src="./resources/js/jquery.min.js"></script>
	<script src="./resources/js/popper.js"></script>
	<script src="./resources/js/bootstrap.min.js"></script>
</body>
</html>