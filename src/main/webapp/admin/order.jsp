<%@ page import="java.util.ArrayList"%>
<%@ page import="model.Order"%>
<%@ page import="model.User"%>
<%@ page import="model.Book" %>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%
	String path = request.getContextPath();
%>
    <title>Order Management</title>

    <!-- Bootstrap CSS File  -->
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css"/>
    
	<link href="<%=path%>/css/flat-ui.css" rel="stylesheet">
	
	<!-- Jquery JS file -->
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.3.min.js"></script>

	<!-- Bootstrap JS file -->
	<script type="text/javascript" src="<%=path%>/js/bootstrap.min.js"></script>

	<!-- Custom JS file -->
	<script type="text/javascript" src="<%=path%>/js/OrderManage.js"></script>

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
		
		ArrayList<User> receiverList = new ArrayList<User>();
		if (request.getAttribute("users") != null) {
			receiverList = (ArrayList<User>) request.getAttribute("users");
		}
		int rsize = receiverList.size();
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
						<li class="active"><a href="order!list">Order</a></li>
						<li><a href="/bookstore/admin/sale.jsp">Sale</a></li>
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
            			<th>ID</th>
            			<th>User ID</th>
            			<th>Receiver</th>
            			<th>Address</th>
            			<th>Phone</th>
            			<th>Total Price</th>
            			<th>Date</th>
            			<th>Items</th>
            			<th>Update</th>
            			<th>Delete</th>
            		</tr></thead>
            		<tbody>
            			<%
							for (int i = 0; i < osize; i++) {
								Order order = orderList.get(i);
						%>
						<tr>
            				<td><%=order.getId()%></td>
            				<td><%=order.getUserId()%></td>
            				<td><%=order.getReceiver() %></td>
            				<td><%=order.getAddress() %></td>
            				<td><%=order.getPhone() %></td>
            				<td><%=order.getRealPrice()%></td>
            				<td><%=order.getDateStr()%></td>
            				<td>
            					<button onclick='ShowItems(<%=order.getId()%>)' class='btn btn-primary'>Show</button>
            				</td>
            				<td>
								<button class="btn btn-warning edit" type="button" 
								data-id="<%=order.getId()%>"
								data-user="<%=order.getUserId() %>"
								data-receiver="<%=order.getReceiver() %>"
								data-address="<%=order.getAddress() %>"
								data-phone="<%=order.getPhone() %>"
								data-price="<%=order.getRealPrice() %>"
								data-date="<%=order.getDateStr() %>">Update</button>
							</td>
							<td>
								<button onclick='DeleteOrder(<%=order.getId()%>)' class='btn btn-danger'>Delete</button>
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
<!-- Modal - Add New Record/Order -->
<div class="modal fade" id="add_new_record_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Add New Record</h4>
            </div>
            <div class="modal-body">

                <div class="form-group">
                    <label for="userId">User Id</label>
                    <select class="form-control" id="userId">
						<%
							for (int i = 0; i < rsize; i++) {
								User user = receiverList.get(i);
						%>
						<option value="<%=user.getId()%>"><%=user.getId()%></option>
						<%
							}
						%>
					</select>
                </div>
                
                <div class="form-group">
                    <label for="receiver">Receiver Name</label>
                    <input type="text" id="receiver" placeholder="Receiver Name" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" id="address" placeholder="Address" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="phone">Phone</label>
                    <input type="text" id="phone" placeholder="Phone" class="form-control"/>
                </div>

                <div class="form-group">
                    <label for="totalPrice">Total Price</label>
                    <input type="text" id="totalPrice" placeholder="Total Price" class="form-control" disabled/>
                </div>
                
                <div class="form-group">
                    <label for="date">Date</label>
                    <input type="date" id="date" placeholder="Date" class="form-control"/>
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

<!-- Modal - Update User details -->
<div class="modal fade" id="update_order_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Update</h4>
            </div>
            <div class="modal-body">

                <div class="form-group">
                    <label for="userId">User Id</label>
                    <select class="form-control" id="update_userId">
						<%
							for (int i = 0; i < rsize; i++) {
								User user = receiverList.get(i);
						%>
						<option value="<%=user.getId()%>"><%=user.getId()%></option>
						<%
							}
						%>
					</select>
                </div>
                
                <div class="form-group">
                    <label for="receiver">Receiver Name</label>
                    <input type="text" id="update_receiver" placeholder="Receiver Name" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="address">Address</label>
                    <input type="text" id="update_address" placeholder="Address" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="phone">Phone</label>
                    <input type="text" id="update_phone" placeholder="Phone" class="form-control"/>
                </div>

                <div class="form-group">
                    <label for="totalPrice">Total Price</label>
                    <input type="text" id="update_totalPrice" placeholder="Total Price" class="form-control" disabled/>
                </div>
                
                <div class="form-group">
                    <label for="date">Date</label>
                    <input type="date" id="update_date" placeholder="Date" class="form-control"/>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="UpdateOrderDetails()" >Save Changes</button>
                <input type="hidden" id="hidden_order_id">
            </div>
        </div>
    </div>
</div>
<!-- // Modal -->

<div class="modal text-center" id="order_item_modal" tabindex="-1" role="dialog">
	<div class="modal-dialog" style="display:inline-block;width:auto;">
		<div class="modal-content">
			<div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Order Item</h4>
            </div>
            <div class="modal-body">
    			<div class="row">
        			<div class="col-md-12">
            			<div>
            				<table class='table table-bordered table-striped table-hover' id="order_item_table">
            					<thead><tr>
            						<th>Book Id</th>
            						<th>Book Name</th>
            						<th>Number</th>
            						<th>Price</th>
            						<th>Update</th>
            						<th>Delete</th>
            					</tr></thead>
            					<tbody id="order_item_body">
            					</tbody>
            				</table>
            			</div>
            		</div>
            	</div>
        	</div>
        	<div class="modal-footer">
        		<button class="btn btn-success" id="add_item">Add</button>
        		<input type="hidden" id="hidden_order_id">
        	</div>
        </div>
	</div>
</div>

<!-- Bootstrap Modals -->
<!-- Modal - Add New Record/Order Item -->
<div class="modal fade" id="add_new_item_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Add New Item</h4>
            </div>
            <div class="modal-body">
            
            	<div class="form-group">
                    <label for="order_id">Order Id</label>
                    <input type="text" id="order_id" disabled="disabled" class="form-control"/>
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
                <button type="button" class="btn btn-primary" onclick="addItem()">Add Item</button>
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
