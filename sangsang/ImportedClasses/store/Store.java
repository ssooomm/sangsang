package store;

public class Store {
	int storeID;
	String storeName;
	String storeKind;
	String detailKind;
	String storeArea;
	String address;
	String phoneNumber;
	String intro;
	String menu;
	String coordinate;
	String content;
	
	public int getStoreID() {
		return storeID;
	}

	public void setStoreID(int storeID) {
		this.storeID = storeID;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public String getMenu() {
		return menu;
	}

	public void setMenu(String menu) {
		this.menu = menu;
	}

	public String getCoordinate() {
		return coordinate;
	}

	public void setCoordinate(String coordinate) {
		this.coordinate = coordinate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Store() {
		
	}

	public Store(int storeID, String storeName, String storeKind, String detailKind, String storeArea, String address,
			String phoneNumber, String intro, String menu, String coordinate, String content) {
		super();
		this.storeID = storeID;
		this.storeName = storeName;
		this.storeKind = storeKind;
		this.detailKind = detailKind;
		this.storeArea = storeArea;
		this.address = address;
		this.phoneNumber = phoneNumber;
		this.intro = intro;
		this.menu = menu;
		this.coordinate = coordinate;
		this.content = content;
	}
	
	
	
	
	
}
