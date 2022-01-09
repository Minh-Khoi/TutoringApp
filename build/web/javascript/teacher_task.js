/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


console.log("teacher_task.js say hello");

function doSubmitForm(ev){
    if ($(".btn_reset").css("display") == "none"){
        return;
    }
    ev.preventDefault();
    let pageContextPath = $("meta[name=pageContextPath]").attr("content");
    let usingTeacherToken = $("meta[name=usingTeacherToken]").attr("content");
    let form = document.getElementById("frm");
    let formDatas = new FormData(form);
    formDatas.append("teacherID", document.querySelector(".col-sm-4 h1 > span >span").innerHTML );
    let formStudent = Object.fromEntries(formDatas.entries());
    let formAction = $("#frm .btn_submit").text();
    fetch(pageContextPath + "/dochangeteacher/"+formAction+".html", {
        body : JSON.stringify(formStudent), method:"POST",
        headers: {
            'Content-Type': 'application/json',
            "Teacher-Token" : usingTeacherToken
        }
    }).then(resolve => resolve.text())
    .then(result => {
        if(result.indexOf("ERROR") != -1){
            alert(result);
        }
        console.log(result);
    })
}

function onClicked(teacherIndex, formAction){
    let teachersList = JSON.parse($("span[name=teachersList]").html());
    console.log(teachersList);
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