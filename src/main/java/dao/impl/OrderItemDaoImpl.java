package dao.impl;

import java.util.List;

import model.OrderItem;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import dao.OrderItemDao;

public class OrderItemDaoImpl extends HibernateDaoSupport implements
		OrderItemDao {

	public void save(OrderItem orderItem) {
		getHibernateTemplate().save(orderItem);
	}

	public void delete(OrderItem orderItem) {
		getHibernateTemplate().delete(orderItem);
	}

	public void update(OrderItem orderItem) {
		getHibernateTemplate().merge(orderItem);
	}

	public OrderItem getOrderItemById(int orderId,int bookId) {
		@SuppressWarnings("unchecked")
		List<OrderItem> orderItems = (List<OrderItem>) getHibernateTemplate()
				.find("from OrderItem as oi where oi.orderId=? and oi.bookId=?",orderId,bookId);
		OrderItem orderItem = orderItems.size() > 0 ? orderItems.get(0) : null;
		return orderItem;
	}

	public List<OrderItem> getAllOrderItems() {
		@SuppressWarnings("unchecked")
		List<OrderItem> orderItems = (List<OrderItem>) getHibernateTemplate()
				.find("from OrderItem");
		return orderItems;
	}

}
