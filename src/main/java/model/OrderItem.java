package model;

import java.io.Serializable;
import java.math.BigDecimal;

import model.Book;

public class OrderItem implements Serializable{

	private static final long serialVersionUID = 1L;
	private int orderId;
	private int bookId;
	private int num;
	private int price;
	private String realPrice;
	private Book book;
	
	public int getOrderId() {
		return orderId;
	}
	
	public void setOrderId(int newValue) {
		orderId = newValue;
	}
	
	public int getBookId() {
		return bookId;
	}
	
	public void setBookId(int newValue) {
		bookId = newValue;
	}
	
	public int getNum() {
		return num;
	}
	
	public void setNum(int newValue){
		num = newValue;
	}
	
	public int getPrice() {
		return price;
	}
	
	public void setPrice(int newValue){
		price = newValue;
		BigDecimal p = new BigDecimal(price);
		BigDecimal mul = new BigDecimal(100);
		p = p.divide(mul);
		realPrice = p.toString();
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

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}
}
