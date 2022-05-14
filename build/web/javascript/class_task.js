/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


console.log("classes_task.js say hello");

/**
* This function activate the form (disabled loaded) and show the button ".btn_submit" (update button)
*/
function activateUpdating(activating){
   $("button.btn_activate").css("display", (activating) ? "none":"");
   $("button.btn_submit, button.btn_unactivate").css("display", (!activating) ? "none":"");
   $("form#frm input").attr("disabled", !activating);
}

/** 
* Handle the event on change of the select "set-active" 
*/
function loadClassesList(event){
    let status = document.getElementById("set-active").value;
    let pageContextPath = $("meta[name=pageContextPath]").attr("content");
    let usingTeacherToken = $("meta[name=usingTeacherToken]").attr("content");
    fetch( pageContextPath +"/loadclasseslist/"+status+".html", {
        method:"GET",
        headers: {
            'Content-Type': 'application/json',
            "Teacher-Token" : usingTeacherToken
        }
    }).then(response => response.text())
    .then(result => {
        console.log(result);
        if(result.indexOf("ERROR") != -1){
            alert(result);
        }
        let listClasses = JSON.parse(result);
        $("#find-class option").remove();
        for(let cla of listClasses){
            let newOption = $("<option></option>").attr("value", cla.ClassID)
                                .text(cla.Subject+" (Class ID: " + cla.ClassID+")");
            $("#find-class").prepend(newOption);
        };
        loadClassInfo();
    });
};

/**
* Function handle the click event on delete/restore button
*/
function deleteOrRestore(action, stCode){
    let pageContextPath = $("meta[name=pageContextPath]").attr("content");
    let usingTeacherToken = $("meta[name=usingTeacherToken]").attr("content");
    let classID = $("#find-class").val();
    let actionPath = action + "/studentonclass" ;
    fetch(pageContextPath +"/"+actionPath +"/" + classID+".html", {
        body: stCode,
        method:"POST",
        headers: {
            'Content-Type': 'application/json',
            "Teacher-Token" : usingTeacherToken
        }
    }).then(response => response.text())
    .then(result => {
        console.log(result);
        if(result.indexOf("ERROR") != -1){
            alert(result);
        }
    });
}
//end function

/**
* Handle the event onclick of 
*/
async function loadClassInfo(event){
    activateUpdating(false);
    let classIsAchived = await loadBasicInfoOfClass();
    console.log(classIsAchived);
    loadStudentList(classIsAchived);
}

/** 
* Function load Students List
*/
function loadStudentList(classIsArchived = false){
    let pageContextPath = $("meta[name=pageContextPath]").attr("content");
    let usingTeacherToken = $("meta[name=usingTeacherToken]").attr("content");
    let classID = $("#find-class").val();
    fetch(pageContextPath +"/loadstudentsofclass/"+classID+".html",{
        method:"GET", 
        headers: {
            'Content-Type': 'application/json',
            "Teacher-Token" : usingTeacherToken,
            "classIsArchived" : classIsArchived
        }
    }).then(response => response.text())
    .then(result => {
        if(result.indexOf("ERROR") !== -1){
            alert(result);
        }
        $("table#dtBasicExample tbody").html("");
        let list = JSON.parse(result);
        for(let detailsStudent of list){
            let newRow = $("<tr></tr>").attr("data-student-code",detailsStudent["StudentCode"]);
            let newCell = $("<td></td>");
            // Add to newRow the info of "Fullname", "Gender", "Birthday", "Phone", and "Email" of a student
            newCell.html(detailsStudent["Fullname"]);
            newRow.append(newCell.clone());
            newCell.html((detailsStudent["Gender"] ===1) ? "Female" : "Male");
            newRow.append(newCell.clone());
            newCell.html(detailsStudent["Birthday"]);
            newRow.append(newCell.clone());
            newCell.html(detailsStudent["Phone"]);
            newRow.append(newCell.clone());
            newCell.html(detailsStudent["Email"]);
            newRow.append(newCell.clone());
            // Add the button for (delete / restore) on the last cell
            if(!classIsArchived){
                let lastCellDelButton = 
                    $("<button></button>").addClass("btn btn-danger").html("Delete")
                        .on("click", (event)=> {
                            $(event.target).slideToggle();
                            $(event.target.nextSibling).slideToggle();
                            deleteOrRestore("delete", detailsStudent["StudentCode"]);
                        });
                let lastCellRestoreButton = 
                    $("<button></button>").addClass("btn btn-secondary").html("Restore").css("display", "none")
                        .on("click", (event)=> {
                            $(event.target).slideToggle();
                            $(event.target.previousSibling).slideToggle();
                            deleteOrRestore("restore", detailsStudent["StudentCode"]);
                        });;
                newCell.html(lastCellDelButton);
                newCell.append(lastCellRestoreButton);
            } else {
                $("#dtBasicExample tr > th:last-child").html("Paid the Fee");
                newCell.html((detailsStudent["paidFee"] == 0) ? "Not Paid" : "Paid");
            }
            newRow.append(newCell);
            // end adding button
            $("table#dtBasicExample tbody").append(newRow);
        };
    });
}
// End Function


