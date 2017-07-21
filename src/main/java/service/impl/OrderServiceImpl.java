package service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import dao.OrderDao;
import dao.BookDao;
import model.Book;
import model.Order;
import model.OrderItem;
import service.OrderService;

public class OrderServiceImpl implements OrderService{
	private OrderDao orderDao;
	private BookDao bookDao;
	
	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}
	
	public void setBookDao(BookDao bookDao){
		this.bookDao = bookDao;
	}
	
	public Integer addOrder(Order order) {
		if(order.getDate()==null){
			order.setDate(new Date());
		}
		return orderDao.save(order);
	}

	public void deleteOrder(Order order) {
		orderDao.delete(order);
	}

	public void updateOrder(Order order) {
		if(order.getDate()==null){
			order.setDate(new Date());
		}
		orderDao.update(order);
	}

	public Order getOrderById(int id) {
		return orderDao.getOrderById(id);
	}
	
	public List<Order> getOrdersByUser(int id){
		return orderDao.getOrdersByUser(id);
	}

	public List<Order> getAllOrders() {
		return orderDao.getAllOrders();
	}
	
	public List<Order> criteria(int id,Date start,Date end,String book,String category){
		List<Order> orders = new ArrayList<Order>();
		if(id!=0){
			orders = orderDao.getOrdersByUser(id);
		}
		else{
			orders = orderDao.getAllOrders();
		}
		if(start!=null&&end!=null){
			System.out.println("start:"+start+" end:"+end);
			orders = getProperTimeOrder(orders,start,end);
		}
		if(book!=null){
			orders = getBookOrder(orders,book);
		}
		else if(category!=null){
			orders = getCategoryOrder(orders,category);
		}
		
		return orders;
	}
	
	private List<Order> getCategoryOrder(List<Order> orders,String category){
		List<Order> newOrders = new ArrayList<Order>();
		for(Order order:orders){
			Set<OrderItem> orderItems = order.getOrderItems();
			int totalPrice = 0;
			for(OrderItem oi:orderItems){
				int id = oi.getBookId();
				Book bk = bookDao.getBookById(id);
				if(bk.getCategory().equals(category)){
					totalPrice+=oi.getPrice();
				}
			}
			Order o = new Order();
			o.setDate(order.getDate());
			o.setTotalPrice(totalPrice);
			newOrders.add(o);
		}
		return newOrders;
	}
	
	private List<Order> getBookOrder(List<Order> orders,String book){
		List<Order> newOrders = new ArrayList<Order>();
		for(Order order:orders){
			Set<OrderItem> orderItems = order.getOrderItems();
			for(OrderItem oi:orderItems){
				int id = oi.getBookId();
				Book bk = bookDao.getBookById(id);
				if(bk.getName().equals(book)){
					Order o = new Order();
					o.setDate(order.getDate());
					o.setTotalPrice(oi.getPrice());
					newOrders.add(o);
					break;
				}
			}
		}
		return newOrders;
	}
	
	private List<Order> getProperTimeOrder(List<Order> orders,Date start,Date end){
		List<Order> newOrders = new ArrayList<Order>();
		for(Order order:orders){
			Date date = order.getDate();
			if(date.after(start)&&!date.after(end)){
				newOrders.add(order);
			}
		}
		return newOrders;
	}
}
