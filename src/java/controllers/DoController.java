/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import javax.servlet.http.HttpServletRequest;
import models.Student;
import models.Teacher;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 *
 * @author USER
 */
@Controller
public class DoController {
    /**
     * Login and go to Student 's task page
     */
    @RequestMapping(value = "/teacher_login", method = RequestMethod.POST)
    public String doLoginSubmittingHandling( @ModelAttribute(value = "loginTeacher") Teacher teacher, 
                                                                     ModelMap modMap,HttpServletRequest request){      
        System.setProperty("web.dir", request.getServletContext().getRealPath(""));
        List<Teacher> teachers = new Teacher().readByCol("email", teacher.getEmail());
        if(teachers.size()>0 && teachers.get(0).getPassword().equals(teacher.getPassword())){
            Teacher teacherFromDB = teachers.get(0);
            System.out.println(teacherFromDB);
            modMap.put("usingTeacher", teacherFromDB);
            List<Student> studentsList = new Student().readAll();
            modMap.put("studentsList", studentsList);
            modMap.put("studentOnForm", new Student());
        } else{
            modMap.put("message", "Your email or password is incorrect");
            return "login";
        }
        return "student_task";
    }
    
    // <editor-fold desc="Student tasks field">
    /**
     * Get an AJAX request and to something with a Student
     */
    @RequestMapping(value = "/dochangestudent/{formAction}", method = RequestMethod.POST )
    @ResponseBody
    public String doChangeStudent(@RequestBody String jsonString, @RequestHeader(value = "Teacher-Token") String teacherToken,
                                                            @PathVariable String formAction, ModelMap modMap){
        System.out.println(jsonString);
        if (!this.testValidTeacherToken(teacherToken)){
            return "ERROR: This feature only work with the teachers, who have permission ";
        }
        JSONObject studentJSON = new JSONObject(jsonString);
        Student stud = new Student().readByCode((String) studentJSON.get("studentCode"));
        if(!Objects.isNull(stud)){
            if("update".equals(formAction)){
                // the method stud.setFullname() has changed the student code. It has a seperated updating method
                stud.setFullname(studentJSON.getString("fullname"));
                System.out.println(stud.updateFullname());
                // Then update another fields.
                stud.setBirthday(studentJSON.getString("birthday"));
                stud.setPhone(studentJSON.getString("phone"));
                stud.setEmail(studentJSON.getString("email"));
                stud.setGender(studentJSON.getInt("gender"));
                System.out.println(stud.update());
                return "The student " + stud.getFullname()+ ": " + stud.getStudentCode() +" "+ formAction+ " successfully";                
            } else if("delete".equals(formAction)) {
                stud.delete();
            } else{
                Student student = new Student((String) studentJSON.get("fullname"), (String) studentJSON.get("birthday"), 
                                                        (String) studentJSON.get("phone"),(String) studentJSON.get("email"), 
                                                                                            (int) studentJSON.get("gender"));
                student.create();
            }
        }
        return "The student " + stud.getFullname()+ ": " + stud.getStudentCode()+" "+ formAction + " failed";
    }
    
    @RequestMapping(value = "/docreatestudent", method = RequestMethod.POST)
    public String doCreateStudent(@ModelAttribute(value = "studentOnForm") Student studentOnForm, 
                                                @ModelAttribute("teacherToken") String teacherToken,
                                                            ModelMap modMap, HttpServletRequest request){
        List<Teacher> teachers = new Teacher().readByCol("Token", teacherToken);
        Teacher usingTeacher = teachers.get(0);
        if(teachers.size()==0){
            modMap.put("message", "ERROR: This feature only work with the teachers, who have permission");
            return this.doLoginSubmittingHandling(usingTeacher, modMap,request);
        } else {
            studentOnForm.setJoinTime(String.valueOf(new Date().getTime()));
            System.out.println(studentOnForm.create());
        }
        return this.doLoginSubmittingHandling(usingTeacher, modMap,request);
    }
    //</editor-fold>
    
