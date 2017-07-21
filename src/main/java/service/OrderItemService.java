package service;

import java.util.List;

import model.OrderItem;

public interface OrderItemService {
	public void addOrderItem(OrderItem orderItem);

	public void deleteOrderItem(OrderItem orderItem);

	public void updateOrderItem(OrderItem orderItem);

	public OrderItem getOrderItemById(int orderId,int bookId);

	public List<OrderItem> getAllOrderItems();
}
