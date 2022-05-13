package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardDAO {
	private Connection conn;

	private ResultSet rs;
	
	public BoardDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost/ohsoomin";
			String dbID = "ohsoomin";
			String dbPassword = "sang2108!";
			//mysql드라이버 찾도록
			Class.forName("com.mysql.jdbc.Driver"); //드라이버는 mysql 접속하도록하는 매게체 역할 lib
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace(); //오류 출력
		}

	}
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) { //결과 있으면
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //데베오류
	}
	
	public int getNext() {
		String SQL = "SELECT bID FROM BOARD ORDER BY bID DESC"; //내림차순으로 번호 가져오도록
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) { //결과 있으면
				return rs.getInt(1)+1;
			}
			return 1; //첫번째 게시물인 경우
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데베오류
	}
	
	public int write(String bTitle, String userID, String bContent) {
		String SQL = "INSERT INTO BOARD VALUES(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); //다음번에 쓰일 게시물 번호
			pstmt.setString(2, bTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bContent);
			pstmt.setInt(6, 1); //availabel 상태
			
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데베오류
	}
	
	public ArrayList<Board> getList(int pageNumber){
		String SQL = "SELECT * FROM BOARD WHERE bID < ? AND bAvailable = 1 ORDER BY bID DESC LIMIT 10"; //내림차순으로 위에서 10개까지만
		ArrayList<Board> list = new ArrayList<Board>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);
			rs = pstmt.executeQuery();
			while (rs.next()) { //결과 있으면
				Board b = new Board();
				b.setbID(rs.getInt(1));
				b.setbTitle(rs.getString(2));
				b.setUserID(rs.getString(3));
				b.setbDate(rs.getString(4));
				b.setbContent(rs.getString(5));
				b.setbAvailable(rs.getInt(6));
				list.add(b);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) { //페이징 처리
		String SQL = "SELECT * FROM BOARD WHERE bID < ? AND bAvailable = 1"; //내림차순으로 위에서 10개까지만		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);
			rs = pstmt.executeQuery();
			if (rs.next()) { //결과 있으면
				return true; //다음페이지로 넘어가게
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//글내용 불러오는 함수
	public Board getBoard(int bID) {
		String SQL = "SELECT * FROM BOARD WHERE bID = ?"; //내림차순으로 위에서 10개까지만		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bID);
			rs = pstmt.executeQuery();
			if (rs.next()) { //결과 있으면
				Board b = new Board();
				b.setbID(rs.getInt(1));
				b.setbTitle(rs.getString(2));
				b.setUserID(rs.getString(3));
				b.setbDate(rs.getString(4));
				b.setbContent(rs.getString(5));
				b.setbAvailable(rs.getInt(6));
				return b; //board 객체 그대로 반환
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int bID, String bTitle, String bContent) {
		String SQL = "UPDATE BOARD SET bTitle = ?, bContent = ? WHERE bID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bTitle); // 다음번에 쓰일 게시물 번호
			pstmt.setString(2, bContent);
			pstmt.setInt(3, bID);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데베오류
	}
	
	public int delete(int bID) {
		String SQL = "UPDATE BOARD SET bAvailable = 0 WHERE bID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bID); // 다음번에 쓰일 게시물 번호
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데베오류
	}
}
