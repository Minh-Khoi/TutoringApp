/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import datas.Datasource;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

/**
 *
 * @author USER
 */
public class Teacher extends JdbcDaoSupport{
    // <editor-fold desc="DTO field">
    private int teacherID;
    private String fullname, phone, specialize, email, token, password;
    
    /**
     * This function constructor create an empty Teacher instance
     */
    public Teacher(){
        this.setDataSource(new Datasource());
    }

    public Teacher(int teacherID, String fullname, String phone, String specialize, String email,  String password) {
        this.teacherID = teacherID;
        this.fullname = fullname;
        this.phone = phone;
        this.specialize = specialize;
        this.email = email;
        this.password = password;
        try {
            this.token = new String(Base64.getEncoder().encode((email + password).getBytes("UTF-8")));
        } catch (UnsupportedEncodingException ex) {
            this.token = null;
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        this.setDataSource(new Datasource());
    }
    
    public int getIsAdmin(){
//        System.out.println(System.getProperty("user.dir"));
        try {
            // Read data (raw String) from file .json
            File myObj = new File(System.getProperty("web.dir")+"/dataJSON/list.json");
            Scanner myReader = new Scanner(myObj);
            String rawString = "";
            while (myReader.hasNextLine()) {
                String data = myReader.nextLine();
                rawString += (data);
            }
            // Find the Teacher ID
            JSONObject jsonObject = new JSONObject(rawString);
            JSONArray jsonArrayAdmins = jsonObject.getJSONArray("admins");
            for(int i =0; i<jsonArrayAdmins.length() ; i++){
                if(jsonArrayAdmins.get(i).equals(this.getTeacherID())) {
                    return 1;
                }
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int getTeacherID() {
        return teacherID;
    }

    public void setTeacherID(int teacherID) {
        this.teacherID = teacherID;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getSpecialize() {
        return specialize;
    }

    public void setSpecialize(String specialize) {
        this.specialize = specialize;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        try {
            this.email = email;
            this.token = new String(Base64.getEncoder().encode((email + this.password).getBytes("UTF-8")));
        } catch (UnsupportedEncodingException ex) {
//            this.token = null;
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        try {
            this.password = password;
            this.token = new String(Base64.getEncoder().encode((this.email + password).getBytes("UTF-8")));
        } catch (UnsupportedEncodingException ex) {
//            this.token = null;
            Logger.getLogger(Teacher.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String getToken() {
        return token;
    }

    @Override
    public String toString() {
        JSONObject jsonObj = new JSONObject();
        jsonObj.put("TeacherID", this.getTeacherID());
        jsonObj.put("Fullname", this.getFullname());
        jsonObj.put("Phone", this.getPhone());
        jsonObj.put("Specialize", this.getSpecialize());
        jsonObj.put("Email", this.getEmail());
        jsonObj.put("IsAdmin", this.getIsAdmin());
        jsonObj.put("Token", this.getToken());
        return jsonObj.toString(4);
    }
    
    
    // </editor-fold>
    
    
    // <editor-fold desc="DAO field">
    private static final String SQL_CREATE="Insert into Teachers ( [Fullname]\n" +
                                                    "           ,[Phone]\n" +
                                                    "           ,[Specialize]\n" +
                                                    "           ,[Email]\n" +
                                                    "           ,[Token]\n" +
                                                    "           ,[Password]) "
                                        + "values (':Fullname', ':Phone', ':Specialize', ':Email', ':Token', ':Password')",
                        SQL_READALL = "Select * from Teachers",
                        SQL_READ_BY_COL = "Select * from Teachers where :col = ':value' ",
                        SQL_READ_BY_ID = "Select * from Teachers where TeacherID = ':TeacherID'",
                        SQL_UPDATE = "Update Teachers set "
                                        + "Fullname=':Fullname',"
                                        + "Phone=':Phone',"
                                        + "Specialize=':Specialize',"
                                        + "Email=':Email',"
                                        + "Token=':Token',"
                                        + "Password=':Password'"
                                        + " where TeacherID=':TeacherID'",
                        SQL_DELETE = "Delete from Teachers where TeacherID=':TeacherID'";    
    
    
    public int create(){
        String SQL = SQL_CREATE.replace(":Fullname", this.getFullname())
                                .replace(":Phone", this.getPhone())
                                .replace(":Specialize", this.getSpecialize())
                                .replace(":Email", this.getEmail())
                                .replace(":Token", this.getToken())
                                .replace(":Password", this.getPassword())
                ;
        int created = this.getJdbcTemplate().update(SQL);
        return created;
    }
    
    public int update(){
        String SQL = SQL_UPDATE.replace(":Fullname", this.getFullname())
                                .replace(":Phone", this.getPhone())
                                .replace(":Specialize", this.getSpecialize())
                                .replace(":Email", this.getEmail())
                                .replace(":Token", this.getToken())
                                .replace(":Password", this.getPassword())
                                .replace(":TeacherID", this.getTeacherID()+"")
                ;
        int updated = this.getJdbcTemplate().update(SQL);
        return updated;    
    }

    public int delete(){
        String SQL = SQL_DELETE.replace(":TeacherID", this.getTeacherID()+"") ;
        int deleted = this.getJdbcTemplate().update(SQL);
        return deleted;    
    }    
    
    public  List<Teacher> readAll(){
        List<Map<String, Object>> list =this.getJdbcTemplate().queryForList(SQL_READALL);
        List<Teacher> returnedList =  new ArrayList<>();
        for(Map map : list){
            Teacher teacher = new Teacher((int) map.get("TeacherID"), (String) map.get("Fullname"), (String) map.get("Phone"), 
                                            (String) map.get("Specialize"), (String) map.get("Email"), (String) map.get("Password"));
            returnedList.add(teacher);
        }
        return returnedList;
    }
        
    public  Teacher readByID(int id){
        String SQL = SQL_READ_BY_ID.replace(":TeacherID", id+"");
        List<Map<String, Object>> list =this.getJdbcTemplate().queryForList(SQL);
        List<Teacher> returnedList =  new ArrayList<>();
        for(Map map : list){
            Teacher teacher = new Teacher((int) map.get("TeacherID"), (String) map.get("Fullname"), (String) map.get("Phone"), 
                                            (String) map.get("Specialize"), (String) map.get("Email"), (String) map.get("Password"));
            returnedList.add(teacher);
        }
        return (returnedList.isEmpty()) ? null : returnedList.get(0);
    }

    public List<Teacher> readByCol(String col, Object value){
        String SQL = SQL_READ_BY_COL.replace(":col", col).replace(":value", String.valueOf(value));
        List<Map<String, Object>> list =this.getJdbcTemplate().queryForList(SQL);
        List<Teacher> returnedList =  new ArrayList<>();
        for(Map map : list){
            Teacher teacher = new Teacher((int) map.get("TeacherID"), (String) map.get("Fullname"), (String) map.get("Phone"), 
                                            (String) map.get("Specialize"), (String) map.get("Email"), (String) map.get("Password"));
            returnedList.add(teacher);
        }
        return returnedList;
    }        
    
    public int findTheLastIdentityID(){
        String SQL = "SELECT IDENT_CURRENT ('Teachers') as 'lastID' ";
        List<Map<String,Object>> results = this.getJdbcTemplate().queryForList(SQL);
        return ((BigDecimal)results.get(0).get("lastID")).intValue();
    }
    // </editor-fold>
    
}
