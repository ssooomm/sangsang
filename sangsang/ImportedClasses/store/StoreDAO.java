package store;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class StoreDAO {
	public ArrayList<Store> getList (String storeKind, String area, String detailKind, String search, int pageNumber){
		if(area.equals("지역")) {
			area = "";
		}
		if(detailKind.equals("종류")) {
			detailKind = "";
		}
		
		ArrayList<Store> storeList = null;
		String SQL="";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			
			 SQL =
			 "SELECT * FROM STORE WHERE storeKind LIKE ? AND storeArea LIKE ? AND detailKind LIKE ? AND CONCAT(storeName, menu) LIKE ? ORDER BY storeID DESC LIMIT "
			 +pageNumber * 6 + ", " + pageNumber * 6 + 7;
			
			//SQL = "SELECT * FROM STORE WHERE area LIKE ? AND detailKind LIKE ?";
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, storeKind); //storeKind문자 포함하는지
			pstmt.setString(2, "%" + area + "%");
			pstmt.setString(3, "%" + detailKind + "%");
			pstmt.setString(4, "%" + search + "%");
			rs=pstmt.executeQuery();
			storeList = new ArrayList<Store>();
			while(rs.next()) {
				Store store = new Store(
					rs.getInt(1),
					rs.getString(2),
					rs.getString(3),
					rs.getString(4),
					rs.getString(5),
					rs.getString(6),
					rs.getString(7),
					rs.getString(8),
					rs.getString(9),
					rs.getString(10),
					rs.getString(11)
				);
				storeList.add(store);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(conn != null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try{if(pstmt != null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try{if(rs != null) rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return storeList;
	}
	
	public Store getStore(int storeID) {
		String SQL="";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			SQL = "SELECT * FROM STORE WHERE storeID = ?";
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, storeID); //storeKind문자 포함하는지
			rs=pstmt.executeQuery();
			if(rs.next()) {
				Store s = new Store();
				s.setStoreID(rs.getInt(1));
				s.setStoreName(rs.getString(2));
				s.setStoreKind(rs.getString(3));
				s.setDetailKind(rs.getString(4));
				s.setStoreArea(rs.getString(5));
				s.setAddress(rs.getString(6));
				s.setPhoneNumber(rs.getString(7));
				s.setIntro(rs.getString(8));
				s.setMenu(rs.getString(9));
				s.setCoordinate(rs.getString(10));
				s.setContent(rs.getString(11));
				return s;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ArrayList<Store> getStoreList (int storeID){
		ArrayList<Store> storeList = null;
		String SQL="";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			
			SQL ="SELECT * FROM STORE WHERE storeID = ?";
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, storeID); //storeKind문자 포함하는지
			rs=pstmt.executeQuery();
			storeList = new ArrayList<Store>();
			while(rs.next()) {
				Store store = new Store(
					rs.getInt(1),
					rs.getString(2),
					rs.getString(3),
					rs.getString(4),
					rs.getString(5),
					rs.getString(6),
					rs.getString(7),
					rs.getString(8),
					rs.getString(9),
					rs.getString(10),
					rs.getString(11)
				);
				storeList.add(store);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(conn != null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try{if(pstmt != null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try{if(rs != null) rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return storeList;
	}
	
	public ArrayList<Store> getRandomList (){
		ArrayList<Store> storeList = null;
		String SQL="";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			
			 SQL ="SELECT * FROM STORE";
			
			//SQL = "SELECT * FROM STORE WHERE area LIKE ? AND detailKind LIKE ?";
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			rs=pstmt.executeQuery();
			storeList = new ArrayList<Store>();
			while(rs.next()) {
				Store store = new Store(
					rs.getInt(1),
					rs.getString(2),
					rs.getString(3),
					rs.getString(4),
					rs.getString(5),
					rs.getString(6),
					rs.getString(7),
					rs.getString(8),
					rs.getString(9),
					rs.getString(10),
					rs.getString(11)
				);
				storeList.add(store);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try{if(conn != null) conn.close();}catch(Exception e) {e.printStackTrace();}
			try{if(pstmt != null) pstmt.close();}catch(Exception e) {e.printStackTrace();}
			try{if(rs != null) rs.close();}catch(Exception e) {e.printStackTrace();}
		}
		return storeList;
	}
	
}
