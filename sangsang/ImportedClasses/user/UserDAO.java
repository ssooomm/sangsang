package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

//crtl+shift+o
public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
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
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; //로그인 성공
				}
				else {
					return 0; //비밀번호 불일치
				}
			}
			return -1; //아이디 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; //데베 오류 의미
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserBorn());
			pstmt.setString(6, user.getUserEmail());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데베 오류
	}
}
