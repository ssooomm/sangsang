package save;

public class Save {
	String userID;
	int storeID;
	
	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public int getStoreID() {
		return storeID;
	}

	public void setStoreID(int storeID) {
		this.storeID = storeID;
	}

	public Save() {
		
	}

	public Save(String userID, int storeID) {
		this.userID = userID;
		this.storeID = storeID;
	}
	
}
