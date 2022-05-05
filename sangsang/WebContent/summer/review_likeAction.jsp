<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import  = "user.UserDAO"%>
<%@ page import  = "review.ReviewDAO"%>
<%@ page import  = "likey.LikeyDAO"%>
<%@ page import = "java.io.PrintWriter"%>
<%!
	public static String getClientIP(HttpServletRequest request) {
		String ip = request.getHeader("X-FORWARDED-FOR");
		if(ip==null || ip.length()==0){
			ip=request.getHeader("Proxy-Client-IP");
		}
		if(ip==null || ip.length()==0){
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ip==null || ip.length()==0){
			ip = request.getRemoteAddr();
		}
		return ip;
	}
%>

<%
	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID = (String) session.getAttribute("userID");
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
	if(request.getParameter("reviewID")!=null){
		reviewID = request.getParameter("reviewID");
	}
	
	ReviewDAO reviewDAO = new ReviewDAO();
	LikeyDAO likeyDAO = new LikeyDAO();
	int result = likeyDAO.like(userID, reviewID, getClientIP(request));

	if(result == 1){
		result = reviewDAO.like(reviewID);
		if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('추천이 완료되었습니다.');");
			script.println("location.href='review.jsp'");
			script.println("</script>");
			script.close();
			return;
		} else{
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
		script.println("alert('이미 추천을 누른 리뷰 글입니다.');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
	
%>