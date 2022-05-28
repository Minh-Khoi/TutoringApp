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
    let studentOnChecking, dataStudentChecking;
    if (feeIndex !== null){
        let feesList = JSON.parse($("span[name=feesList]").html());
        studentOnChecking = feesList[feeIndex]["Student"];
//        $("#dtBasicExample").DataTable().search(studentOnChecking["StudentCode"]).draw();
        $("form#frm input[name='fullname']").val(studentOnChecking["Fullname"]);
        $("form#frm input[name='birthday']").val(studentOnChecking["Birthday"]);
        $("form#frm input[name='phone']").val(studentOnChecking["Phone"]);
        $("form#frm input[name='email']").val(studentOnChecking["Email"]);
        $("form#frm select[name='gender']").val(studentOnChecking["Gender"]);
    } else  {
        let studentCheckedOnLoadStr = $("span[name='studentOnChecking']").html();
        studentOnChecking = JSON.parse(studentCheckedOnLoadStr);
        // If the JSON parsed object have no property name "StudentCode", the studentOnChecking is 'undefined'
        // It also meaning that "!studentOnChecking" IS TRUE
        if ( !studentOnChecking ){
            // do nothing
        } 
        //  If the JSON parsed object CONTAINS property name "StudentCode", so the studentOnChecking is a JSON OBJECT
        else {
//            console.log($("#dtBasicExample"));
            $(".col-sm-4 h1 > span > span").html(studentOnChecking["StudentCode"]);
//            $("#dtBasicExample_filter input[type='search']").val(studentOnChecking["StudentCode"]);
            $("#dtBasicExample").DataTable().search(studentOnChecking["StudentCode"]).draw();
//            searchField.search(studentOnChecking["StudentCode"]).draw();
            $("form#frm input[name='fullname']").val(studentOnChecking["Fullname"]);
            $("form#frm input[name='birthday']").val(studentOnChecking["Birthday"]);
            $("form#frm input[name='phone']").val(studentOnChecking["Phone"]);
            $("form#frm select[name='email']").val(studentOnChecking["Email"]);
        }
    }
    
}
