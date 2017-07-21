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
import net.sf.json.JSONObject;
import service.BookService;
import service.OrderItemService;
import service.OrderService;
import service.UserService;


public class CheckOrderAction extends BaseAction implements ModelDriven<Order> {
	private static final long serialVersionUID = 1L;
	
	private String map;

	private OrderService orderService;
	private BookService bookService;
	private UserService userService;
	private OrderItemService orderItemService;
	
	private Order orderBean = new Order();
	
	public Order getModel(){
		return orderBean;
	}
	
	public void setOrderService(OrderService orderService){
		this.orderService = orderService;
	}
	
	public OrderService getOrderService() {
		return orderService;
	}
	
	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	public void setBookService(BookService bookService){
		this.bookService = bookService;
	}
	
	public BookService getBookService(){
		return bookService;
	}

	public OrderItemService getOrderItemService() {
		return orderItemService;
	}

	public void setOrderItemService(OrderItemService orderItemService) {
		this.orderItemService = orderItemService;
	}

	public String getMap() {
		return map;
	}
	public void setMap(String map) {
		this.map = map;
	}
	
	public String checkOrder(){
		request().setAttribute("map", map);
		List<OrderItem> cartItem = new ArrayList<OrderItem>();
		JSONObject  jsonObject = JSONObject.fromObject(map);
		Iterator iter = jsonObject.keys();
		while(iter.hasNext()){
			String key = (String) iter.next();
			String value = jsonObject.getString(key);
			OrderItem item = new OrderItem();
			int id = Integer.parseInt(key);
			item.setBookId(id);
			item.setNum(Integer.parseInt(value));
			item.setBook(bookService.getBookById(id));
			cartItem.add(item);
		}
		request().setAttribute("cartItems", cartItem);
		int id = (Integer)session().getAttribute("id");
		User user = userService.getUserById(id);
		request().setAttribute("user", user);
		
		return SUCCESS;
	}
	
	public String placeOrder(){
		int orderId = orderService.addOrder(orderBean);
		Map<Integer,Integer> cart = (HashMap<Integer,Integer>) session().getAttribute("cart");
		JSONObject  jsonObject = JSONObject.fromObject(map);
		Iterator iter = jsonObject.keys();
		while(iter.hasNext()){
			String key = (String) iter.next();
			String value = jsonObject.getString(key);
			OrderItem item = new OrderItem();
			int id = Integer.parseInt(key);
			Book book = bookService.getBookById(id);
			item.setOrderId(orderId);
			item.setBookId(id);
			item.setNum(Integer.parseInt(value));
			item.setPrice(book.getPrice());
			orderItemService.addOrderItem(item);
			cart.remove(id);
		}
		session().setAttribute("cart", cart);
		
		return SUCCESS;
	}
	
}
