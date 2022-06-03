/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


console.log("fee_task.js say hello");
loadStudentOnChecking();

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
    $("form#frm input, form#frm select").attr("disabled",true);
    $("div#cls input, form#frm select").attr("disabled",true);
    if (feeIndex !== null){
        let feesList = JSON.parse($("span[name=feesList]").html());
        // set info showed on Student Info Fields
        let studentOnChecking = feesList[feeIndex]["Student"];
        $("form#frm input[name='fullname']").val(studentOnChecking["Fullname"]);
        $("form#frm input[name='birthday']").val(studentOnChecking["Birthday"]);
        $("form#frm input[name='phone']").val(studentOnChecking["Phone"]);
        $("form#frm input[name='email']").val(studentOnChecking["Email"]);
        $("form#frm select[name='gender']").val(studentOnChecking["Gender"]);
        // set info showed on Class Info Fields
        let classOnChecking = feesList[feeIndex]["Class"];
        $("div#cls input#classTeacherName").val(classOnChecking["TeacherName"]);
        $("div#cls input#classSubject").val(classOnChecking["Subject"]);
        $("div#cls input#classFeeCost").val(classOnChecking["Fee"]);
    } else  {
        let studentCheckedOnLoadStr = $("span[name='studentOnChecking']").html();
        studentOnChecking = JSON.parse(studentCheckedOnLoadStr);
        // If the JSON parsed object have no property name "StudentCode", the studentOnChecking is 'undefined'
        // It also meaning that "!studentOnChecking" IS TRUE
        if ( !studentOnChecking.hasOwnProperty("StudentCode") ){
            // do nothing
        } 
        //  If the JSON parsed object CONTAINS property name "StudentCode", so the studentOnChecking is a JSON OBJECT
        else {
            $("#dtBasicExample").DataTable().search(studentOnChecking["StudentCode"]).draw();
            $("form#frm input[name='fullname']").val(studentOnChecking["Fullname"]);
            $("form#frm input[name='birthday']").val(studentOnChecking["Birthday"]);
            $("form#frm input[name='phone']").val(studentOnChecking["Phone"]);
            $("form#frm select[name='email']").val(studentOnChecking["Email"]);
            $("form#frm select[name='gender']").val(studentOnChecking["Gender"]);
        }
    }
    
}