    //</editor-fold desc="Teachers tasks field">
    @RequestMapping(value = "/docreateteacher", method=RequestMethod.POST)
    public String doCreateTeacher(@ModelAttribute(value = "teacherOnForm") Teacher teacherOnForm, 
                                        @ModelAttribute(value = "usingTeacherToken") String usingTeacherToken,
                                                                    ModelMap modMap , HttpServletRequest request){
        List<Teacher> teachers = new Teacher().readByCol("Token", usingTeacherToken);
        Teacher usingTeacher = teachers.get(0);
        if(teachers.size()==0){
            modMap.put("message", "ERROR: This feature only work with the teachers who is admin, who have permission");
            return this.doLoginSubmittingHandling(usingTeacher, modMap,request);
        } else {
            modMap.put("usingTeacher", usingTeacher);
            if(this.checkEmailTeacherDouble(usingTeacherToken)){
                modMap.put("mesage", "This email has been used by another teacher");
            } else {
                teacherOnForm.setPassword(teacherOnForm.getFullname());
                System.out.println(teacherOnForm.create());
            }
        }
        return new GoController().gotoTeacher(usingTeacher.getToken(), modMap, request);
    }
    
    @RequestMapping(value = "/dochangeteacher/{formAction}", method = RequestMethod.POST)
    @ResponseBody
    public String doChangeTeacher(@RequestBody String jsonStr , @PathVariable(value = "formAction") String formAction,
                                                        @RequestHeader(value = "Teacher-Token") String usingTeacherToken,
                                                                                ModelMap modMap, HttpServletRequest request){
        JSONObject jsonObj = new JSONObject(jsonStr);
        System.out.println(jsonStr);
        if (!this.testValidTeacherToken(usingTeacherToken)){
            return "ERROR: This feature only work with the teachers, who have permission ";
        } 
        Teacher teacher = new Teacher().readByID(jsonObj.getInt("teacherID"));
        if(!Objects.isNull(teacher)){
            if(formAction.equals("update")){
                teacher.setFullname(jsonObj.getString("fullname"));
                teacher.setSpecialize(jsonObj.getString("specialize"));
                teacher.setPhone(jsonObj.getString("phone"));
                teacher.setEmail(jsonObj.getString("email"));
                System.out.println(teacher.update());
            } else if(formAction.equals("delete")) {
                List<models.Class> listClassOfThisTeacher = new models.Class().readByCol("TeacherID", teacher.getTeacherID());
                System.out.println(listClassOfThisTeacher); System.out.println("mrrt");
                if(listClassOfThisTeacher.size()==0){
//                    teacher.delete();
                } else{
                    List<Integer> listClassIDofTeacher = new ArrayList<>();
                    for(models.Class cla : listClassOfThisTeacher){
                        listClassIDofTeacher.add(cla.getClassID());
                    }
                    return "ERROR: the Teacher "+teacher.getFullname() + ", id: "+ teacher.getTeacherID() 
                            + " is in charged with these classes: " + listClassIDofTeacher.toString();
                }
            }            
            return "the Teacher "+teacher.getFullname() + ", id: "+ teacher.getTeacherID() + " " + formAction + " successfully";
        }
        return "the Teacher "+teacher.getFullname() + ", id: "+ teacher.getTeacherID() + " " + formAction + " failed";
    }
    //</editor-fold>
    
    //<editor-fold desc="Class Tasks Field">
    @RequestMapping(value = "/loadclasseslist/{status}", method = RequestMethod.GET )
    @ResponseBody
    public String doLoadClassList(@PathVariable(value = "status") int status, 
                                    @RequestHeader(value = "Teacher-Token") String teacherToken , HttpServletRequest request){
        Teacher teacher = new Teacher().readByCol("Token", teacherToken).get(0);
        if(Objects.isNull(teacher)){
            return "ERROR: This feature only work with the teachers who is admin, who have permission";
        } else {
            List classes = new models.Class().readByCol("Status", status);
            System.out.println(new JSONArray(classes.toString()).toString(4));
            return classes.toString();
        }
    }
    
