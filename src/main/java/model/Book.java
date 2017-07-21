package model;

import java.math.BigDecimal;

public class Book {
	private int id;
	private String name;
	private String author;
	private String realPrice;
	private int price;//price in cents 
	private String category;
	
	public int getId() {
		return id;
	}
	
	public void setId(int newValue) {
		id = newValue;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String newValue) {
		name = newValue;
	}
	
	public String getAuthor(){
		return author;
	}
	
	public void setAuthor(String newValue){
		author = newValue;
	}
	
	public void setPrice(int newValue){
		price = newValue;
		BigDecimal p = new BigDecimal(price);
		BigDecimal mul = new BigDecimal(100);
		p = p.divide(mul);
		realPrice = p.toString();
	}
	
	public int getPrice() {
		return price;
	}
	
	public String getRealPrice(){
		return realPrice;
	}
	
	public void setRealPrice(String newValue){
		realPrice = newValue;
		BigDecimal p = new BigDecimal(newValue);
    	BigDecimal mul = new BigDecimal(100);
    	p = p.multiply(mul);
    	price = p.intValue();
	}
	
	public String getCategory() {
		return category;
	}
	
	public void setCategory(String newValue) {
		category = newValue;
	}
	
}
