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
    <title>Sale Statistics</title>

    <!-- Bootstrap CSS File  -->
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css"/>
    
	<link href="<%=path%>/css/flat-ui.css" rel="stylesheet">
	
	<!-- Jquery JS file -->
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.3.min.js"></script>

	<!-- Bootstrap JS file -->
	<script type="text/javascript" src="<%=path%>/js/bootstrap.min.js"></script>
	<script src="<%=path%>/js/Chart.js"></script>

	<!-- Custom JS file -->
	<script type="text/javascript" src="<%=path%>/js/sales.js"></script>

	<script src="<%=path%>/js/flat-ui.min.js"></script>

</head>
<body onload="loadChart()">

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
						<li class="active"><a href="/bookstore/admin/sale.jsp">Sale</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</div>
    
    <div class="row">
        <div class="col-md-12">
        	<div class="pull-right">
        		<button class="btn btn-success" onclick="showModal()">Criteria</button>
        	</div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12" id="chart_div">
        	<div id="total_sales"></div>
            <canvas id="myChart" height="400"></canvas>
        </div>
    </div>
</div>
<!-- /Content Section -->

<div class="modal fade" id="specify_modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Statistic Criteria</h4>
            </div>
            <div class="modal-body">
            <form enctype="multipart/form-data">

                <div class="form-group">
            		<label for="user">User Id</label>
                	<input type="text" id="user" placeholder="User Id" class="form-control" style="width:200px"/>
            	</div>
            	<label>Start Time</label>
            	<div class="form-inline">
                	<input type="text" id="start_year" placeholder="Year" class="form-control" style="width:160px"/>
                	<input type="text" id="start_month" placeholder="Month" class="form-control" style="width:160px"/>
                	<input type="text" id="start_day" placeholder="Day" class="form-control" style="width:160px"/>
            	</div>
            	<label>End Time</label>
            	<div class="form-inline">
                	<input type="text" id="end_year" placeholder="Year" class="form-control" style="width:160px"/>
                	<input type="text" id="end_month" placeholder="Month" class="form-control" style="width:160px"/>
                	<input type="text" id="end_day" placeholder="Day" class="form-control" style="width:160px"/>
            	</div>
            	<div class="form-group">
                    <label>Book/Category?</label>
                    <div>
                    	<label class="checkbox-inline">
                    		<input type="radio" name="book_category" value="book"/>Book
                    	</label>
                    	<label class="checkbox-inline">
                    		<input type="radio" name="book_category" value="category" checked/>Category
                    	</label>
                    </div>
                </div>
            	<div class="form-group">
            		<label for="book">Book/Category Name</label>
                	<input type="text" id="name" placeholder="Book/Category Name" class="form-control" style="width:200px"/>
            	</div>

			</form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="criteria()">GO</button>
            </div>
        </div>
    </div>
</div>
<!-- // Modal -->

</body>
</html>