    @RequestMapping(value = "/loadbasicinfoofclass/{classID}", method = RequestMethod.GET)
    @ResponseBody
    public String doLoadBasicInfoOfClass( @PathVariable(value = "classID") int classID,
                                            @RequestHeader(value = "Teacher-Token") String usingTeacherToken, 
                                            HttpServletRequest request){
        Teacher teacher = new Teacher().readByCol("Token", usingTeacherToken).get(0);
        if(Objects.isNull(teacher)){
            return "ERROR: This feature only work with the teachers who is admin, who have permission";
        } else {
            models.Class classInstance = new models.Class().readByID(classID);
            return classInstance.toString();
        }
    }
    
    @RequestMapping(value = "/loadstudentsofclass/{classID}", method = RequestMethod.GET)
    @ResponseBody
    public String doLoadStudentsOfClass( @PathVariable(value = "classID") int classID,
                                            @RequestHeader(value = "Teacher-Token") String usingTeacherToken, 
                                            HttpServletRequest request){
        Teacher teacher = new Teacher().readByCol("Token", usingTeacherToken).get(0);
        if(Objects.isNull(teacher)){
            return "ERROR: This feature only work with the teachers who is admin, who have permission";
        } else {
            models.Class classInstance = new models.Class().readByID(classID);
            List<String> listOfStudentCodes = classInstance.getListOfStudentCodes();
            List<Student> returnedList = new ArrayList<>();
            for(String code : listOfStudentCodes){
                Student stu = new Student().readByCode(code);
                returnedList.add(stu);
            }
            System.out.println(returnedList.toString());
            return returnedList.toString();
        }
    }
    
    @RequestMapping(value = {"/{action}/studentonclass/{classID}"}, method = RequestMethod.POST)
    @ResponseBody
    public String deleteOrRestoreStudentOnClass(@PathVariable(value = "action") String action,
                                                    @PathVariable(value = "classID") int classID,
                                                    @RequestHeader(value = "Teacher-Token") String usingTeacherToken,
                                                    @RequestBody String studentCode, HttpServletRequest request){
        Teacher teacher = new Teacher().readByCol("Token", usingTeacherToken).get(0);
        if(Objects.isNull(teacher) ){
            return "ERROR: This feature only work with the teachers who is admin, who have permission";
        } else {
            models.Class classIns = new models.Class().readByID(classID);
            if(teacher.getIsAdmin()==1 || classIns.getTeacherID() == teacher.getTeacherID()){
                List studentsOnClass = new ArrayList<>(classIns.getListOfStudentCodes());
                if(action.equals("delete")){
                    if(studentsOnClass.contains(studentCode)){
                        studentsOnClass.remove(studentsOnClass.indexOf(studentCode));
                        classIns.setListOfStudentCodes(studentsOnClass);
                        System.out.println(classIns.update());
                    }
                } else {
                    if(!studentsOnClass.contains(studentCode)){
                        studentsOnClass.add(studentCode);
                        classIns.setListOfStudentCodes(studentsOnClass);
                        classIns.update();
                    }
                }
            } else {
                return "ERROR: This feature only work with the teachers who is admin, or who is in charged with this class";
            }
        }
        return "Update successfully";
    }
    
    @RequestMapping(value = {"/{action}/studenttoclass/{classID}"}, method = RequestMethod.POST)
    @ResponseBody
    public String addOrRestoreStudentOnClass(@PathVariable(value = "action") String action,
                                                    @PathVariable(value = "classID") int classID,
                                                    @RequestHeader(value = "Teacher-Token") String usingTeacherToken,
                                                    @RequestBody String studentCode, HttpServletRequest request){
        Teacher teacher = new Teacher().readByCol("Token", usingTeacherToken).get(0);
        if(Objects.isNull(teacher) ){
            return "ERROR: This feature only work with the teachers who is admin, who have permission";
        } else {
            models.Class classIns = new models.Class().readByID(classID);
            if(teacher.getIsAdmin()==1 || classIns.getTeacherID() == teacher.getTeacherID()){
                List studentsOnClass = new ArrayList<>(classIns.getListOfStudentCodes());
//                System.out.println(studentsOnClass.size() ); System.out.println("dbrr");
                if(!studentsOnClass.contains(studentCode)){
                    if(action.equals("add")){
                        studentsOnClass.add(studentCode);
                        classIns.setListOfStudentCodes(studentsOnClass);
                        classIns.update();
                    } else {
                        studentsOnClass.remove(studentsOnClass.indexOf(studentCode));
                        classIns.setListOfStudentCodes(studentsOnClass);
                        classIns.update();
                    }
                } else {
                    return "ERROR: This students has joined this class";
                }
            } else {
                return "ERROR: This feature only work with the teachers who is admin, or who is in charged with this class";
            }
        }
        return "Update successfully";
    }
    
