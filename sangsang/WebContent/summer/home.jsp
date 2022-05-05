<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<% int i = 0; %>
<head>
	<meta charset="UTF-8">
	<!-- 화면 유연하게 -->
	<meta name="viewport"
		content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>home</title>
	<!-- 부트스트랙 파일 저장한거 가져옴 -->
	<link rel="stylesheet" href="./resources/css/bootstrap.MYmin.css">
	<!-- 부트스트랩 말고 직접 만든 css -->
	<link rel="stylesheet" href="./resources/css/custom.css">
	<!-- 이모티콘 가져옴 -->
	<script src="https://kit.fontawesome.com/7e85906bdf.js" crossorigin="anonymous"></script>	
	<script type="text/javascript"
		src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gi3c0u68hv">
	</script>
	<style>
/* 		#container{
		width:650px;
		margin:0 auto;
		padding:5px;
		border: 1px solid #ccc;
		}
		#check{
		width:650px;
		margin:0 auto;
		padding:5px;
		border:1px solid #ccc;
		} */
		#map{
		width:100%;
		height:400px;
		margin:0 auto;
		padding:5px;
		border: 1px solid #ccc;
		}
		h1{
			color: #f1bc40;
			fofnt-size: 42px;
			background: #7a7a7a;
			margin: 0;
			padding: 0px;
			text-align: center;
		}
		h6{
		color: white;
			fofnt-size: 15px;
			background: #7a7a7a;
			margin: 0;
			padding: 0px;
			text-align: center;
		}
	</style>
	<script>
	
	</script>
</head>

<body>
<main>
<!-- *********nav바************ -->
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
						<a class="nav-link active" href="home.jsp">Home
							<!-- <span class="visually-hidden">(current)</span> -->
						</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="store_rst.jsp">음식점</a></li>
					<li class="nav-item"><a class="nav-link" href="store_cafe.jsp">카페</a></li>
					<li class="nav-item"><a class="nav-link" href="review.jsp">리뷰</a></li>
					<li class="nav-item"><a class="nav-link" href="board.jsp">게시판</a></li>
					
					<!-- <li class="nav-item">
						<a id="icons" href="#"><i class="fab fa-instagram"></i></a>
					</li>
					<li class="nav-item">
						<a id="icons" href="#"><i class="fab fa-facebook-square"></i></a>
					</li> -->
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
				<!-- <form class="d-flex">
					<input class="form-control me-sm-2" type="text"
						placeholder="Search">
					<button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
				</form> -->

			</div>
		</div>
	</nav>
	
