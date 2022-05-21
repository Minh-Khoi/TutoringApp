/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


console.log("fee_task.js say hello");

function doSubmitForm(ev){
    let pageContextPath = document.querySelector("meta[name=pageContextPath]").content;
    let usingTeacherToken = document.querySelector("meta[name=usingTeacherToken]").content;
//    console.log("doSubmitForm is invoked \t"+ pageContextPath + "--------" + usingTeacherToken);
    if ($(".btn_reset").css("display") == "none"){
        return;
    }
    ev.preventDefault();
    let form = document.getElementById("frm");
    let formDatas = new FormData(form);
    formDatas.append("studentCode", document.querySelector(".col-sm-4 h1 > span >span").innerHTML );
    let formStudent = Object.fromEntries(formDatas.entries());
    let formAction = $("#frm .btn_submit").text();
    fetch(pageContextPath + "/dochangestudent/"+formAction+".html", {
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
    });
}


function onClicked(studentIndex, formAction){
    let studentsList = JSON.parse($("span[name=studentsList]").html());
//    console.log(studentsList);
    let studentOnForm = studentsList[studentIndex];
    // Border the form and display the reset button
    $("#frm").parent().addClass("border pl-4 pb-3 pt-3");
    $("#frm .btn_reset").css("display", "block");
    // Render values for input tags
    document.querySelector(".col-sm-4 h1 > span > span").innerHTML =  studentOnForm["StudentCode"];
    document.querySelector("form#frm input[name='fullname']").value = studentOnForm["Fullname"];
    document.querySelector("form#frm input[name='birthday']").value = studentOnForm["Birthday"];
    document.querySelector("form#frm input[name='phone']").value = studentOnForm["Phone"];
    document.querySelector("form#frm input[name='email']").value = studentOnForm["Email"];
    $("form#frm select option[selected]").removeAttr("selected");
    $("form#frm select option[value='" + studentOnForm["Gender"] +"']").attr("selected",true);
    // switch formAction
    if(formAction == "see"){
        $("form#frm input, form#frm select").attr("disabled",true);
        $("#frm").parent().addClass("border-secondary").removeClass("border-warning border-danger");
        $("form#frm button[type='submit']").html('see').attr("disabled", true)
                                .addClass("bg-secondary").removeClass("bg-danger bg-warning");
    } else if (formAction == "update"){
        $("form#frm input, form#frm select").attr("disabled",false);
        $("#frm").parent().addClass("border-warning").removeClass("border-secondary border-danger");
        $("form#frm button[type='submit']").html('update').attr("disabled", false)
                    .addClass("bg-warning").removeClass("bg-danger bg-secondary");
    } else {
        $("form#frm input, form#frm select").attr("disabled",false);
        $("#frm").parent().addClass("border-danger").removeClass("border-warning border-secondary");
        $("form#frm button[type='submit']").html('delete').attr("disabled", false)
                    .addClass("bg-danger").removeClass("bg-warning bg-secondary");
    }
}