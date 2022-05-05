<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import  = "review.Review"%>
<%@ page import  = "review.ReviewDAO"%>
<%@ page import = "java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;

if(session.getAttribute("userID")!=null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		session.setAttribute("userID",userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'welcome.jsp';");
		script.println("</script>");
		script.close();
		return;
	}

	String storeKind =null;
	String detailKind =null;
	String storeArea =null;
	String storeName =null;
	int totalScore =0;
	int taste =0;
	int service=0;
	int atmosphere=0;
	String reviewTitle =null;
	String reviewContent =null;
	
	if(request.getParameter("storeKind")!= null ){
		storeKind = request.getParameter("storeKind");
	}
	if(request.getParameter("detailKind")!= null ){
		detailKind = request.getParameter("detailKind");
	}
	
	if(request.getParameter("storeArea")!= null ){
		storeArea = request.getParameter("storeArea");
	}
	if(request.getParameter("storeName")!= null ){
		storeName = request.getParameter("storeName");
	}
	if(request.getParameter("reviewContent")!= null ){
		reviewContent = request.getParameter("reviewContent");
	}
	if(request.getParameter("totalScore")!= null ){
		try{
			totalScore = Integer.parseInt(request.getParameter("totalScore"));
		}catch (Exception e){
			System.out.println("종합 점수 데이터 오류");
		}
	}
	if(request.getParameter("taste")!= null ){
		try{
			taste = Integer.parseInt(request.getParameter("taste"));
		}catch (Exception e){
			System.out.println("맛 데이터 오류");
		}
	}
	if(request.getParameter("service")!= null ){
		try{
			service = Integer.parseInt(request.getParameter("service"));
		}catch (Exception e){
			System.out.println("서비스 데이터 오류");
		}
	}
	if(request.getParameter("atmosphere")!= null ){
		try{
			atmosphere = Integer.parseInt(request.getParameter("atmosphere"));
		}catch (Exception e){
			System.out.println("분위기 데이터 오류");
		}
		
	}
	if(request.getParameter("reviewTitle")!= null ){
		reviewTitle = request.getParameter("reviewTitle");
	}
	if(request.getParameter("reviewContent")!= null ){
		reviewContent = request.getParameter("reviewContent");
	}
	
	
	if( storeKind == null || detailKind == null || storeArea == null || storeName == null ||
			totalScore == 0 || taste == 0 || service == 0 || atmosphere == 0 ||
					reviewTitle == null || reviewContent == null || reviewTitle.equals("") || reviewContent.equals("")){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	ReviewDAO reviewDAO = new ReviewDAO();
	int result = reviewDAO.write(new Review(0, userID, storeKind, detailKind, 
			storeArea, storeName, totalScore, taste, service,
			atmosphere, reviewTitle, reviewContent, 0));
	if (result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('리뷰 등록에 실패했습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}else{
		session.setAttribute("userID",userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'review.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
%>