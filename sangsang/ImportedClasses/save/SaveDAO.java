package save;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import user.User;
import store.Store;
import util.DatabaseUtil;

public class SaveDAO {
	
	public int save(String userID, int storeID) {
		String SQL = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		//ResultSet rs = null;
		try {
			SQL = "INSERT INTO SAVE VALUES (?, ?)";
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, storeID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //单海 坷幅
	}
	
	public int delete(String userID, int storeID) {
		String SQL = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		//ResultSet rs = null;
		try {
			SQL = "DELETE FROM SAVE WHERE userID = ? AND storeID = ?";
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, storeID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //单海 坷幅
	}
	
	public ArrayList<Save> getList(String userID){
		ArrayList<Save> saveList = null;
		String SQL = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			SQL = "SELECT * FROM SAVE WHERE userID = ?";
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			saveList = new ArrayList<Save>();
			while(rs.next()) {
				Save save = new Save();
				save.setUserID(rs.getString(1));
				save.setStoreID(rs.getInt(2));
				saveList.add(save);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return saveList;
	}
}
