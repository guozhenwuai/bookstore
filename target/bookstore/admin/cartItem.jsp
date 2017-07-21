<%@ page import="java.util.ArrayList"%>
<%@ page import="model.Book"%>
<%@ page import="model.User"%>
<%@ page import="model.CartItem"%>
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
	<script type="text/javascript" src="<%=path%>/js/CartItemManage.js"></script>

	<script src="<%=path%>/js/flat-ui.min.js"></script>

</head>
<body>
	<%
		ArrayList<Book> bookList = new ArrayList<Book>();
		if (request.getAttribute("books") != null) {
			bookList = (ArrayList<Book>) request.getAttribute("books");
		}
		int bsize = bookList.size();
		ArrayList<User> userList = new ArrayList<User>();
		if (request.getAttribute("users") != null) {
			userList = (ArrayList<User>) request.getAttribute("users");
		}
		int usize = userList.size();
		ArrayList<CartItem> cartItemList = new ArrayList<CartItem>();
		if (request.getAttribute("cartItems") != null) {
			cartItemList = (ArrayList<CartItem>) request.getAttribute("cartItems");
		}
		int cisize = cartItemList.size();
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
						<li><a href="orderItem!list">Order Item</a></li>
						<li class="active"><a href="cartItem!list">Cart Item</a></li>
						<li><a href="receiver!list">Receiver</a></li>
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
            			<th>User Id</th>
            			<th>Book Id</th>
            			<th>Number</th>
            			<th>Update</th>
            			<th>Delete</th>
            		</tr></thead>
            		<tbody>
            			<%
							for (int i = 0; i < cisize; i++) {
								CartItem cartItem = cartItemList.get(i);
						%>
						<tr>
            				<td><%=cartItem.getUserId()%></td>
            				<td><%=cartItem.getBookId()%></td>
            				<td><%=cartItem.getNum()%></td>
            				<td>
								<button class="btn btn-warning edit" type="button" 
								data-uid="<%=cartItem.getUserId()%>"
								data-bid="<%=cartItem.getBookId() %>"
								data-num="<%=cartItem.getNum() %>">Update</button>
							</td>
							<td>
								<button onclick='DeleteCartItem(<%=cartItem.getUserId()%>,<%=cartItem.getBookId() %>)' 
								class='btn btn-danger'>Delete</button>
							</td>
            			</tr>
            		</tbody>
            		<%
						}
					%>
            	</table>
            </div>
        </div>
    </div>
</div>
<!-- /Content Section -->


<!-- Bootstrap Modals -->
<!-- Modal - Add New Record/Cart Item -->
<div class="modal fade" id="add_new_record_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Add New Record</h4>
            </div>
            <div class="modal-body">
            
            	<div class="form-group">
                    <label for="user_id">User Id</label>
                    <select class="form-control" id="user_id">
						<%
							for (int i = 0; i < usize; i++) {
								User user = userList.get(i);
						%>
						<option value="<%=user.getId()%>"><%=user.getId()%></option>
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

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="addRecord()">Add Record</button>
            </div>
        </div>
    </div>
</div>
<!-- // Modal -->

<!-- Modal - Update CartItem details -->
<div class="modal fade" id="update_cart_item_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Update</h4>
            </div>
            <div class="modal-body">

                <div class="form-group">
                    <label for="user_id">User Id</label>
                    <input type="text" id="update_user_id" disabled="disabled" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="book_id">Book Id</label>
                    <input type="text" id="update_book_id" disabled="disabled" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="number">Book Number</label>
                    <input type="text" id="update_number" placeholder="Book Number" class="form-control"/>
                </div>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="UpdateCartItemDetails()" >Save Changes</button>
            </div>
        </div>
    </div>
</div>
<!-- // Modal -->


</body>
</html>
