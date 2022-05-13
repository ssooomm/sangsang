package review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;


public class ReviewDAO {
	// ���̵�� ��� �޾Ƽ� �α��� �õ� ���ִ� �Լ�
	public int write(Review review) {
		String SQL = "INSERT INTO REVIEW VALUES (NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, review.getUserID());
			pstmt.setString(2, review.getStoreKind());
			pstmt.setString(3, review.getDetailKind());
			pstmt.setString(4, review.getStoreArea());
			pstmt.setString(5, review.getStoreName());
			pstmt.setInt(6, review.getTotalScore());
			pstmt.setInt(7, review.getTaste());
			pstmt.setInt(8, review.getService());
			pstmt.setInt(9, review.getAtmosphere());
			pstmt.setString(10, review.getReviewTitle());
			pstmt.setString(11, review.getReviewContent());
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // ���� ����
	}
	
	public ArrayList<Review> getList (String storeKind, String searchType, String search, int pageNumber){
		if(storeKind.equals("��ü")) {
			storeKind = "";
		}
		ArrayList<Review> reviewList = null; //����� ���� ����Ʈ
		String SQL="";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			if(searchType.equals("�ֽż�")) {
				SQL = "SELECT * FROM REVIEW WHERE storeKind LIKE ? AND CONCAT(storeName, storeArea, reviewTitle, reviewContent) LIKE ? ORDER BY reviewID DESC LIMIT " +
						pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}else if(searchType.equals("��õ��")){
				SQL = "SELECT * FROM REVIEW WHERE storeKind LIKE ? AND CONCAT(storeName, storeArea, reviewTitle, reviewContent) LIKE ? ORDER BY likeCount DESC LIMIT " +
						pageNumber * 5 + ", " + pageNumber * 5 + 6;
			}
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + storeKind + "%"); //storeKind���� �����ϴ���
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			reviewList = new ArrayList<Review>();
			while(rs.next()) {
				Review review = new Review(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getString(5),
						rs.getString(6),
						rs.getInt(7),
						rs.getInt(8),
						rs.getInt(9),
						rs.getInt(10),
						rs.getString(11),
						rs.getString(12),
						rs.getInt(13)
				);
				reviewList.add(review);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(conn != null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try{if(pstmt != null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try{if(rs != null) rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return reviewList; 
	}
	
	public int like(String reviewID) {
		String SQL = "UPDATE REVIEW SET likeCount = likeCount + 1 WHERE reviewID =?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(reviewID));
			return pstmt.executeUpdate(); //������ ��ȯ			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(conn != null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try{if(pstmt != null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try{if(rs != null) rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return -1; //���� ����
	}
	
	public int delete(String reviewID) {
		String SQL = "DELETE FROM REVIEW WHERE reviewID =?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(reviewID));
			return pstmt.executeUpdate(); //������ ��ȯ			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(conn != null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try{if(pstmt != null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try{if(rs != null) rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return -1; //���� ����
	}
	
	public String getUserID(String reviewID) { //���� �ۼ���
		String SQL = "SELECT userID FROM REVIEW WHERE reviewID = ?"; 
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(reviewID));
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(conn != null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try{if(pstmt != null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try{if(rs != null) rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return null; //�������� �ʴ�
	}
	
	
	
}
