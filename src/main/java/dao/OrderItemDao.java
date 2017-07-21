package dao;

import java.util.List;

import model.OrderItem;

public interface OrderItemDao {

	public void save(OrderItem orderItem);

	public void delete(OrderItem orderItem);

	public void update(OrderItem orderItem);

	public OrderItem getOrderItemById(int orderId,int bookId);

	public List<OrderItem> getAllOrderItems();

}