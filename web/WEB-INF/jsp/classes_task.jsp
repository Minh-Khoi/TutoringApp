<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--page parameters-->
        <meta content="${usingTeacher.token}" name="usingTeacherToken"/>
        <meta content="${message}" name="message"/>
        <meta content="${pageContext.servletContext.contextPath}" name="pageContextPath"/>
        <!--<span hidden role="meta" name="teachersList">${teachersList}</span>-->
        
        <!--page parameters end-->
        <title>Classes 's Task. Tutoring Web App</title>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <!-- Google Fonts -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap">
        <!-- Bootstrap core CSS -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
        
        
    </head>
    
    <!-- JQuery -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- Bootstrap tooltips -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.4/umd/popper.min.js"></script>
    <!-- Bootstrap core JavaScript -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.0/js/bootstrap.min.js"></script>
    
    
    <body>
        <nav class="navbar navbar-dark bg-primary">
            <!-- Navbar content -->
            <h3 style="color: white">Class info management app!! Teacher: ${usingTeacher.fullname}</h3>
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
                    Info for Class ID: <br/>
                    <span class="text-break" >
                        "<span class="text-success"></span>"
                    </span>
                </h1>
                <form:form id="frm" action="${pageContext.servletContext.contextPath}/doupdateclass.html" 
                                                            modelAttribute="classOnFormUpdate"  method="POST">
                    <input type="hidden" name="usingTeacherToken" value="${usingTeacher.token}" />
                    
                    <form:input type="hidden" class="form-control" id="classID" path="classID" 
                                placeholder="classID"  aria-label="Username" aria-describedby="basic-addon1"/>
                    <div class="input-group mb-3">
                        <label class="input-group-prepend mb-0" for="subject">
                          <span class="input-group-text" id="basic-addon1">Subject</span>
                        </label>
                        <form:input type="text" class="form-control" id="subject" path="subject" disabled="true"
                                 placeholder="Subject"  aria-label="Username" aria-describedby="basic-addon1"/>
                    </div>

                    <div class="input-group mb-3">
                        <label class="input-group-prepend mb-0" for="fee">
                            <span class="input-group-text" id="basic-addon1">Fee</span>                            
                        </label>
                        <form:input type="number" class="form-control"  path="fee" step=".01" disabled="true"
                                    id="fee" aria-label="" aria-describedby="basic-addon2" />
                    </div>

                    <div class="input-group mb-3">
                        <label class="input-group-prepend mb-0" for="remuneration">
                            <span class="input-group-text">Remuneration</span>
                        </label>
                        <form:input type="number" class="form-control" step=".01" disabled="true" list="remunerationSuggest"
                                    path="remuneration" id="remuneration" aria-label="Amount (to the nearest dollar)"/>
                        <datalist id="remunerationSuggest">
                            <option>
                                30% of all fees of class: <span></span> 
                            </option>
                        </datalist>
                    </div>
                    <div class="input-group mb-3">
                        <label class="input-group-prepend mb-0" for="teacherID">
                            <span class="input-group-text">Teacher</span>
                        </label>
                        <form:input placeholder="type name, specialize, id of teacher" type="text" disabled="true"
                                    class="form-control"  path="teacherID" id="teacherID" list="teachersList"/>
                        <datalist id="teachersList" placeholder="type name, specialize, id of teacher" >
                            <c:forEach items="${teachersList}" var="teacher" varStatus="loop" >
                                <option value="${teacher.teacherID}"> ${teacher.fullname} (${teacher.specialize}) </option>
                            </c:forEach>
                        </datalist>
                    </div>
                    
                    <button class="btn btn-block btn-warning btn_activate" type="button" onclick="activateUpdating(true)">
                        Activate Updating
                    </button>                        
                    <button class="btn btn-block btn-warning btn_unactivate" type="button" 
                            style="display:none" onclick="activateUpdating(false)">
                        Disabled Updating
                    </button>                     
                    <script>
                        /**
                         * This function activate the form (disabled loaded) and show the button ".btn_submit" (update button)
                         */
