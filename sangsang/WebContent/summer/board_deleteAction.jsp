<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID"); //할당된 세션 아이디 받도록
		}
		if(userID ==null){ //로그인이 안돼있으면
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 필요')");
			script.println("location.href = 'welcome.jsp'");
			script.println("</script>");	
		}
		//현재 글이 유효한 글인지
		int bID = 0;
		if(request.getParameter("bID")!=null){
			bID = Integer.parseInt(request.getParameter("bID"));
		}
		if(bID==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");	
		}
		Board board = new BoardDAO().getBoard(bID); //해당글 가져와서
		if(!userID.equals(board.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		}else{ //권한있는 사람들						
		BoardDAO boardDAO = new BoardDAO();
		int result = boardDAO.delete(bID);
		if(result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 삭제 실패')");
			script.println("history.back()");
			script.println("</script>");
		}
		else { 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		}
	}

	%>
</body>
</html>