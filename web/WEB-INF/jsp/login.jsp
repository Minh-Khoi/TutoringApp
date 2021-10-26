<%-- 
    Document   : login
    Created on : Sep 28, 2021, 8:34:13 PM
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>
        <form:form method="POST" enctype="application/json" modelAttribute="loginTeacher"
            action="${pageContext.servletContext.contextPath}/teacher_login.html" >
            <nav class="navbar navbar-dark bg-primary">
                <!-- Navbar content -->
                <h3 style="color: white">Tutoring management web application</h3>
            </nav>
            <h2>LOGIN FORM</h2>
            <div class="form-group">
                <label for="exampleInputEmail1">Email address</label>
                <form:input type="email" class="form-control" id="exampleInputEmail1" path="email" placeholder="Enter email" />
                <small class="form-text text-muted">We'll never share your email with anyone else.</small>
            </div>
            <div class="form-group">
                <label for="exampleInputPassword1">Password</label>
                <form:input type="password" class="form-control" id="exampleInputPassword1" path="password" placeholder="Password"/>
                <small class="form-text text-danger">${message}</small>
            </div>
            <div class="form-check">
                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                <label class="form-check-label" for="exampleCheck1">Check me out</label>
            </div>
            <form:button  type="submit" class="btn btn-block btn-primary">Submit</form:button>
        </form:form>
    </body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
<!--    <form method="POST" enctype="application/json" 
        action="${pageContext.servletContext.contextPath}/user_login.html" >
            <nav class="navbar navbar-dark bg-primary">
                 Navbar content 
                <h3 style="color: white">Tutoring management web application</h3>
            </nav>
            <h2>LOGIN FORM</h2>
            <div class="form-group">
                <label for="exampleInputEmail1">Email address</label>
                <input type="email" class="form-control" id="exampleInputEmail1" name="email" placeholder="Enter email">
                <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
            </div>
            <div class="form-group">
                <label for="exampleInputPassword1">Password</label>
                <input type="password" class="form-control" id="exampleInputPassword1" name="password" placeholder="Password">
                <small id="emailHelp" class="form-text text-muted .text-danger">${message}</small>
            </div>
            <div class="form-check">
                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                <label class="form-check-label" for="exampleCheck1">Check me out</label>
            </div>
            <button  type="submit" class="btn btn-block btn-primary">Submit</button>
            
        </form>-->
<!--    <script>
        document.querySelector("form").addEventListener("submit", function(ev){
            ev.preventDefault();
            let form = new FormData(document.querySelector("form"));
            var formData = JSON.stringify(Object.fromEntries(form.entries()));
            $.ajax({
                type: "POST",
                url: "${pageContext.servletContext.contextPath}/user_login.html",
                data: formData,
                success: function(){},
                dataType: "json",
                contentType : "application/json"
            });
        })
    </script>-->
</html>
