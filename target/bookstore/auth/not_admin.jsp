<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%
	String path = request.getContextPath();
%>
    <title>My Bookstore</title>

    <!-- Bootstrap CSS File  -->
    <link rel="stylesheet" type="text/css" href="<%=path%>/css/bootstrap.css"/>
    
	<link href="<%=path%>/css/flat-ui.css" rel="stylesheet">
	<link href="<%=path %>/css/font-awesome.min.css" rel="stylesheet">  
	
	<!-- Jquery JS file -->
	<script type="text/javascript" src="<%=path%>/js/jquery-1.11.3.min.js"></script>

	<!-- Flat UI JS file -->
	<script type="text/javascript" src="<%=path%>/js/flat-ui.min.js"></script>
	
	<!-- Bootstrap JS file -->
	<script type="text/javascript" src="<%=path%>/js/homepage.js"></script>
	
	
</head>

<body>

	<div class="container">
 		<h1>My Bookstore <small>Wisdom is the new elegance</small></h1>
	</div>
	


    <!-- Page Content -->
    <div class="container">

        <div class="tile" >
        <div class="row">
        	<h3>Permission Denied</h3>
        	<p>
        	You're not administration~
        	</p>
        	<a class="btn btn-primary btn-large" href="homepage">Back to HomePage</a>
        	</div>
			<img src="<%=path%>/img/not_admin.png">
        </div>

    </div>
    <!-- /.container -->

    <!-- Footer -->
    <footer class="py-5 bg-inverse">
        <div class="container">
            <p class="m-0 text-center text-white">Copyright &copy; Your Website 2017</p>
        </div>
        <!-- /.container -->
    </footer>

</body>

</html>