//                        function activateUpdating(activating){
//                            $("button.btn_activate").css("display", (activating) ? "none":"");
//                            $("button.btn_submit, button.btn_unactivate").css("display", (!activating) ? "none":"");
//                            $("form#frm input").attr("disabled", !activating);
//                        }
                    </script>
                    <button class="btn btn-block btn-info btn_submit" type="submit" style="display:none" >
                        <b>
                            <c:choose>
                                <c:when test="${not empty formAction}">
                                    ${formAction} 
                                </c:when>    
                                <c:otherwise>
                                    update 
                                </c:otherwise>
                            </c:choose>
                        </b>
                    </button>
                </form:form>
                
                <!-- Create Class Button and Modal-->
                <span class="btn btn-outline-success ml-2 btn_reset" style=" text-align: center" 
                                data-toggle="modal" data-target="#modal_create_class">
                        Go Adding new class
                </span>
                <!--Modal-->
                <div class="modal fade" id="modal_create_class" tabindex="-1" role="dialog" 
                                    aria-labelledby="modal_create_class_title" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLongTitle">Create a new Class</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form:form id="frm_create" modelAttribute="classOnFormCreate" method="POST"
                                           action="${pageContext.servletContext.contextPath}/docreateclass.html" >
                                    <input type="hidden" name="usingTeacherToken" value="${usingTeacher.token}" />
                                    <div class="input-group mb-3">
                                        <label class="input-group-prepend mb-0" for="subject">
                                          <span class="input-group-text" id="basic-addon1">Subject</span>
                                        </label>
                                        <form:input type="text" class="form-control" id="subject" path="subject" 
                                                 placeholder="Subject"  aria-label="Username" aria-describedby="basic-addon1"/>
                                    </div>

                                    <div class="input-group mb-3">
                                        <label class="input-group-prepend mb-0" for="fee">
                                            <span class="input-group-text" id="basic-addon1">Fee</span>                            
                                        </label>
                                        <form:input type="number" class="form-control"  path="fee" step=".01" 
                                                    id="fee" aria-label="" aria-describedby="basic-addon2" />
                                    </div>

                                    <div class="input-group mb-3">
                                        <label class="input-group-prepend mb-0" for="remuneration">
                                            <span class="input-group-text">Remuneration</span>
                                        </label>
                                        <form:input type="number" class="form-control" step=".01" 
                                            path="remuneration" id="remuneration" aria-label="Amount (to the nearest dollar)"/>
                                    </div>
                                    <div class="input-group mb-3">
                                        <label class="input-group-prepend mb-0" for="teacherID_add">
                                            <span class="input-group-text">Teacher</span>
                                        </label>
                                        <form:input placeholder="type name, specialize, id of teacher" type="text" 
                                                    value="type name, specialize, id of teacher" class="form-control" 
                                                    path="teacherID" id="teacherID_add" list="teachersList"/>
                                        <datalist id="teachersList" placeholder="type name, specialize, id of teacher" >
                                            <c:forEach items="${teachersList}" var="teacher" varStatus="loop" >
                                                <option value="${teacher.teacherID}"> 
                                                    ${teacher.fullname} (${teacher.specialize}) 
                                                </option>
                                            </c:forEach>
                                        </datalist>
                                    </div>

                                </form:form>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary" form="frm_create">Create</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!--End Modal-->
                <!--Finist create class-->
                
                <span class="btn btn-outline-danger ml-2 btn_drop" style=" text-align: center" 
                      data-toggle="modal" data-target="#modal_delete_class">
                    delete this class
                </span>
                <!-- Modal -->
                <div class="modal fade" id="modal_delete_class" tabindex="-1" role="dialog" 
                                    aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLongTitle">Delete Class <b></b></h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                Plese check the class info again before making a decision!!!
                            </div>
                            <div class="modal-footer">
                                <b style="color: red">Do you agree to delete this class</b>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                <form action="${pageContext.servletContext.contextPath}/dodeleteclass.html" method="POST">
                                    <input type="hidden" name="classID" />
                                    <input type="hidden" name="usingTeacherToken" value="${usingTeacher.token}" />
                                    <button type="submit" class="btn btn-primary">Yes, Delete it now</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!--End Modal-->
                
            </div>
            <div class="col-sm-8 mt-2">
                <select class="form-control" id="set-active" onchange="loadClassesList(event)">
                    <option value="1" checked> active </option>
                    <option value="0"> Inactive </option>
                    <script>
