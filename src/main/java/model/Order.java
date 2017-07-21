package model;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class Order {
	private int id;
	private int userId;
	private String receiver;
	private String address;
	private String phone;
	private int totalPrice;//price in cents
	private String realPrice;
	private Date date;
	private Set<OrderItem> orderItems = new HashSet<OrderItem>();
	
	public int getId() {
		return id;
	}
	
	public void setId(int newValue) {
		id = newValue;
	}
	
	public int getUserId() {
		return userId;
	}
	
	public void setUserId(int newValue) {
		userId = newValue;
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

	public String getRealPrice(){
		return realPrice;
	}
	
	public void setRealPrice(String newValue){
		realPrice = newValue;
		BigDecimal p = new BigDecimal(newValue);
    	BigDecimal mul = new BigDecimal(100);
    	p = p.multiply(mul);
    	totalPrice = p.intValue();
	}
	
	public void setTotalPrice(int newValue){
		totalPrice = newValue;
		BigDecimal p = new BigDecimal(totalPrice);
		BigDecimal mul = new BigDecimal(100);
		p = p.divide(mul);
		realPrice = p.toString();
	}
	
	public int getTotalPrice() {
		return totalPrice;
	}
	
	public Date getDate() {
		return date;
	}
	
	public String getDateStr(){
		if(date==null){
			return "";
		}
		return date.toString();
	}
	
	public void setDate(Date newValue) {
		date = newValue;
	}
	
	public void setDate(String newValue){
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			date = sdf.parse(newValue);
		} catch (ParseException e) {
			System.out.println(e.getMessage()); 
		}
	}
	
	public Set<OrderItem> getOrderItems(){
		return orderItems;
	}
	
	public void setOrderItems(Set<OrderItem> newValue){
		orderItems = newValue;
	}
	
}
