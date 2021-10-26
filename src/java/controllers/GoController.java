/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.util.Objects;
import javax.servlet.http.HttpServletRequest;
import models.Teacher;
import models.Class;
import models.Student;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
     */
    @RequestMapping(value = "/gototeachers/reload/{token}", method = RequestMethod.GET)
    public String gotoTeacher(@PathVariable String token, ModelMap modMap, HttpServletRequest request){
        Teacher usingTeacher = new Teacher().readByCol("Token", token).get(0);
        if(usingTeacher.getIsAdmin()==0){
            modMap.put("message", "Only admin can access Teachers task page");
            return new DoController().doLoginSubmittingHandling(usingTeacher, modMap, request);
        } else {
            modMap.put("usingTeacher", usingTeacher);
            modMap.put("teacherOnForm", new Teacher());
            modMap.put("teachersList", new Teacher().readAll());
            return "teacher_task";
        }
    }
    
    @RequestMapping(value = "/gotoclasses/reload/{token}", method = RequestMethod.GET)
    public String gotoClasses( @PathVariable(value = "token") String token,
                                        ModelMap modMap, HttpServletRequest request){
        Teacher usingTeacher = new Teacher().readByCol("Token", token).get(0);
        if(usingTeacher.getIsAdmin()==0){
            modMap.put("message", "Only admin can access Teachers task page");
            return new DoController().doLoginSubmittingHandling(usingTeacher, modMap, request);
        } else {
            modMap.put("usingTeacher", usingTeacher);
            modMap.put("classOnFormUpdate", new Class());
            modMap.put("classOnFormCreate", new Class());
            modMap.put("classesList", new Class().readByCol("Status", 1));
            modMap.put("teachersList", new Teacher().readAll());
            modMap.put("allStudents", new Student().readAll());
            return "classes_task";
        }
    }
    
    @RequestMapping(value = "/gotostudents/reload/{token}", method = RequestMethod.GET)
    public String gotoStudents(@PathVariable(value = "token") String token, ModelMap modMap, HttpServletRequest request){
        Teacher usingTeacher = new Teacher().readByCol("Token", token).get(0);
        if (Objects.isNull(usingTeacher)){
            return "login";
        }
        return new DoController().doLoginSubmittingHandling(usingTeacher, modMap, request);
    }
    
//    @RequestMapping(value = )
}