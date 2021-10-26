<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tutoring Web App</title>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <!-- Google Fonts -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
        <!-- Bootstrap core CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
        <!--Datatable jquery-->
        <link href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.min.css">
        
    </head>
    
    <!-- JQuery -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- Bootstrap tooltips -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
    <!-- Bootstrap core JavaScript -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <!--Jquery Table script-->
    <script type="text/javascript" src="https:////cdn.datatables.net/1.11.3/js/jquery.dataTables.min.js"></script>
    
    <body>
        <nav class="navbar navbar-dark bg-primary">
            <!-- Navbar content -->
            <h3 style="color: white">Teachers management app!! Teacher: ${usingTeacher.fullname}</h3>
            <a class="btn btn-outline-warning" 
               href="${pageContext.servletContext.contextPath}/gototeachers/reload/${usingTeacher.token}.html">
                Go to teachers task
            </a>
            <a class="btn btn-outline-warning" 
               href="${pageContext.servletContext.contextPath}/gotoclasses/reload/${usingTeacher.token}.html">
                Go to Classes task
            </a>
            <a class="btn btn-outline-warning" 
               href="${pageContext.servletContext.contextPath}/gotostudents/reload/${usingTeacher.token}.html">
                Go to Students task
            </a>
        </nav>

        <div class="row">
            
            <div class="col-sm-4 mt-2" style="border-width: 3px !important">
                <h1> 
                    Teacher ID: <br/>
                    <span class="text-break" style="font-size:1rem; font-weight: 800">
                        "<span class="text-success"></span>"
                    </span>
                </h1>
                <form:form id="frm" action="${pageContext.servletContext.contextPath}/docreateclass.html" 
                                    modelAttribute="teacherOnForm" onsubmit="doSubmitForm(event)" method="POST">
                    <input type="hidden" name="usingTeacherToken" value="${usingTeacher.token}" />
                    <div class="input-group mb-3">
                        <label class="input-group-prepend mb-0" for="fullname">
                          <span class="input-group-text" id="basic-addon1">Full name</span>
                        </label>
                        <form:input type="text" class="form-control" placeholder="Username" id="fullname" path="fullname"
                                                aria-label="Username" aria-describedby="basic-addon1"/>
                    </div>

                    <div class="input-group mb-3">
                        <label class="input-group-prepend mb-0">
                            <span class="input-group-text" id="basic-addon1">Specialize</span>                            
                        </label>
                        <form:input type="text" class="form-control" placeholder="DD/MM/YYYY" path="specialize"
                               id="birthday" aria-label="Recipient's username" aria-describedby="basic-addon2" />
                    </div>

                    <div class="input-group mb-3">
                        <label class="input-group-prepend mb-0">
                            <span class="input-group-text" id="basic-addon1">Phone number</span>                            
                        </label>
                        <form:input type="number" class="form-control" path="phone"
                                    id="phone" aria-describedby="basic-addon3"/>
                    </div>

                    <div class="input-group mb-3">
                        <label class="input-group-prepend mb-0" for="email">
                            <span class="input-group-text">Email</span>
                        </label>
                        <form:input type="email" class="form-control" path="email" id="email"
                                            aria-label="Amount (to the nearest dollar)"/>
                    </div>

                    <button class="btn btn-block btn-info btn_submit" type="submit" >
                        <b>
                            <c:choose>
                                <c:when test="${not empty formAction}">
                                    ${formAction} 
                                </c:when>    
                                <c:otherwise>
                                    Create new
                                </c:otherwise>
                            </c:choose>
                        </b>
                    </button>
                    <a class="btn btn-outline-info mx-3 btn_reset" style="display:none; text-align: center" 
                        href="${pageContext.servletContext.contextPath}/gototeachers/reload/${usingTeacher.token}.html">
                        reload page to go back to Create new Student
                    </a>
                </form:form>
                <script>
                    function doSubmitForm(ev){
                        if ($(".btn_reset").css("display") == "none"){
                            return;
                        }
                        ev.preventDefault();
                        let form = document.getElementById("frm");
                        let formDatas = new FormData(form);
                        formDatas.append("teacherID", document.querySelector(".col-sm-4 h1 > span >span").innerHTML );
                        let formStudent = Object.fromEntries(formDatas.entries());
                        let formAction = $("#frm .btn_submit").text();
                        fetch("${pageContext.servletContext.contextPath}/dochangeteacher/"+formAction+".html", {
                            body : JSON.stringify(formStudent), method:"POST",
                            headers: {
                                'Content-Type': 'application/json',
                                "Teacher-Token" : "${usingTeacher.token}"
                            }
                        }).then(resolve => resolve.text())
                        .then(result => {
                            if(result.indexOf("ERROR") != -1){
                                alert(result);
                            }
                            console.log(result);
                        })
                    }
                    
                </script>
            </div>
            <div class="col-sm-8 mt-2">
                <!--CSS styles for DataTable-->
                <style>
                    .dataTables_wrapper {
                        display: flex;
                        flex-flow: row wrap;
                    }
                    .dataTables_wrapper .dataTables_filter, .dataTables_wrapper #dtBasicExample_paginate{
                        margin-left: auto
                    }
                    .dataTables_wrapper #dtBasicExample_paginate a{
                        box-sizing: border-box;
                        display: inline-block;
                        min-width: 1.5em;
                        padding: .5em 1em;
                        margin-left: 2px;
                        text-align: center;
                        text-decoration: none !important;
                        cursor: pointer;
                        *cursor: hand;
                        color: #333 !important;
                        border: 1px solid transparent;
                        border-radius: 2px;
                    }
                    .dataTables_wrapper #dtBasicExample_paginate a.current{
                        color: #333 !important;
                        border: 1px solid #979797;
                        background-color: #fff;
                    }
                    .dataTables_wrapper #dtBasicExample_paginate a:hover{
                        color: #fff !important;
                        border: 1px solid #111;
                        outline: none;
                        background-color: #2b2b2b
                    }
                </style>
                <!--Table-->
                <table id="dtBasicExample" class="table table-striped table-bordered table-sm mt-2 mb-4" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th class="th-sm">Full name</th>
                            <th class="th-sm">Specialize</th>
                            <th class="th-sm">Email</th>
                            <th class="th-sm">See Info</th>
                            <th class="th-sm">Update/Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="teacher" items="${teachersList}" varStatus="loop">
                            <tr>
                                <td>${teacher.fullname}</td>
                                <td>${teacher.specialize }</td>
                                <td>${teacher.email}</td>
                                <td>
                                    <button class="btn btn-secondary" onclick="onClicked(${loop.index}, 'see')">See Info</button>
                                </td>
                                <td>
                                    <button class="btn btn-warning" onclick="onClicked(${loop.index}, 'update')">Update</button>
                                    <button class="btn btn-danger" onclick="onClicked(${loop.index}, 'delete')">Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot>
                        <tr>
                            <th class="th-sm">Full name</th>
                            <th class="th-sm">Gender</th>
                            <th class="th-sm">Birth day</th>
                            <th class="th-sm">See Info</th>
                            <th class="th-sm">Update/Delete</th>
                        </tr>
                    </tfoot>
                </table>
                <!--Script to make the DataTable work-->
                <script type="text/javascript">
                    $(document).ready(function () {
                        $('#dtBasicExample').DataTable();
                        $('.dataTables_length').addClass('bs-select');
                    });
                    
                    function onClicked(teacherIndex, formAction){
                        let teachersList = ${teachersList};
                        let teacherOnForm = teachersList[teacherIndex];
                        console.log(teacherOnForm);
                        // Border the form and display the reset button
                        $("#frm").parent().addClass("border pl-4 pb-3 pt-3");
                        $("#frm .btn_reset").css("display", "block");
                        // Render values for input tags
                        document.querySelector(".col-sm-4 h1 > span > span").innerHTML =  teacherOnForm["TeacherID"];
                        document.querySelector("form#frm input[name='fullname']").value = teacherOnForm["Fullname"];
                        document.querySelector("form#frm input[name='specialize']").value = teacherOnForm["Specialize"];
                        document.querySelector("form#frm input[name='phone']").value = teacherOnForm["Phone"];
                        document.querySelector("form#frm input[name='email']").value = teacherOnForm["Email"];
                        // switch formAction
                        if(formAction == "see"){
                            $("#frm").parent().addClass("border-secondary").removeClass("border-warning border-danger");
                            $("form#frm button[type='submit']").html('see').attr("disabled", true)
                                                    .addClass("bg-secondary").removeClass("bg-danger bg-warning");
                        } else if (formAction == "update"){
                            $("#frm").parent().addClass("border-warning").removeClass("border-secondary border-danger");
                            $("form#frm button[type='submit']").html('update')
                                        .addClass("bg-warning").removeClass("bg-danger bg-secondary");
                        } else {
                            $("#frm").parent().addClass("border-danger").removeClass("border-warning border-secondary");
                            $("form#frm button[type='submit']").html('delete')
                                        .addClass("bg-danger").removeClass("bg-warning bg-secondary");
                        }
                    }
                </script>
            </div>
        </div>
        
    </body>
    <script>
        window.onload = () => {
            // Show the "message" parameter on alert box
            let message = "${message}";
            if(message.length>0){
                alert(message);
            }
        }
    </script>
    
</html>
