<!doctype html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>네이버 로그인</title>
  <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="UTF-8"></script>
  <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
</head>
<body>
  <!-- 네이버아이디로로그인 버튼 노출 영역 -->
  <div id="naver_id_login">
	  <script type="text/javascript">
	  	var naver_id_login = new naver_id_login("AN8j6yB9frtn1s4kcSCQ", "http://localhost:8080/matzip/WMS/welcome_login.jsp");
	  	var state = naver_id_login.getUniqState();
	  	naver_id_login.setButton("green", 3, 40);
	  	naver_id_login.setDomain("http://localhost:8080/matzip/WMS/welcome.jsp");
	  	naver_id_login.setState(state);
	  	<!--naver_id_login.setPopup();-->
	  	naver_id_login.init_naver_id_login();
	  </script>
  </div>
</html>