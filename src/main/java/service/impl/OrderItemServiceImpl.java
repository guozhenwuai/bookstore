package service.impl;

import java.util.List;

import dao.OrderItemDao;
import model.OrderItem;
import service.OrderItemService;

public class OrderItemServiceImpl implements OrderItemService{

	private OrderItemDao orderItemDao;
	
	public void setOrderItemDao(OrderItemDao orderItemDao) {
		this.orderItemDao = orderItemDao;
	}
	
	public void addOrderItem(OrderItem orderItem) {
		orderItemDao.save(orderItem);
	}

	public void deleteOrderItem(OrderItem orderItem) {
		orderItemDao.delete(orderItem);
	}

	public void updateOrderItem(OrderItem orderItem) {
		orderItemDao.update(orderItem);
	}

	public OrderItem getOrderItemById(int orderId,int bookId) {
		return orderItemDao.getOrderItemById(orderId,bookId);
	}

	public List<OrderItem> getAllOrderItems() {
		return orderItemDao.getAllOrderItems();
	}
}
