package review;

public class Review {
	int reviewID;
	String userID;
	String storeKind;
	String detailKind;
	String storeArea;
	String storeName;
	int totalScore;
	int taste;
	int service;
	int atmosphere;
	String reviewTitle;
	String reviewContent;
	int likeCount;
	
	public int getReviewID() {
		return reviewID;
	}
	public void setReviewID(int reviewID) {
		this.reviewID = reviewID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getStoreKind() {
		return storeKind;
	}
	public void setStoreKind(String storeKind) {
		this.storeKind = storeKind;
	}
	public String getDetailKind() {
		return detailKind;
	}
	public void setDetailKind(String detailKind) {
		this.detailKind = detailKind;
	}
	public String getStoreArea() {
		return storeArea;
	}
	public void setStoreArea(String storeArea) {
		this.storeArea = storeArea;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public int getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(int totalScore) {
		this.totalScore = totalScore;
	}
	public int getTaste() {
		return taste;
	}
	public void setTaste(int taste) {
		this.taste = taste;
	}
	public int getService() {
		return service;
	}
	public void setService(int service) {
		this.service = service;
	}
	public int getAtmosphere() {
		return atmosphere;
	}
	public void setAtmosphere(int atmosphere) {
		this.atmosphere = atmosphere;
	}
	public String getReviewTitle() {
		return reviewTitle;
	}
	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	public Review() {
		
	}
	
	public Review(int reviewID, String userID, String storeKind, String detailKind, String storeArea, String storeName,
			int totalScore, int taste, int service, int atmosphere, String reviewTitle, String reviewContent,
			int likeCount) {
		super();
		this.reviewID = reviewID;
		this.userID = userID;
		this.storeKind = storeKind;
		this.detailKind = detailKind;
		this.storeArea = storeArea;
		this.storeName = storeName;
		this.totalScore = totalScore;
		this.taste = taste;
		this.service = service;
		this.atmosphere = atmosphere;
		this.reviewTitle = reviewTitle;
		this.reviewContent = reviewContent;
		this.likeCount = likeCount;
	}

}
