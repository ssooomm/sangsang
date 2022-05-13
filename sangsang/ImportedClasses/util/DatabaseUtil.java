package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
	public static Connection getConnection(){//연결자체 관리
		try {
			String dbURL = "jdbc:mysql://localhost/ohsooomin";
			String dbID = "ohsoomin";
			String dbPassword = "sang2108!";
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
