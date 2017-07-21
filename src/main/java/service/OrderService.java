package service;

import java.util.Date;
import java.util.List;

import model.Order;

public interface OrderService {
	
	public Integer addOrder(Order order);

	public void deleteOrder(Order order);

	public void updateOrder(Order order);

	public Order getOrderById(int id);
	
	public List<Order> getOrdersByUser(int id);
	
	public List<Order> getAllOrders();
	
	public List<Order> criteria(int id,Date start,Date end,String book,String category);
}
