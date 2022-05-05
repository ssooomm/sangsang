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
	<div id=map class="border border-2 border-info">
	<script>
		var store1 = new naver.maps.LatLng(37.59295648726987, 127.0185317641264),
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
</body>
</html>