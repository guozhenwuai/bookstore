<%@ page import="java.util.ArrayList"%>
<%@ page import="model.Receiver"%>
<%@ page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%
	String path = request.getContextPath();
%>
    <title>Receiver Management</title>

    <!-- Bootstrap CSS File  -->
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css"/>
    
	<link href="<%=path%>/css/flat-ui.css" rel="stylesheet">
	
	<!-- Jquery JS file -->
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.3.min.js"></script>

	<!-- Bootstrap JS file -->
	<script type="text/javascript" src="<%=path%>/js/bootstrap.min.js"></script>

	<!-- Custom JS file -->
	<script type="text/javascript" src="<%=path%>/js/ReceiverManage.js"></script>

	<script src="<%=path%>/js/flat-ui.min.js"></script>

</head>
<body>
	<%
		ArrayList<Receiver> receiverList = new ArrayList<Receiver>();
		if (request.getAttribute("receivers") != null) {
			receiverList = (ArrayList<Receiver>) request.getAttribute("receivers");
		}
		int rsize = receiverList.size();
		ArrayList<User> userList = new ArrayList<User>();
		if (request.getAttribute("users") != null) {
			userList = (ArrayList<User>) request.getAttribute("users");
		}
		int usize = userList.size();
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
						<li class="active"><a href="receiver!list">Receiver</a></li>
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
            			<th>Name</th>
            			<th>Address</th>
            			<th>Phone</th>
            			<th>Update</th>
            			<th>Delete</th>
            		</tr></thead>
            		<tbody>
            			<%
							for (int i = 0; i < rsize; i++) {
								Receiver receiver = receiverList.get(i);
						%>
						<tr>
            				<td><%=receiver.getId()%></td>
            				<td><%=receiver.getName()%></td>
            				<td><%=receiver.getAddress()%></td>
            				<td><%=receiver.getPhoneNum()%></td>
            				<td>
								<button class="btn btn-warning edit" type="button" 
								data-id="<%=receiver.getId()%>"
								data-user="<%=receiver.getUserId() %>"
								data-name="<%=receiver.getName() %>"
								data-province="<%=receiver.getProvince() %>"
								data-city="<%=receiver.getCity() %>"
								data-street="<%=receiver.getStreet() %>"
								data-building="<%=receiver.getDefinitAddr() %>"
								data-phone="<%=receiver.getPhoneNum() %>"
								data-is-default="<%=receiver.getIsDefault()%>">Update</button>
							</td>
							<td>
								<button onclick='DeleteReceiver(<%=receiver.getId()%>)' class='btn btn-danger'>Delete</button>
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
<!-- Modal - Add New Record/Receiver -->
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
                    <label for="name">Receiver Name</label>
                    <input type="text" id="name" placeholder="Receiver Name" class="form-control"/>
                </div>

                <div class="form-group">
                    <label for="province">Province</label>
                    <input type="text" id="province" placeholder="Province" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="city">City</label>
                    <input type="text" id="city" placeholder="City" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="street">Street</label>
                    <input type="text" id="street" placeholder="Street" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="building">Definite Address</label>
                    <input type="text" id="building" placeholder="Definite Address" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="phone_num">Phone Number</label>
                    <input type="text" id="phone_num" placeholder="Phone Number" class="form-control"/>
                </div>

                <div class="form-group">
                    <label for="is_default">Is Default Address?</label>
                    <div>
                    	<label class="checkbox-inline">
                    		<input type="radio" name="is_default" value="1"/>Yes
                    	</label>
                    	<label class="checkbox-inline">
                    		<input type="radio" name="is_default" value="0" checked/>No
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

<!-- Modal - Update Receiver details -->
<div class="modal fade" id="update_receiver_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Update</h4>
            </div>
            <div class="modal-body">

                <div class="form-group">
                    <label for="user_id">User Id</label>
                    <select class="form-control" id="update_user_id">
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
                    <label for="name">Receiver Name</label>
                    <input type="text" id="update_name" placeholder="Receiver Name" class="form-control"/>
                </div>

                <div class="form-group">
                    <label for="province">Province</label>
                    <input type="text" id="update_province" placeholder="Province" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="city">City</label>
                    <input type="text" id="update_city" placeholder="City" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="street">Street</label>
                    <input type="text" id="update_street" placeholder="Street" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="building">Definite Address</label>
                    <input type="text" id="update_building" placeholder="Definite Address" class="form-control"/>
                </div>
                
                <div class="form-group">
                    <label for="phone_num">Phone Number</label>
                    <input type="text" id="update_phone_num" placeholder="Phone Number" class="form-control"/>
                </div>

                <div class="form-group">
                    <label for="is_default">Is Default Address?</label>
                    <div>
                    	<label class="checkbox-inline">
                    		<input type="radio" name="update_is_default" value="1"/>Yes
                    	</label>
                    	<label class="checkbox-inline">
                    		<input type="radio" name="update_is_default" value="0" checked/>No
                    	</label>
                    </div>
                </div>
                

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="UpdateReceiverDetails()" >Save Changes</button>
                <input type="hidden" id="hidden_receiver_id">
            </div>
        </div>
    </div>
</div>
<!-- // Modal -->

</body>
</html>