    @RequestMapping(value = "/docreateclass", method = RequestMethod.POST)
    public String doCreateClass(@ModelAttribute(value = "classOnFormCreate") models.Class createdClass,
                                            @ModelAttribute(value = "usingTeacherToken") String usingTeacherToken,
                                            ModelMap modMap, HttpServletRequest request){
        Teacher teacher = new Teacher().readByCol("Token", usingTeacherToken).get(0);
//        System.out.println(createdClass + "---" + createdClass.getTeacherID());
        if(Objects.isNull(teacher) ||  teacher.getIsAdmin()!=1  ){
            modMap.put("message", "ERROR: This feature only work with the teachers who is admin, who have permission") ;
        } else {
            if(createdClass.create() == 0){
                modMap.put("message", "ERROR: Class creating failed!! Check the class info again");
            } else {
                int lastClassIDinDatabase = new models.Class().findTheLastIdentityID();
                modMap.put("classChoosen", new models.Class().readByID(lastClassIDinDatabase));
            }
        }
        return new GoController().gotoClasses(usingTeacherToken, modMap, request);
    }
    
    @RequestMapping(value = "/doupdateclass", method=RequestMethod.POST)
    public String doUpdateClass(@ModelAttribute(value = "classOnFormCreate") models.Class updatedClass,
                                    @ModelAttribute(value = "usingTeacherToken") String usingTeacherToken,
                                    ModelMap modMap, HttpServletRequest request){
        Teacher teacher = new Teacher().readByCol("Token", usingTeacherToken).get(0);
        if(Objects.isNull(teacher) || teacher.getIsAdmin()!=1 && teacher.getTeacherID() != updatedClass.getTeacherID() ){
            modMap.put("message", "ERROR: This feature only work with the teachers who is admin, who have permission") ;
        } else {
            System.out.println(updatedClass);
            if(updatedClass.update()== 0){
                modMap.put("message", "ERROR: Class update failed!! Check the class info again");
            } else {
                int currentClassID = updatedClass.getClassID();
                modMap.put("classChoosen", new models.Class().readByID(currentClassID));
            }
        }
        return new GoController().gotoClasses(usingTeacherToken, modMap, request);        
    }
    
    
    @RequestMapping(value = "/dodeleteclass", method=RequestMethod.POST)
    public String doDeleteClass(@ModelAttribute(value = "classID") int classID,
                                    @ModelAttribute(value = "usingTeacherToken") String usingTeacherToken,
                                    ModelMap modMap, HttpServletRequest request){
        Teacher teacher = new Teacher().readByCol("Token", usingTeacherToken).get(0);
        models.Class deletedClass = new models.Class().readByID(classID);
        if(Objects.isNull(teacher) || teacher.getIsAdmin()!=1 && teacher.getTeacherID() != deletedClass.getTeacherID() ){
            modMap.put("message", "ERROR: This feature only work with the teachers who is admin, who have permission") ;
        } else {
            System.out.println(deletedClass);
            if(deletedClass.delete()== 0){
                modMap.put("message", "ERROR: Class delete failed!! Check the class info again");
            } 
        }
        return new GoController().gotoClasses(usingTeacherToken, modMap, request);        
    }
    //</editor-fold>
        
    // <editor-fold desc="PRIVATE FIELDS">
    /** 
     * all the tasks update, delete, create in this project is only available for the Teacher users. 
     * When they submit those tasks, this function will check if they a Teacher user by the their token which is sent with 
     * the request form datas
     */
    private boolean testValidTeacherToken(String token){
        List<Teacher> teachers = new Teacher().readByCol("Token", token);
//        System.out.println(teachers.size());
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