//                        /** 
//                         * Handle the event on change of the select "set-active" 
//                         */
//                        function loadClassesList(event){
//                            let status = document.getElementById("set-active").value;
//                            fetch("${pageContext.servletContext.contextPath}/loadclasseslist/"+status+".html", {
//                                method:"GET",
//                                headers: {
//                                    'Content-Type': 'application/json',
//                                    "Teacher-Token" : "${usingTeacher.token}"
//                                }
//                            }).then(response => response.text())
//                            .then(result => {
//                                console.log(result);
//                                if(result.indexOf("ERROR") != -1){
//                                    alert(result);
//                                }
//                                let listClasses = JSON.parse(result);
//                                $("#find-class option").remove();
//                                for(let cla of listClasses){
//                                    let newOption = $("<option></option>").attr("value", cla.ClassID)
//                                                        .text(cla.Subject+" (Class ID: " + cla.ClassID+")");
//                                    $("#find-class").prepend(newOption);
//                                };
//                                loadClassInfo();
//                            });
//                        };
                    </script>
                </select>                
                
                <select class="form-control" id="find-class" onchange="loadClassInfo(event)" >
                    <c:forEach items="${classesList}" var="class" varStatus="loop">
                        <c:choose>
                            <c:when test="${classChoosen.classID == class.classID}">
                                <option value="${class.classID}" selected> ${class.subject} (Class ID: ${class.classID}) </option>
                            </c:when>
                            <c:otherwise>
                                <option value="${class.classID}" > ${class.subject} (Class ID: ${class.classID}) </option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                                
                </select>
                
                <h4>Student 's list</h4>
                <!-- Modal and Button add student to class-->
                <button class="btn btn-outline-secondary" data-toggle="modal" data-target="#modal_all_students_list">
                    Add Students to Class
                </button>
                <div class="modal fade" id="modal_all_students_list" tabindex="-1" role="dialog" 
                                aria-labelledby="exampleModalLongTitle" aria-hidden="true">
                    <div class="modal-dialog" role="document" style="max-width: 70vw">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h6 class="modal-title" id="exampleModalLongTitle">List all students</h6>
                                <input class="form-control" id="searcher" type="text" placeholder="Search..">
                            </div>
                            <div class="modal-body">
                                <table id="table_all_students" 
                                       class="table table-striped table-bordered table-sm mt-2 mb-4" cellspacing="0" width="100%">
                                    <thead>
                                        <tr>
                                            <th class="th-sm">Full name</th>
                                            <th class="th-sm">Gender</th>
                                            <th class="th-sm">Birth day</th>
                                            <th class="th-sm">Phone</th>
                                            <th class="th-sm">Email</th>
                                            <th class="th-sm " >Remove from class</th>
                                        </tr>
                                    </thead>

                                    <tbody>
                                        <c:forEach items="${allStudents}" var="stu" varStatus="loop">
                                            <tr>
                                                <td> ${stu.fullname} </td>
                                                <td> ${(stu.gender==0) ? "Female" : "Male"} </td>
                                                <td> ${stu.birthday} </td>
                                                <td> ${stu.phone} </td>
                                                <td> ${stu.email} </td>
                                                <td>
                                                    <button class="btn btn-primary" 
                                                            onclick="addToClassOrRestore(event,'add', '${stu.studentCode}')"> 
                                                        ADD to class 
                                                    </button>
                                                    <button class="btn btn-secondary" style="display: none"
                                                             onclick="addToClassOrRestore(event,'restore', '${stu.studentCode}')">
                                                        Restore 
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <script>
//                                            /**
//                                             * Handle the "click" event of buttons in the table "all students"
//                                             */
//                                            function addToClassOrRestore(event, action, stCode){
//                                                $(event.target).slideToggle();
//                                                $(event.target).siblings().slideToggle();
//                                                let classID= $("#find-class").val();
//                                                let actionPath = action + "/studenttoclass" ;
//                                                fetch("${pageContext.servletContext.contextPath}/"+actionPath +"/" + classID+".html", {
//                                                    body: stCode,
//                                                    method:"POST",
//                                                    headers: {
//                                                        'Content-Type': 'application/json',
//                                                        "Teacher-Token" : "${usingTeacher.token}"
//                                                    }
//                                                }).then(response => response.text())
//                                                .then(result => {
//                                                    if(result.indexOf("ERROR") != -1){
//                                                        alert(result);
//                                                    }
//                                                    console.log(result);
//                                                });
//                                            }
//                                            /**
//                                            * And the filter feature to the input#searcher
//                                            */
//                                            $("#searcher").on("keyup", function() {
//                                                var value = $(this).val().toLowerCase();
//                                                $(".modal#modal_all_students_list #table_all_students tbody tr").filter(function() {
//                                                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
//                                                });
//                                            });
                                        </script>
                                    </tbody>

                                    <tfoot>
                                        <tr>
                                            <th class="th-sm">Full name</th>
                                            <th class="th-sm">Gender</th>
                                            <th class="th-sm">Birth day</th>
                                            <th class="th-sm">Phone</th>
                                            <th class="th-sm">Email</th>
                                            <th class="th-sm" >Remove from class</th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
                <script>
                    
                </script>
                <!--End Modal adding student to class-->
                <!--Button and script archive the class-->
                <button class="btn btn-warning archiveClass" >
                    Archive this class
                </button>
                <script>
