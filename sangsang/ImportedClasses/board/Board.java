package board;

public class Board {
	private int bID;
	private String bTitle;
	private String userID;
	private String bDate;
	private String bContent;
	private int bAvailable;
	
	public int getbID() {
		return bID;
	}
	public void setbID(int bID) {
		this.bID = bID;
	}
	public String getbTitle() {
		return bTitle;
	}
	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getbDate() {
		return bDate;
	}
	public void setbDate(String bDate) {
		this.bDate = bDate;
	}
	public String getbContent() {
		return bContent;
	}
	public void setbContent(String bContent) {
		this.bContent = bContent;
	}
	public int getbAvailable() {
		return bAvailable;
	}
	public void setbAvailable(int bAvailable) {
		this.bAvailable = bAvailable;
	}
	
}
