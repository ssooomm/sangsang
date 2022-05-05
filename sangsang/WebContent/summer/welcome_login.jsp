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
	<meta name="viewport"
		content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>welcome</title>
	<!-- 부트스트랙 파일 저장한거 가져옴 -->
	<link rel="stylesheet" href="./resources/css/bootstrap.MYmin.css">
	<!-- 부트스트랩 말고 직접 만든 css -->
	<link rel="stylesheet" href="./resources/css/custom.css">
	<!-- 이모티콘 가져옴 -->
	<script src="https://kit.fontawesome.com/7e85906bdf.js" crossorigin="anonymous"></script>
	<!-- 지도가져옴 -->
	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gi3c0u68hv"></script>
	
	<style>
		#map{
			width:auto;
			height:300px;
			margin:0 auto;
			padding:5px;
			border: 1px solid #ccc;
			}
	</style>
	
</head>

<body>
	<%@ include file="nav.jsp"%>

	<main class="container">
		<div class="row row-cols-1 row-cols-md-2 mb-3 text-center">
			<div class="col-md-6">
				<div class="card bg-light border-light mb-3 h-100">
					
					<div class="card-body">
						<h4 class="my-0 fw-normal">오늘의 맛집 추천</h4>
<% 
	ArrayList <Store> randomList = new ArrayList<Store>();
	randomList = new StoreDAO().getRandomList();
	Random random = new Random();
	int num = (int)(random.nextInt(randomList.size())+1);
	
	Store recommend = new StoreDAO().getStore(num);
	Store store = new Store();
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
						<button type="button" class="w-100 btn btn-lg btn-outline-warning">Detail</button>
					</div>
				</div>
			</div>
			
			<div class="col-md-6">
				<div class="card bg-light border-light mb-3 h-100">
					<div class="card-body">
						<div id=map>
						<script>
							
							var store1 = new naver.maps.LatLng(<%= recommend.getCoordinate() %>),
							    map = new naver.maps.Map('map', {
							        center: store1.destinationPoint(0, 500),
							        zoom: 15
							    }),
							    marker = new naver.maps.Marker({
							        map: map,
							        position: store1
							    });
						
							var contentString = [
								'<div class="m-2">',
							        '<img src="./resources/images/'+'<%= recommend.getStoreName() %>'+'2.jpg" width="100" height="100" class="m-2" />',
							        '<p>'+'<%= recommend.getAddress() %>'+'</br>',
							        '<%= recommend.getPhoneNumber() %>'+'</p>',
							    '</div>'
							    ].join('');
						
						
							var infowindow = new naver.maps.InfoWindow({
							    content: contentString
							});
						
							naver.maps.Event.addListener(marker, "click", function(e) {
							    if (infowindow.getMap()) {
							        infowindow.close();
							    } else {
							        infowindow.open(map, marker);
							    }
							});
						
							infowindow.open(map, marker);
							</script>
							</div>
					</div>
				</div>
			</div>
		</div>
	</main>

	<!-- 시간표시 -->
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
		<hr>
	</div>	
	<%@ include file="footer.jsp"%>
	
	<!-- 부트스트랙 js 작동 위해 -->
	<script src="./resources/js/jquery.min.js"></script>
	<script src="./resources/js/popper.js"></script>
	<script src="./resources/js/bootstrap.min.js"></script>
</body>
</html>