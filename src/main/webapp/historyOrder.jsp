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
    <title>History Order</title>

    <!-- Bootstrap CSS File  -->
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css"/>
    
	<link href="<%=path%>/css/flat-ui.css" rel="stylesheet">
	
	<!-- Jquery JS file -->
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.3.min.js"></script>

	<!-- Bootstrap JS file -->
	<script type="text/javascript" src="<%=path%>/js/bootstrap.min.js"></script>

	<!-- Custom JS file -->
	<script type="text/javascript" src="<%=path%>/js/historyOrder.js"></script>

	<script src="<%=path%>/js/flat-ui.min.js"></script>

</head>
<body>
	<%
		ArrayList<Order> orderList = new ArrayList<Order>();
		if (request.getAttribute("orders") != null) {
			orderList = (ArrayList<Order>) request.getAttribute("orders");
		}
		int osize = orderList.size();
	%>

<!-- Content Section -->
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h2>Order History</h2>
        </div>
    </div>
    <div class="row">
    	<nav class="navbar navbar-default" role="navigation">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" href="homepage">My Bookstore</a>
				</div>
			</div>
		</nav>
	</div>
    
    <div class="row">
        <div class="col-md-12">
            <h5><b>Records:</b></h5>
			
            <div>
            	<table class='table table-bordered table-striped table-hover' id="dataTables">
            		<thead><tr>
            			<th>Receiver</th>
            			<th>Address</th>
            			<th>Phone</th>
            			<th>Total Price</th>
            			<th>Date</th>
            			<th>Items</th>
            		</tr></thead>
            		<tbody>
            			<%
							for (int i = 0; i < osize; i++) {
								Order order = orderList.get(i);
						%>
						<tr>
            				<td><%=order.getReceiver() %></td>
            				<td><%=order.getAddress() %></td>
            				<td><%=order.getPhone() %></td>
            				<td><%=order.getRealPrice()%></td>
            				<td><%=order.getDateStr()%></td>
            				<td>
            					<button onclick='ShowItems(<%=order.getId()%>)' class='btn btn-primary'>Show</button>
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
            						<th>Book Cover</th>
            						<th>Book Name</th>
            						<th>Number</th>
            						<th>Price</th>
            					</tr></thead>
            					<tbody id="order_item_body">
            					</tbody>
            				</table>
            			</div>
            		</div>
            	</div>
        	</div>
        	<div class="modal-footer">
        		<input type="hidden" id="hidden_order_id">
        	</div>
        </div>
	</div>
</div>

</body>
</html>
