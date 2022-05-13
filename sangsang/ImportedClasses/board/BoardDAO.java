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
			//mysql����̹� ã����
			Class.forName("com.mysql.jdbc.Driver"); //����̹��� mysql �����ϵ����ϴ� �Ű�ü ���� lib
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace(); //���� ���
		}

	}
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) { //��� ������
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return ""; //��������
	}
	
	public int getNext() {
		String SQL = "SELECT bID FROM BOARD ORDER BY bID DESC"; //������������ ��ȣ ����������
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) { //��� ������
				return rs.getInt(1)+1;
			}
			return 1; //ù��° �Խù��� ���
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //��������
	}
	
	public int write(String bTitle, String userID, String bContent) {
		String SQL = "INSERT INTO BOARD VALUES(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); //�������� ���� �Խù� ��ȣ
			pstmt.setString(2, bTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bContent);
			pstmt.setInt(6, 1); //availabel ����
			
			return pstmt.executeUpdate();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //��������
	}
	
	public ArrayList<Board> getList(int pageNumber){
		String SQL = "SELECT * FROM BOARD WHERE bID < ? AND bAvailable = 1 ORDER BY bID DESC LIMIT 10"; //������������ ������ 10��������
		ArrayList<Board> list = new ArrayList<Board>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);
			rs = pstmt.executeQuery();
			while (rs.next()) { //��� ������
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
	
	public boolean nextPage(int pageNumber) { //����¡ ó��
		String SQL = "SELECT * FROM BOARD WHERE bID < ? AND bAvailable = 1"; //������������ ������ 10��������		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()-(pageNumber-1)*10);
			rs = pstmt.executeQuery();
			if (rs.next()) { //��� ������
				return true; //������������ �Ѿ��
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	//�۳��� �ҷ����� �Լ�
	public Board getBoard(int bID) {
		String SQL = "SELECT * FROM BOARD WHERE bID = ?"; //������������ ������ 10��������		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bID);
			rs = pstmt.executeQuery();
			if (rs.next()) { //��� ������
				Board b = new Board();
				b.setbID(rs.getInt(1));
				b.setbTitle(rs.getString(2));
				b.setUserID(rs.getString(3));
				b.setbDate(rs.getString(4));
				b.setbContent(rs.getString(5));
				b.setbAvailable(rs.getInt(6));
				return b; //board ��ü �״�� ��ȯ
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
			pstmt.setString(1, bTitle); // �������� ���� �Խù� ��ȣ
			pstmt.setString(2, bContent);
			pstmt.setInt(3, bID);
			return pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // ��������
	}
	
	public int delete(int bID) {
		String SQL = "UPDATE BOARD SET bAvailable = 0 WHERE bID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bID); // �������� ���� �Խù� ��ȣ
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // ��������
	}
}
