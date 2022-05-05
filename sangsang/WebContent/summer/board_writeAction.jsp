<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="board" class="board.Board" scope="page" />
<jsp:setProperty name="board" property="bTitle" />
<jsp:setProperty name="board" property="bContent" />

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
	
		}else{ //로그인된 사람들
			if(board.getbTitle() == null || board.getbContent() == null){
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('입력이 안 된 사항이 있습니다.')");
						script.println("history.back()");
						script.println("</script>");
					} else{
						BoardDAO boardDAO = new BoardDAO();
						int result = boardDAO.write(board.getbTitle(), userID, board.getbContent());
						if(result == -1) { //id는 기본키, 동일한 id 입력되면 데베 오류
							PrintWriter script = response.getWriter();
							script.println("<script>");
							script.println("alert('데베 오류 글쓰기 실패')");
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
		} 
		
	%>
</body>
</html>