<!-- ******main***** -->
	<div class="container">
		<div class="row">
	    	<h5>학교 주변 맛집을 구경해보세요!</h5>
		</div>
		<div class="row">
		
		<div id="map">

		<script>
		//var HOME_PATH = window.HOME_PATH || '.';
		var MARKER_FOOD = {
				//성신
		        "팔백집": [37.58945, 127.01983],
		        "수아당": [37.59306523684432, 127.01804199797324],
		        "소르빌로": [37.592957484331265, 127.01851974338688],
		        "버거파크": [37.590644361553196, 127.01844904941947],
		        "애정마라샹궈": [37.592158579833935, 127.01722034255474],
		        "라라면가": [37.59089024182811, 127.01967828273898],
		        "윤휘식당": [37.5910143617274, 127.01920929554676],
		        "상미규카츠": [37.590814226663106, 127.01701172569767],
		        //"I0": [MARKER_SPRITE_X_OFFSET*8, 0],
				//한성
		        "거기": [37.586243161563104, 127.01029035894558],
		        "운봉손칼국수": [37.587191387961326, 127.01079184872768],
		        "파도의숲": [37.58836813353186, 127.01633860091253],
		        "너의냠냠버거": [37.5902018095009, 127.00379121753518],
		        "향만옥": [37.5883508680458, 127.00956204428837],
		        "공푸": [37.58879857430562, 127.01614942422472],
		        "다바타식당": [37.58598725258122, 127.01085864131517],
		        "스시산": [37.58963822044287, 127.00443588339448],
		        //"I1": [37.58190051610521, 127.00107296821392],
				//혜화
		        "혜화칼국수": [37.58654814124331, 127.00150574393997],
		        "대포찜닭": [37.581820651909105, 127.00086759363467],
		        "정돈": [37.58177060430239, 127.00108637323783],
		        "호호식당": [37.58186718942046, 127.00003160835412],
		        "진아춘": [37.58281742382504, 127.00046867668232],
		        "훠궈나라": [37.58297423012947, 126.99915309947129],
		        "은행골": [37.58181842058817, 126.99980978072132],
		        "교토스시": [37.58018369669375, 127.00434157684064]
		        //"I2": [MARKER_SPRITE_X_OFFSET*8, MARKER_SPRITE_Y_OFFSET*2]
		
		    };

		var MARKER_CAFE = {
			//한성
	        "달콤한 위로": [37.5890574464904, 127.00421212757027],
	        "아워레스트": [37.5874402809468, 127.01034937291008],
	        "패밀리엔프랜즈": [37.58652716249119, 127.01042865951854],
	        "커피매터스": [37.58976893020492, 127.01142352270105],
	        //성신
	        "모블러": [37.59503808409778, 127.02048182321471],
	        "디프커피": [37.595001205265376, 127.0218901932854],
	        "리이케": [37.59249881243896, 127.02027570003882],
	        "로스디아스": [37.59016065885402, 127.01887849069847],
	        //혜화
	        "낫컴플리트": [37.584195858806204, 126.9981102546677],
	        "그림제작소": [37.582482788323475, 126.99850610841273],
	        "일월일일": [37.58264702304542, 126.99804026503016],
	        "솔트 24": [37.58266761823542, 126.99876976928577]
		};

		//지도 중심
		var map = new naver.maps.Map('map', {
		    center: new naver.maps.LatLng(37.5874, 127.0072),
		    zoom: 15
		}); 

		var bounds = map.getBounds(),
		    southWest = bounds.getSW(),
		    northEast = bounds.getNE(),
		    lngSpan = northEast.lng() - southWest.lng(),
		    latSpan = northEast.lat() - southWest.lat();

		
		var markers = [],
		    infoWindows = [];
		//var x=0;
		
		for (var key in MARKER_FOOD) {

			 var position = new naver.maps.LatLng(
					 MARKER_FOOD[key][0], MARKER_FOOD[key][1]);

	
		    var marker = new naver.maps.Marker({
		        map: map,
		        position: position,
		        title: key,
		        icon: {
		        	content:['<img src="./resources/images/mark_rst.png" width="50" height="50"/>'].join(''),
		            size: new naver.maps.Size(24, 37),
		            anchor: new naver.maps.Point(12, 37),
		            origin: new naver.maps.Point(MARKER_FOOD[key][0], MARKER_FOOD[key][1])
		        },
		        zIndex: 100
		    });
		
		    
		    var infoWindow = new naver.maps.InfoWindow({
		        content: '<div style="width:150px;text-align:center;padding:10px;">"'+ key +'"</b></div>'
		    });

		    markers.push(marker);
		    infoWindows.push(infoWindow);
		};

		for (var key1 in MARKER_CAFE) {

			 var position1 = new naver.maps.LatLng(
					 MARKER_CAFE[key1][0], MARKER_CAFE[key1][1]);

	
		    var marker1 = new naver.maps.Marker({
		        map: map,
		        position: position1,
		        title: key1,
		        icon: {
		        	content:['<img src="./resources/images/mark_cafe.png" width="50" height="50"/>'].join(''),
		        	//url:'./summerPR/images/rst-mark.png',
		        	//url: './resources/images/rstmark.png',
		            size: new naver.maps.Size(24, 37),
		            anchor: new naver.maps.Point(12, 37),
		            origin: new naver.maps.Point(MARKER_CAFE[key1][0], MARKER_CAFE[key1][1])
		        },
		        zIndex: 100
		    });
		
		    
		    var infoWindow1 = new naver.maps.InfoWindow({
		        content: '<div style="width:150px;text-align:center;padding:10px;">"'+ key1 +'"</b></div>'
		    });

		    markers.push(marker1);
		    infoWindows.push(infoWindow1);
		};
		naver.maps.Event.addListener(map, 'idle', function() {
		    updateMarkers(map, markers);
		});

		function updateMarkers(map, markers) {

		    var mapBounds = map.getBounds();
		    var marker, position;

		    for (var i = 0; i < markers.length; i++) {

		        marker = markers[i]
		        position = marker.getPosition();

		        if (mapBounds.hasLatLng(position)) {
		            showMarker(map, marker);
		        } else {
		            hideMarker(map, marker);
		        }
		    }
		}

		function showMarker(map, marker) {

		    if (marker.setMap()) return;
		    marker.setMap(map);
		}

		function hideMarker(map, marker) {

		    if (!marker.setMap()) return;
		    marker.setMap(null);
		}

		// 해당 마커의 인덱스를 seq라는 클로저 변수로 저장하는 이벤트 핸들러를 반환합니다.
		function getClickHandler(seq) {
		    return function(e) {
		        var marker = markers[seq],
		            infoWindow = infoWindows[seq];

		        if (infoWindow.getMap()) {
		            infoWindow.close();
		        } else {
		            infoWindow.open(map, marker);
		        }
		    }
		}

		for (var i=0, ii=markers.length; i<ii; i++) {
		    naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
		}
		</script>
		</div>
		</div>
	</div>
<%@ include file="footer.jsp"%>
</main>
	
	<script src="./resources/js/jquery.min.js"></script>
	<script src="./resources/js/popper.js"></script>
	<script src="./resources/js/bootstrap.min.js"></script>
</body>
</html>