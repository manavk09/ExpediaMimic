package cs336proj;

public class Customer {
	
	private String username;
	private String password;
	private String fName;
	private String lName;
	

	public Customer() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Customer(String username, String password, String fName, String lName) {
		super();
		this.username = username;
		this.password = password;
		this.fName = fName;
		this.lName = lName;
	}
	
	public String getfName() {
		return fName;
	}

	public void setfName(String fName) {
		this.fName = fName;
	}

	public String getlName() {
		return lName;
	}

	public void setlName(String lName) {
		this.lName = lName;
	}
	
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	

}
