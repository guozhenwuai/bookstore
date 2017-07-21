<%@ page import="java.util.ArrayList"%>
<%@ page import="model.Order"%>
<%@ page import="model.User"%>
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
						<li><a href="orderItem!list">Order Item</a></li>
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
            			<th>Receiver ID</th>
            			<th>Total Price</th>
            			<th>Date</th>
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
            				<td><%=order.getRealPrice()%></td>
            				<td><%=order.getDateStr()%></td>
            				<td>
								<button class="btn btn-warning edit" type="button" 
								data-id="<%=order.getId()%>"
								data-receiver="<%=order.getUserId() %>"
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
                    <label for="receiverId">Receiver Id</label>
                    <select class="form-control" id="receiverId">
						<%
							for (int i = 0; i < rsize; i++) {
								User receiver = receiverList.get(i);
						%>
						<option value="<%=receiver.getId()%>"><%=receiver.getId()%></option>
						<%
							}
						%>
					</select>
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
                    <label for="receiverId">Receiver Id</label>
                    <select class="form-control" id="update_receiverId">
						<%
							for (int i = 0; i < rsize; i++) {
								User receiver = receiverList.get(i);
						%>
						<option value="<%=receiver.getId()%>"><%=receiver.getId()%></option>
						<%
							}
						%>
					</select>
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


</body>
</html>