//                    function archiveClass(event){
//                        let classID = $("#find-class").val();
//                        fetch("${pageContext.servletContext.contextPath}/createfeeforclass/"+classID+".html", {
//                            body: classID , method:"POST",
//                            headers: {
//                                'Content-Type': 'application/json',
//                                "Teacher-Token" : "${usingTeacher.token}"
//                            }
//                        }).then((response) => response.text())
//                        .then((result)=> {
//                            if (result.indexOf("ERROR") ===-1){
//                                alert(result);
//                            } else {
//                                loadClassInfo(event);
//                            }
//                        });
//                    }
                </script>
                <!--End archive the class-->
                <!--Button and script inactive class-->
                <button class="btn btn-outline-danger inactiveClass" >
                    Inactive this class
                </button>
                <!--End inactive class-->
                <!--Table-->
                <table id="dtBasicExample" class="table table-striped table-bordered table-sm mt-2 mb-4" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th class="th-sm">Full name</th>
                            <th class="th-sm">Gender</th>
                            <th class="th-sm">Birth day</th>
                            <th class="th-sm">Phone</th>
                            <th class="th-sm">Email</th>
                            <th class="th-sm " >Remove from class</th>
                        </tr>
                    </thead>
                    
                    <tbody>
                        <!--When the tag select#find-class is choosen, a request will be sent to server. Then 
                            the response will be returned with info of the class with the whole students list of class
                            the list of student will be located here in table. and the info of class be displayed in
                            the form. Whole this task is executed in Javascript on client-side.
                        -->  
                    </tbody>
                    
                    <tfoot>
                        <tr>
                            <th class="th-sm">Full name</th>
                            <th class="th-sm">Gender</th>
                            <th class="th-sm">Birth day</th>
                            <th class="th-sm">Phone</th>
                            <th class="th-sm">Email</th>
                            <th class="th-sm" >Remove from class</th>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
        
    </body>
    <script src="${pageContext.servletContext.contextPath}/javascript/class_task.js?t=1113"></script>
    <script>        
        $(document).ready(()=>{
            // Show the "message" parameter on alert box
            let message = "${message}";
            if(message.length>0){
                alert(message);
            }
            
            // This script add event on click to the select#find-class selector 's element
            loadClassInfo();
        });
        /**
        * Handle the event showing modal_delete_class
        */
        $(".modal#modal_delete_class").on("shown.bs.modal", (event) => {
            let classID = $(".col-sm-4 h1 .text-break .text-success").html();
//            console.log(classID);
            $(event.target).find("form > input[name='classID']").val(classID);
        })
        
        /**
        * And the filter feature to the input#searcher
        */
        $("#searcher").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $(".modal#modal_all_students_list #table_all_students tbody tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });
        
        /**
        * Create method handle modal close event. The button "add to class" should be redisplayed
        * and  the button "restore" should be done reversedly
        */
        $(".modal#modal_all_students_list").on("hidden.bs.modal", (event)=> {
            $(event.target).find(".btn.btn-primary").css("display","");
            $(event.target).find(".btn.btn-secondary").css("display","none");
            loadStudentList();
        })
        
        
        
    </script>
    
    
</html>
