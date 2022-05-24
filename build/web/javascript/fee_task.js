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


function loadStudentOnChecking(feeIndex = null){
    let studentOnChecking, existingStudentOnChecking, dataStudentChecking;
    let studentCheckedOnLoadStr = $("span[name='studentOnChecking']").html();
    if (feeIndex != null){
        existingStudentOnChecking = true;
        let feesList = JSON.parse($("span[name=feesList]").html());
        studentOnChecking = feesList[feeIndex]["Student"];
        $("form#frm input[name='fullname']").val(studentOnChecking["Fullname"]);
        $("form#frm input[name='birthday']").val(studentOnChecking["Birthday"]);
        $("form#frm input[name='phone']").val(studentOnChecking["Phone"]);
        $("form#frm input[name='email']").val(studentOnChecking["Email"]);
    } else  {
        studentOnChecking = JSON.parse(studentCheckedOnLoadStr)["StudentCode"];
        if (existingStudentOnChecking !== false){
            $(".col-sm-4 h1 > span > span").html(studentOnChecking["StudentCode"]);
            $("#dtBasicExample").DataTable().search(studentOnChecking["StudentCode"]).draw();
            $("form#frm input[name='fullname']").val(studentOnChecking["Fullname"]);
            $("form#frm input[name='birthday']").val(studentOnChecking["Birthday"]);
            $("form#frm input[name='phone']").val(studentOnChecking["Phone"]);
            $("form#frm input[name='email']").val(studentOnChecking["Email"]);
        }
    }
    
}