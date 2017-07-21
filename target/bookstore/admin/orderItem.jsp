<%@ page import="java.util.ArrayList"%>
<%@ page import="model.Book"%>
<%@ page import="model.Order"%>
<%@ page import="model.OrderItem"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%
	String path = request.getContextPath();
%>
    <title>Book Management</title>

    <!-- Bootstrap CSS File  -->
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css"/>
    
	<link href="<%=path%>/css/flat-ui.css" rel="stylesheet">
	
	<!-- Jquery JS file -->
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.3.min.js"></script>

	<!-- Bootstrap JS file -->
	<script type="text/javascript" src="<%=path%>/js/bootstrap.min.js"></script>

	<!-- Custom JS file -->
	<script type="text/javascript" src="<%=path%>/js/OrderItemManage.js"></script>

	<script src="<%=path%>/js/flat-ui.min.js"></script>
	
</head>
<body>
	<%
		ArrayList<Book> bookList = new ArrayList<Book>();
		if (request.getAttribute("books") != null) {
			bookList = (ArrayList<Book>) request.getAttribute("books");
		}
		int bsize = bookList.size();
		ArrayList<Order> orderList = new ArrayList<Order>();
		if (request.getAttribute("orders") != null) {
			orderList = (ArrayList<Order>) request.getAttribute("orders");
		}
		int osize = orderList.size();
		ArrayList<OrderItem> orderItemList = new ArrayList<OrderItem>();
		if (request.getAttribute("orderItems") != null) {
			orderItemList = (ArrayList<OrderItem>) request.getAttribute("orderItems");
		}
		int oisize = orderItemList.size();
	%>

<!-- Content Section -->
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h2>Bookstore Management System</h2>
        </div>
    </div>
    <div class="row">
    	<nav class="navbar navbar-default" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" href="homepage">My Bookstore</a>
				</div>
				<div>
					<ul class="nav navbar-nav">
						<li><a href="book!list">Book</a></li>
						<li><a href="user!list">User</a></li>
						<li><a href="order!list">Order</a></li>
						<li class="active"><a href="orderItem!list">Order Item</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</div>
    
    <div class="row">
        <div class="col-md-12">
            <div class="pull-right">
                <button class="btn btn-success" id="add_new_record">Add New Record</button>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <h5><b>Records:</b></h5>
			
            <div>
            	<table class='table table-bordered table-striped table-hover' id="dataTables">
            		<thead><tr>
            			<th>Order Id</th>
            			<th>Book Id</th>
            			<th>Number</th>
            			<th>Price</th>
            			<th>Update</th>
            			<th>Delete</th>
            		</tr></thead>
            		<tbody>
            			<%
							for (int i = 0; i < oisize; i++) {
								OrderItem orderItem = orderItemList.get(i);
						%>
						<tr>
            				<td><%=orderItem.getOrderId()%></td>
            				<td><%=orderItem.getBookId()%></td>
            				<td><%=orderItem.getNum()%></td>
            				<td><%=orderItem.getRealPrice()%></td>
            				<td>
								<button class="btn btn-warning edit" type="button" 
								data-oid="<%=orderItem.getOrderId()%>"
								data-bid="<%=orderItem.getBookId() %>"
								data-num="<%=orderItem.getNum() %>"
								data-price="<%=orderItem.getRealPrice()%>">Update</button>
							</td>
							<td>
								<button onclick='DeleteOrderItem(<%=orderItem.getOrderId()%>,<%=orderItem.getBookId() %>)' 
								class='btn btn-danger'>Delete</button>
							</td>
            			</tr>            		
            		<%
						}
					%>
					</tbody>
            	</table>
            </div>
        </div>
    </div>
</div>
<!-- /Content Section -->


<!-- Bootstrap Modals -->
<!-- Modal - Add New Record/Order Item -->
<div class="modal fade" id="add_new_record_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Add New Record</h4>
            </div>
            <div class="modal-body">
            
            	<div class="form-group">
                    <label for="order_id">Order Id</label>
                    <select class="form-control" id="order_id">
						<%
							for (int i = 0; i < osize; i++) {
								Order order = orderList.get(i);
						%>
						<option value="<%=order.getId()%>"><%=order.getId()%></option>
						<%
							}
						%>
					</select>
                </div>
                
                <div class="form-group">
                    <label for="book_id">Book Id</label>
                    <select class="form-control" id="book_id">
						<%
							for (int i = 0; i < bsize; i++) {
								Book book = bookList.get(i);
						%>
						<option value="<%=book.getId()%>"><%=book.getId()%></option>
						<%
							}
						%>
					</select>
                </div>
                
                <div class="form-group">
                    <label for="number">Book Number</label>
                    <input type="text" id="number" placeholder="Book Number" class="form-control"/>
                </div>

                <div class="form-group">
                    <label for="price">Price</label>
                    <input type="text" id="price" placeholder="Price" class="form-control"/>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="addRecord()">Add Record</button>
            </div>
        </div>
    </div>
</div>
<!-- // Modal -->

<!-- Modal - Update OrderItem details -->
<div class="modal fade" id="update_order_item_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Update</h4>
            </div>
            <div class="modal-body">

                <div class="form-group">
                    <label for="order_id">Order Id</label>
                    <input type="text" id="update_order_id" disabled="disabled" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="book_id">Book Id</label>
                    <input type="text" id="update_book_id" disabled="disabled" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="number">Book Number</label>
                    <input type="text" id="update_number" placeholder="Book Number" class="form-control"/>
                </div>

                <div class="form-group">
                    <label for="price">Price</label>
                    <input type="text" id="update_price" placeholder="Price" class="form-control"/>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="UpdateOrderItemDetails()" >Save Changes</button>
            </div>
        </div>
    </div>
</div>
<!-- // Modal -->

</body>
</html>
