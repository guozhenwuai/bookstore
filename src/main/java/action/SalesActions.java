package action;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.opensymphony.xwork2.ModelDriven;

import model.Book;
import model.Order;
import model.OrderItem;
import model.User;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import service.BookService;
import service.OrderItemService;
import service.OrderService;
import service.UserService;


public class SalesActions extends BaseAction {
	private static final long serialVersionUID = 1L;

	private OrderItemService orderItemService;
	private OrderService orderService;
	private BookService bookService;
	private UserService userService;
	
	private String result;
	
	private int id;
	private Date start;
	private Date end;
	private String book;
	private String category;
	
	public void setOrderItemService(OrderItemService orderItemService) {
		this.orderItemService = orderItemService;
	}
	
	public OrderItemService getOrderItemService() {
		return orderItemService;
	}
	
	public void setOrderService(OrderService orderService){
		this.orderService = orderService;
	}
	
	public OrderService getOrderService() {
		return orderService;
	}
	
	public void setBookService(BookService bookService){
		this.bookService = bookService;
	}
	
	public BookService getBookService(){
		return bookService;
	}
	
	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getStart() {
		return start;
	}

	public void setStart(Date start) {
		this.start = start;
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) {
		this.end = end;
	}

	public String getBook() {
		return book;
	}

	public void setBook(String book) {
		this.book = book;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String list() throws Exception {
		List<Order> orders = orderService.getAllOrders();
		Map<String,Integer> dailyStat = new HashMap<String,Integer>();
		for(Order order:orders){
			Date date = order.getDate();
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			String dateStr = sdf.format(date); 
			Integer money = dailyStat.get(dateStr);
			if(money==null){
				money = 0;
			}
			money += order.getTotalPrice();
			dailyStat.put(dateStr, money);
		}
		JSONObject jsonObject = JSONObject.fromObject(dailyStat);
		result = jsonObject.toString();
		
		return SUCCESS;
	}
	
	public String criteria() throws UnsupportedEncodingException{
		if(book!=null){
			book = URLDecoder.decode(book,"UTF-8");
			System.out.println("book:"+book);
		}
		if(category!=null){
			category = URLDecoder.decode(category,"UTF-8");
		}
		List<Order> orders = orderService.criteria(id,start,end,book,category);
		Map<String,Integer> dailyStat = new HashMap<String,Integer>();
		for(Order order:orders){
			Date date = order.getDate();
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			String dateStr = sdf.format(date); 
			Integer money = dailyStat.get(dateStr);
			if(money==null){
				money = 0;
			}
			money += order.getTotalPrice();
			dailyStat.put(dateStr, money);
		}
		JSONObject jsonObject = JSONObject.fromObject(dailyStat);
		result = jsonObject.toString();
		
		return SUCCESS;
	}
	
}
