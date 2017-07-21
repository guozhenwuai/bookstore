/**
 * check input
 */


    $(document).ready(function() { 
    	
        $("#login_form").validate({ 
        	submitHandler:function(form){  
                form.submit();
            },
            rules: {  
                username: "required",  
                password: {  
                    required: true,  
                    minlength: 6  
                },  
            },  
            messages: {  
                username: "Please enter your username",  
                password: {  
                    required: "Please enter your password",  
                    minlength: jQuery.format("The length is no less than {6}")  
                },  
            } 
        });
        $("#register_form").validate({ 
        	submitHandler:function(form){ 
                form.submit();
                alert("Register success!");
            },
            rules: {  
                username: {
                	required: true,
                	remote:{
                		url:"nameCheck",
                		type:"post",
                		data:{username:function(){return $("#username").val();}} 
                	}
                },
                password: {  
                    required: true,  
                    minlength: 6 
                },  
                rpassword: {  
                    equalTo: "#register_password"  
                },  
                email: {  
                    required: true,  
                    email: true  
                }  
            },  
            messages: {  
                username: {
                	required: "Please enter your username",
                	remote: jQuery.format("Username already exists")
                },
                password: {  
                    required: "Please enter your password",  
                    minlength: jQuery.format("The length is no less than {6}")  
                },  
                rpassword: {  
                    equalTo: "Two password inputs differ!"  
                },  
                email: {  
                    required: "Please enter your email address",  
                    email: "Please enter valid email address"  
                }  
            }  
        });  
    });  
    $(function() {  
        $("#register_btn").click(function() {  
            $("#register_form").css("display", "block");  
            $("#login_form").css("display", "none");  
        });  
        $("#back_btn").click(function() {  
            $("#register_form").css("display", "none");  
            $("#login_form").css("display", "block");  
        });  
        
    });  
     