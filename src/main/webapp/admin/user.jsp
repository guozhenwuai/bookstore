<%@ page import="java.util.ArrayList"%>
<%@ page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%
	String path = request.getContextPath();
%>
    <title>User Management</title>

    <!-- Bootstrap CSS File  -->
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css"/>
    
	<link href="<%=path%>/css/flat-ui.css" rel="stylesheet">
	
	<!-- Jquery JS file -->
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.3.min.js"></script>

	<!-- Bootstrap JS file -->
	<script type="text/javascript" src="<%=path%>/js/bootstrap.min.js"></script>

	<!-- Custom JS file -->
	<script type="text/javascript" src="<%=path%>/js/UserManage.js"></script>

	<script src="<%=path%>/js/flat-ui.min.js"></script>

</head>
<body>
	<%
		ArrayList<User> userList = new ArrayList<User>();
		if (request.getAttribute("users") != null) {
			userList = (ArrayList<User>) request.getAttribute("users");
		}
		int size = userList.size();
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
						<li class="active"><a href="user!list">User</a></li>
						<li><a href="order!list">Order</a></li>
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
            			<th>Username</th>
            			<th>Password</th>
            			<th>Email</th>
            			<th>Receiver</th>
            			<th>Address</th>
            			<th>Phone</th>
            			<th>isAdmin</th>
            			<th>Update</th>
            			<th>Delete</th>
            		</tr></thead>
            		<tbody>
            			<%
							for (int i = 0; i < size; i++) {
								User user = userList.get(i);
						%>
						<tr>
            				<td><%=user.getId()%></td>
            				<td><%=user.getUsername()%></td>
            				<td><%=user.getPassword()%></td>
            				<td><%=user.getEmail()%></td>
            				<td><%=user.getReceiver() %></td>
            				<td><%=user.getAddress() %></td>
            				<td><%=user.getPhone() %></td>
            				<td><%=user.isAdminStr()%></td>
            				<td>
								<button class="btn btn-warning edit" type="button" 
								data-id="<%=user.getId()%>"
								data-username="<%=user.getUsername() %>"
								data-password="<%=user.getPassword() %>"
								data-email="<%=user.getEmail() %>"
								data-receiver="<%=user.getReceiver() %>"
								data-address="<%=user.getAddress() %>"
								data-phone="<%=user.getPhone() %>"
								data-is-admin="<%=user.getIsAdmin()%>">Update</button>
							</td>
							<td>
								<button onclick='DeleteUser(<%=user.getId()%>)' class='btn btn-danger'>Delete</button>
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
<!-- Modal - Add New Record/User -->
<div class="modal fade" id="add_new_record_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Add New Record</h4>
            </div>
            <div class="modal-body">

                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" placeholder="Username" class="form-control"/>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="text" id="password" placeholder="Password" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" placeholder="Email" class="form-control"/>
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
                    <label for="isAdmin">Is Admin?</label>
                    <div>
                    	<label class="checkbox-inline">
                    		<span class="icon"></span>
                    		<input type="radio" name="isAdmin" value="1"/>Yes
                    	</label>
                    	<label class="checkbox-inline">
                    		<input type="radio" name="isAdmin" value="0" checked/>No
                    	</label>
                    </div>
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
<div class="modal fade" id="update_user_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Update</h4>
            </div>
            <div class="modal-body">

                <div class="form-group">
                    <label for="username">Username</label>
                    <input type="text" id="update_username" placeholder="Username" class="form-control"/>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="text" id="update_password" placeholder="Password" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="update_email" placeholder="Email" class="form-control"/>
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
                    <label for="isAdmin">Is Admin?</label>
                    <div>
                    	<label class="checkbox-inline">
                    		<input type="radio" name="update_isAdmin" value="1"/>Yes
                    	</label>
                    	<label class="checkbox-inline">
                    		<input type="radio" name="update_isAdmin" value="0" checked/>No
                    	</label>
                    </div>
                </div>
                

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="UpdateUserDetails()" >Save Changes</button>
                <input type="hidden" id="hidden_user_id">
            </div>
        </div>
    </div>
</div>
<!-- // Modal -->

</body>
</html>
