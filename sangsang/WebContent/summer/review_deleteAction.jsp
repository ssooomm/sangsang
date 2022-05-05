<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import  = "user.UserDAO"%>
<%@ page import  = "review.ReviewDAO"%>
<%@ page import  = "likey.Likey"%>
<%@ page import = "java.io.PrintWriter"%>

<%
	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID = (String) session.getAttribute("userID");
		System.out.println(userID);
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.');");
		script.println("location.href = 'welcome.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	request.setCharacterEncoding("UTF-8");
	String reviewID = null;
	System.out.println(reviewID);
	if(request.getParameter("reviewID") != null){
		reviewID = request.getParameter("reviewID");
		System.out.println(reviewID);
	}
	//System.out.println(reviewID);
	ReviewDAO reviewDAO = new ReviewDAO();
	//System.out.println(reviewID);
	if(userID.equals(reviewDAO.getUserID(reviewID))){
		//System.out.println(reviewID);
		int result = new ReviewDAO().delete(reviewID);
		if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제가 완료되었습니다.');");
			script.println("location.href='review.jsp'");
			script.println("</script>");
			script.close();
			return;
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데베오류 발생.');");
			script.println("history.back();");
			script.println("</script>");
			script.close();
			return;
		}
	}else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('다른 사용자의 글은 삭제할 수 없습니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
%>