async function loadBasicInfoOfClass(){
    let pageContextPath = $("meta[name=pageContextPath]").attr("content");
    let usingTeacherToken = $("meta[name=usingTeacherToken]").attr("content");
    let classIsArchived = false;
    let classID = $("#find-class").val();
    await fetch(pageContextPath+ "/loadbasicinfoofclass/"+classID+".html",{
        method:"GET",
        headers: {
            'Content-Type': 'application/json',
            "Teacher-Token" : usingTeacherToken
        }
    }).then(response => response.text())
    .then(result => {
        if(result.indexOf("ERROR") !== -1){
            alert(result);
        }
        let infoOfClass = JSON.parse(result);
        $(".col-sm-4 h1 .text-break .text-success").html(infoOfClass["ClassID"]);
        $("form#frm input[name='classID']").val(infoOfClass["ClassID"]);
        $("form#frm input[name='subject']").val(infoOfClass["Subject"]);
        $("form#frm input[name='fee']").val(infoOfClass["Fee"]);
        $("form#frm input[name='remuneration']").val(infoOfClass["Remuneration"]);
        $("form#frm datalist#remunerationSuggest option").val(
                infoOfClass["ListOfStudents"].length * infoOfClass["Fee"] * 0.3
            );
//        console.log(infoOfClass["ListOfStudents"].length * infoOfClass["Fee"]);
        console.log(infoOfClass);
        $("form#frm input[name='teacherID']").val(infoOfClass["TeacherID"]);
        // Script for "Archive this class" button
        if(infoOfClass["IsArchived"]===1){
            $("button.archiveClass").html("THis class was archived").on("click", ()=>{/*do NOTHING*/});
            $("button[data-target='#modal_all_students_list']").css("display", "none");
            classIsArchived = true;
        } else {
            $("button.archiveClass").html("Archive this class")
                                .on("click", (event)=>{
                                        archiveClass(event);
                                });
            $("button[data-target='#modal_all_students_list']").css("display", "");
        }
        // End Script for "Archive this class" button
    });
    return classIsArchived;
}


function addToClassOrRestore(event, action, stCode){
    let pageContextPath = $("meta[name=pageContextPath]").attr("content");
    let usingTeacherToken = $("meta[name=usingTeacherToken]").attr("content");
    let classID= $("#find-class").val();
    let actionPath = action + "/studenttoclass" ;
    fetch(pageContextPath +"/"+actionPath +"/" + classID+".html", {
        body: stCode,
        method:"POST",
        headers: {
            'Content-Type': 'application/json',
            "Teacher-Token" : usingTeacherToken
        }
    }).then(response => response.text())
    .then(result => {
        if(result.indexOf("ERROR") != -1){
            alert(result);
        } else {
            $(event.target).slideToggle();
            $(event.target).siblings().slideToggle();
        }
        console.log(result);
    });
}


function archiveClass(event){
    let classID = $("#find-class").val();
    let pageContextPath = $("meta[name=pageContextPath]").attr("content");
    let usingTeacherToken = $("meta[name=usingTeacherToken]").attr("content");
    fetch(pageContextPath+"/createfeeforclass/"+classID+".html", {
        body: classID , method:"POST",
        headers: {
            'Content-Type': 'application/json',
            "Teacher-Token" : usingTeacherToken
        }
    }).then((response) => response.text())
    .then((result)=> {
        if (result.indexOf("ERROR") ===-1){
            alert(result);
        } else {
            loadClassInfo(event);
        }
    });
}