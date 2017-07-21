package action;

import java.util.ArrayList;
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


public class OrderItemActions extends BaseAction implements ModelDriven<OrderItem> {
	private static final long serialVersionUID = 1L;
	
	private String map;

	private OrderItemService orderItemService;
	private OrderService orderService;
	private BookService bookService;
	
	private String result;
	
	private int id;
	
	private OrderItem orderItemBean = new OrderItem();
	
	public OrderItem getModel(){
		return orderItemBean;
	}
	
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

	public String getMap() {
		return map;
	}
	public void setMap(String map) {
		this.map = map;
	}
	
	public String list() throws Exception {
		List<OrderItem> orderItems = orderItemService.getAllOrderItems();
		request().setAttribute("orderItems", orderItems);
		List<Order> orders = orderService.getAllOrders();
		request().setAttribute("orders", orders);
		List<Book> books = bookService.getAllBooks();
		request().setAttribute("books", books);

		return "list";
	}
	
	public String add() throws Exception {
		orderItemService.addOrderItem(orderItemBean);
		
		return SUCCESS;
	}
	
	public String update() throws Exception {
		orderItemService.updateOrderItem(orderItemBean);
		
		return SUCCESS;
	}
	
	public String delete() throws Exception {
		orderItemService.deleteOrderItem(orderItemBean);
		
		return SUCCESS;
	}
	
	public String showItems(){
		Order orderBean = orderService.getOrderById(id);
		Set<OrderItem> orderItems = orderBean.getOrderItems();
		JSONArray jsonArray = new JSONArray();
		JsonConfig config = new JsonConfig();
		config.setExcludes(new String[] { "book" });
		for(OrderItem o:orderItems){
			JSONObject jsonObject = JSONObject.fromObject(o, config);
			System.out.println(jsonObject.toString());
			Book book = bookService.getBookById(o.getBookId());
			jsonObject.put("book",JSONObject.fromObject(book));
			jsonArray.add(jsonObject);
		}
		result = jsonArray.toString();
		System.out.println(result);
		
		return "items";
	}
	
	public String details(){
		orderItemBean = orderItemService.getOrderItemById(orderItemBean.getOrderId(), orderItemBean.getBookId());
		JsonConfig config = new JsonConfig();
		config.setExcludes(new String[] { "book" });
		JSONObject jsonObject = JSONObject.fromObject(orderItemBean, config);
		result = jsonObject.toString();
		
		return "details";
	}
	
}
