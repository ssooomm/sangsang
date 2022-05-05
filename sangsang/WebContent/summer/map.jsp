<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>Insert title here</title>
	<script type="text/javascript"
			src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=gi3c0u68hv">
	</script>
	
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
<div id=map>
<script>
	var store1 = new naver.maps.LatLng(37.58178, 127.00108),
	    map = new naver.maps.Map('map', {
	        center: store1.destinationPoint(0, 500),
	        zoom: 15
	    }),
	    marker = new naver.maps.Marker({
	        map: map,
	        position: store1
	    });

	var contentString = [
		 '<div class="iw_inner">',
	        '   <h3>정돈</h3>',
	        '   <p>서울 종로구 대학로9길 12청<br />',
	        '       <img src="./resources/images/정돈2.jpg" width="60" height="60" alt="정돈" class="thumb" /><br />',
	        '       02-전화번호 | 음식점 &gt; 일식<br />',
	        '       <a href="http://www.seoul.go.kr" target="_blank">www.seoul.go.kr/</a>',
	        '   </p>',
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
</body>
</html>