    <!DOCTYPE html>  
    <html>  
        <head>  
            <meta charset="utf-8" />  
            <title>My Bookstore - Login Page</title> 
            <link href="css/bootstrap.min.css" rel="stylesheet"> 
            <link href="css/font-awesome.min.css" rel="stylesheet">  
            <script src="js/jquery-1.11.3.min.js"></script>   
            <script src="js/bootstrap.min.js"></script>  
            <!--jquery.validate-->  
            <script type="text/javascript" src="js/jquery.validate.min.js" ></script>  
              
            <style type="text/css">  
                body{background: url(img/login_background.jpg) no-repeat;background-size:cover;font-size: 16px;}  
                .form{background: rgba(255,255,255,0.2);width:400px;margin:100px auto;}  
                #login_form{display: block;}  
                #register_form{display: none;}  
                .fa{display: inline-block;top: 27px;left: 6px;position: relative;color: #ccc;}  
                input[type="text"],input[type="password"]{padding-left:26px;}  
                .checkbox{padding-left:21px;}  
            </style>  
        </head>  
        
        <body> 
        <script type="text/javascript"> 
			var msg="${requestScope.Message}";
			if(msg==1){
				alert("Invalid username or password");
			}
		</script>
		
        <div class="container">  
            <div class="form">  
                <form class="form-horizontal col-sm-offset-3 col-md-offset-3" id="login_form" method="post" action="login">  
                    <h3 class="form-title">Login to your account</h3>  
                    <div class="col-sm-9 col-md-9">  
                        <div class="form-group">  
                            <i class="fa fa-user fa-lg"></i>  
                            <input class="form-control required" type="text" placeholder="Username" name="username" autofocus="autofocus" maxlength="20"/>  
                        </div>  
                        <div class="form-group">  
                                <i class="fa fa-lock fa-lg"></i>  
                                <input class="form-control required" type="password" placeholder="Password" name="password" maxlength="20"/>  
                        </div>  
                        <div class="form-group">  
                            <label class="checkbox">  
                                <input type="checkbox" name="remember" value="1"/> Remember me  
                            </label>  
                            <hr />  
                            <a href="javascript:;" id="register_btn" class="">Create an account</a>  
                        </div>  
                        <div class="form-group">  
                            <input type="submit" class="btn btn-success pull-right" value="Login "/>     
                        </div>  
                    </div>  
                </form>  
            </div>  
            
      		<div class="form">  
                <form class="form-horizontal col-sm-offset-3 col-md-offset-3" id="register_form" method="post" action="register">  
                    <h3 class="form-title">Register for your account</h3>  
                    <div class="col-sm-9 col-md-9">  
                        <div class="form-group">  
                            <i class="fa fa-user fa-lg"></i>  
                            <input class="form-control required" type="text" onBlur="checkIsExist();"
                            placeholder="Username" name="username" id="username" autofocus="autofocus" maxlength="20"/>  
                        </div>  
                        <div class="form-group">  
                                <i class="fa fa-lock fa-lg"></i>  
                                <input class="form-control required" type="password" placeholder="Password" id="register_password" name="password" maxlength="20"/>  
                        </div>  
                        <div class="form-group">  
                                <i class="fa fa-check fa-lg"></i>  
                                <input class="form-control required" type="password" placeholder="Re-type Your Password" name="rpassword" maxlength="20"/>  
                        </div>  
                        <div class="form-group">  
                                <i class="fa fa-envelope fa-lg"></i>  
                                <input class="form-control eamil" type="text" placeholder="Email" name="email"/>                           	  
                        </div>  
                        <div class="form-group">
                            <input type="submit" class="btn btn-success pull-right" value="Sign Up "/>  
                            <input type="button" class="btn btn-info pull-left" id="back_btn" value="Back"/> 
                        </div>  
                    </div>  
                </form>  
            </div>  
            
            </div>  
            <script type="text/javascript" src="js/loginMessage.js" ></script>
        </body>  
    </html>  