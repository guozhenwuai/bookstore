package model;

public class User {
	private int id;
	private String username;
    private String password;
    private String email;
    private String receiver;
	private String address;
	private String phone;
    private int isAdmin;
    
    public int getId() {
        return id;
    }

    public void setId(int newValue) {
        id = newValue;
    }
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String newValue) {
        username = newValue;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String newValue) {
        password = newValue;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String newValue) {
        email = newValue;
    }
    
    public int getIsAdmin(){
    	return isAdmin;
    }
    
    public void setIsAdmin(int newValue){
    	isAdmin = newValue;
    }
    
    public String isAdminStr(){
		if(isAdmin()){
			return "Yes";
		}
		else{
			return "No";
		}
	}
	
	public boolean isAdmin(){
		return isAdmin==1;
	}
	
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
    
}
