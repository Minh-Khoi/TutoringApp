/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.List;
import java.util.Objects;
import javax.servlet.http.HttpServletRequest;
import models.Teacher;
import models.Class;
import models.Fee;
import models.Student;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author USER
 */
@Controller
public class GoController {
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String gotoLogin(ModelMap modMap){
        modMap.put("loginTeacher", new Teacher());
        return "login";
    }
    
    /**
     * Using Token instead of teacherID to guarantee that this Request was sent by a loged in teacher
     */
    @RequestMapping(value = "/teacher_login/reload/{token}", method = RequestMethod.GET)
    public String doReloadGotoStudent(@PathVariable String token, ModelMap modMap, HttpServletRequest request){
        Teacher teacher = new Teacher().readByCol("Token", token).get(0);
        return new DoController().doLoginSubmittingHandling(teacher, modMap, request);
    }
    
    /**
     * Using Token instead of teacherID to guarantee that this Request was sent by an admin.
     * @param token
     * @param modMap
     * @param request
     */
    @RequestMapping(value = "/gototeachers/reload/{token}", method = RequestMethod.GET)
    public String gotoTeacher(@PathVariable String token, ModelMap modMap, HttpServletRequest request){        
        if(!this.testValidTeacherToken(token)){
            modMap.put("message", "Only teachers can access Teachers task page");
            return new DoController().doLoginSubmittingHandling(new Teacher(), modMap, request);
        } else {
            Teacher usingTeacher = new Teacher().readByCol("Token", token).get(0);
            modMap.put("usingTeacher", usingTeacher);
            modMap.put("teacherOnForm", new Teacher());
            modMap.put("teachersList", new Teacher().readAll());
            return "teacher_task";
        }
    }
    
    @RequestMapping(value = "/gotoclasses/reload/{token}", method = RequestMethod.GET)
    public String gotoClasses( @PathVariable(value = "token") String token, ModelMap modMap, HttpServletRequest request){        
        if(!this.testValidTeacherToken(token)){
            modMap.put("message", "Only admin can access Teachers task page");
            return new DoController().doLoginSubmittingHandling(new Teacher(), modMap, request);
        } else {
            Teacher usingTeacher = new Teacher().readByCol("Token", token).get(0);
            modMap.put("usingTeacher", usingTeacher);
            modMap.put("classOnFormUpdate", new Class());
            modMap.put("classOnFormCreate", new Class());
            modMap.put("teachersList", new Teacher().readAll());
            modMap.put("classesList", new Class().readByCol("Status", 1));
            modMap.put("allStudents", new Student().readAll());
            return "classes_task";
        }
    }
    
    @RequestMapping(value = "/gotostudents/reload/{token}", method = RequestMethod.GET)
    public String gotoStudents(@PathVariable(value = "token") String token, ModelMap modMap, HttpServletRequest request){
        List<Teacher> listTeachersDemo = new Teacher().readByCol("Token", token);
        if (listTeachersDemo.size() ==0){
            return "login";
        }
        Teacher usingTeacher = listTeachersDemo.get(0);
        return new DoController().doLoginSubmittingHandling(usingTeacher, modMap, request);
    }
    
    @RequestMapping(value = "/gotodepts/reload", method = RequestMethod.POST)
    public String gotoDepts(@ModelAttribute(value = "usingTeacherToken") String usingTeacherToken, 
                                                                    ModelMap modMap, HttpServletRequest request){
        List<Teacher> listTeachersDemo = new Teacher().readByCol("Token", usingTeacherToken);
        if (listTeachersDemo.size() ==0){
            return "login";
        }
        Teacher usingTeacher = listTeachersDemo.get(0);
        if(usingTeacher.getIsAdmin()==0){
            modMap.put("message", "Only admin can access Teachers task page");
            System.out.println(usingTeacher.getIsAdmin());
            return new DoController().doLoginSubmittingHandling(usingTeacher, modMap, request);
        } else {
            modMap.put("usingTeacher", usingTeacher);
            if( !modMap.containsKey("studentOnChecking") ){
                modMap.put("studentOnChecking", new Student());
            }
            List<Fee> feesList = new Fee().readByCol("IsPaid", 0);
            // Must convert the feesList to String before converting it to JSONArray.
            // In order to avoid the infinity loop 
            // (when the JSONArray constructor invoke the JSONObject class, and the Fee instance does too)
            JSONArray dataFeesSendToClient = new JSONArray(feesList.toString());
            for (Object datasOfFee : dataFeesSendToClient){
                if (datasOfFee instanceof JSONObject){
                    String studentCode = ((JSONObject) datasOfFee).getString("StudentCode");
                    int classID = ((JSONObject) datasOfFee).getInt("ClassID");
                    Student studentInstance = new Student().readByCode(studentCode);
                    models.Class classInstance = new models.Class().readByID(classID);
                    Teacher teacher = new Teacher().readByID(classInstance.getTeacherID());
                    if ( !Objects.isNull(studentInstance)  ){
                        ((JSONObject) datasOfFee).put("Student", new JSONObject(studentInstance.toString()) );
                        ((JSONObject) datasOfFee).put("Class", 
                                // This JSON object must be put one more property: "TeacherName"
                                new JSONObject(classInstance.toString()).put("TeacherName", teacher.getFullname()) 
                        );
                    }
                }
            }
            modMap.put("feesList", dataFeesSendToClient.toList());
            // The "dataFeesSendToClient.toList()" function will return a JSONArray with elements are JSONobject instances
            // , (not Fee instances), so they cannot be showed as a JSONString with methods toString().
            // To send a JSON string on client, we use "dataFeesSendToClient.toString()" to get a JSONString directly
            modMap.put("feesJSON", dataFeesSendToClient.toString());
            return "fee_task";
        }
    }
    
    // <editor-fold desc="PRIVATE FIELDS">
    /** 
     * all the tasks update, delete, create in this project is only available for the Teacher users. 
     * When they submit those tasks, this function will check if they a Teacher user by the their token which is sent with 
     * the request form datas
     */
    private boolean testValidTeacherToken(String token){
        List<Teacher> teachers = new Teacher().readByCol("Token", token);
//        //System.out.println(teachers.size());
        return teachers.size()>0;
    }
    
    
    /**
     * When a new Teacher instance is created. Its email must not be double with any email existing in database
     */
    private boolean checkEmailTeacherDouble(String email){
        List<Teacher> teachers = new Teacher().readByCol("Email", email);
        return teachers.size()>0;
    }
    //</editor-fold>
}
