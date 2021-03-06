<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!--Page Parameters-->
        <meta content="${usingTeacher.token}" name="usingTeacherToken"/>
        <meta content="${message}" name="message"/>
        <meta content="${pageContext.servletContext.contextPath}" name="pageContextPath"/>
        <span hidden role="meta" name="feesList">${feesJSON}</span>
        <span hidden role="meta" name="studentOnChecking">${studentOnChecking}</span>
        <!--Page Parameters-->
        
        
        <title>Fees 's task. Tutoring Web App</title>
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
            <h3 style="color: white">Fees management app!! Teacher: ${usingTeacher.fullname}</h3> 
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
            
            <form:form action="${pageContext.servletContext.contextPath}/gotodepts/reload.html">
                <input name="usingTeacherToken" type="hidden" value="${usingTeacher.token}"/>
                <button class="btn btn-outline-warning" type="submit"> Go to Fees task </button>
            </form:form>
        </nav>

        <div class="row">
            
            <div class="col-sm-4 mt-2"style="border-width: 3px !important">
                <!-- Student info form. (This form just for show info, not for submitting -->
                <h1> 
                    Student Info: 
                </h1>
                <form:form id="frm"  modelAttribute="studentOnChecking" >
                    <input type="hidden" name="teacherToken" value="${usingTeacher.token}" />
                    <div class="input-group mb-2">
                        <label class="input-group-prepend mb-0" for="fullname">
                          <span class="input-group-text" id="basic-addon1">Full name</span>
                        </label>
                        <form:input type="text" class="form-control" placeholder="Username" 
                            id="fullname" path="fullname" aria-label="Username" aria-describedby="basic-addon1"/>
                    </div>

                    <div class="input-group mb-2">
                        <label class="input-group-prepend mb-0">
                            <span class="input-group-text" id="basic-addon1">Birthday</span>                            
                        </label>
                        <form:input type="text" class="form-control" placeholder="DD/MM/YYYY" path="birthday"
                               id="birthday" aria-label="Recipient's username" aria-describedby="basic-addon2" />
                    </div>

                    <div class="input-group mb-2">
                        <label class="input-group-prepend mb-0">
                            <span class="input-group-text" id="basic-addon1">Phone number</span>                            
                        </label>
                        <form:input type="number" class="form-control" path="phone"
                                    id="phone" aria-describedby="basic-addon3"/>
                    </div>

                    <div class="input-group mb-2">
                        <label class="input-group-prepend mb-0" for="email">
                            <span class="input-group-text">Email</span>
                        </label>
                        <form:input type="email" class="form-control" path="email" id="email"
                                            aria-label="Amount (to the nearest dollar)"/>
                    </div>

                    <div class="input-group">
                        <div class="input-group-prepend">
                            
                        </div>
                        <div class="input-group mb-2">
                            <label class="input-group-prepend mb-0">
                                <label class="input-group-text" for="genderGroupSelect">Gender</label>
                            </label>
                            <form:select class="custom-select" id="genderGroupSelect" path="gender" value="1">
                                <option >Choose...</option>
                                <option value="1">Female</option>
                                <option value="0">Male</option>
                            </form:select>
                        </div>
                    </div>
                    
                    <a class="btn btn-outline-info mx-3 btn_reset" style="display:none; text-align: center" 
                        href="${pageContext.servletContext.contextPath}/teacher_login/reload/${usingTeacher.token}.html">
                        reload page to go back to Create new Student
                    </a>
                </form:form>
                <!-- End student info showing form -->
                
                <!-- Class info form. (This form just for show info, not for submitting -->
                <h1> 
                    Class Info: 
                </h1>
                <div id="cls">
                    <div class="input-group mb-2">
                        <label class="input-group-prepend mb-0" >
                          <span class="input-group-text" id="basic-addon1">Teacher's name</span>
                        </label>
                        <input type="text" class="form-control" placeholder="Teacher's name" id="classTeacherName"/>
                    </div>
                    <div class="input-group mb-2">
                        <label class="input-group-prepend mb-0" for="fullname">
                          <span class="input-group-text" id="basic-addon1">Subject of class</span>
                        </label>
                        <input type="text" class="form-control" placeholder="Subject of class" id="classSubject"/>
                    </div>
                    <div class="input-group mb-2">
                        <label class="input-group-prepend mb-0" for="fullname">
                          <span class="input-group-text" id="basic-addon1">Fee's cost</span>
                        </label>
                        <input type="text" class="form-control" placeholder="Fee's cost" id="classFeeCost"/>
                    </div>
                </div>
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
                <table id="dtBasicExample" 
                       class="table table-striped table-bordered table-sm mt-2 mb-4" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th class="th-sm">Student name</th>
                            <th class="th-sm" ondblclick="filterClass()" >
                                Class ID <br/> <span style="font-size: 10px">(Double Click here to reset filter class)</span>
                            </th>
                            <th class="th-sm">See Info</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="fee" items="${feesList}" varStatus="loop">
                            <c:if test="${fee['Student'] != null}">
                                <tr>
                                    <td>${fee['Student']["Fullname"]}</td>
                                    <td>
                                        <button class="btn btn-link" onclick="filterClass(${fee['ClassID']})">
                                            ${fee["ClassID"]}
                                        </button>  
                                    </td>
                                    <td>
                                        <button class="btn btn-secondary" 
                                                onclick="loadStudentOnChecking(${loop.index})">
                                            See Info
                                        </button>
                                        <span hidden>${fee["StudentCode"]}</span>
                                    </td>

                                </tr>
                            </c:if>
                        </c:forEach>
                        
                    </tbody>
                    <tfoot>
                        <tr>
                            <th class="th-sm">Student name</th>
                            <th class="th-sm" ondblclick="filterClass()" >
                                Class ID <br/> <span style="font-size: 10px">(Double Click here to reset filter class)</span>
                            </th>
                            <th class="th-sm">See Info</th>
                        </tr>
                    </tfoot>
                </table>
                
            </div>
        </div>
        
    </body>
    <script src="${pageContext.servletContext.contextPath}/javascript/fee_task.js?t=21335"></script>
    <script>
        window.onload = () => {
            // Show the "message" parameter on alert box
            let message = "${message}";
            if(message.length>0){
                alert(message);
            }
        }
        $(document).ready(function () {
            $('#dtBasicExample').DataTable();
            $('.dataTables_length').addClass('bs-select');
        });
    </script>
    
</html>
