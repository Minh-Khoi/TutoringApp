/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import datas.Datasource;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.JSONObject;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

/**
 *
 * @author USER
 */
public class Student extends JdbcDaoSupport{
    //<editor-fold desc="DTO field">
    private String studentCode, fullname, birthday, phone, email, joinTime;
    private int gender;
    
    public Student(){
        this.setDataSource(new Datasource());
    }
    
    public Student( String fullname, String birthday, String phone, String email, int gender) {
        this.fullname = fullname;
        this.birthday = birthday;
        this.phone = phone;
        this.email = email;
        this.gender = gender;
//        this.joinTime = null;

        this.setDataSource(new Datasource());
    }
    
    public String getStudentCode() {
        return studentCode;
    }

    public void setStudentCode(String studentCode) {
        this.studentCode = studentCode;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        try {
            if (!Objects.isNull(this.joinTime)){
                this.studentCode = new String(Base64.getEncoder().encode((fullname + joinTime ).getBytes("UTF-8")));                
            }
        } catch (UnsupportedEncodingException ex) {
            this.studentCode = null;
            ex.printStackTrace();
        }
        this.fullname = fullname;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getJoinTime() {
        return joinTime;
    }

    public void setJoinTime(String joinTime) {
        try {
            this.studentCode = new String(Base64.getEncoder().encode((this.fullname + joinTime ).getBytes("UTF-8")));
        } catch (UnsupportedEncodingException ex) {
            this.studentCode = null;
            ex.printStackTrace();
        }
        this.joinTime = joinTime;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }
    
    public List<Fee> getFeesList(){
        List<Fee> fees = new Fee().readByCol("StudentCode", this.getStudentCode());
        return fees;
    }
    
    
    @Override
    public String toString() {
        JSONObject jsonObj = new JSONObject();
        jsonObj.put("StudentCode", this.getStudentCode());
        jsonObj.put("Fullname", this.getFullname());
        jsonObj.put("Birthday", this.getBirthday());
        jsonObj.put("Phone", this.getPhone());
        jsonObj.put("Email", this.getEmail());
        jsonObj.put("JoinTime", this.getJoinTime());
        jsonObj.put("Gender", this.getGender());
        return jsonObj.toString(4);
    }
    // </editor-fold>
    
    //<editor-fold desc="DAO field">
    private static final String SQL_CREATE="Insert into Students ( [StudentCode]\n" +
                                                        "           ,[Fullname]\n" +
                                                        "           ,[Birthday]\n" +
                                                        "           ,[Phone]\n" +
                                                        "           ,[Email]\n" +
                                                        "           ,[JoinTime]\n" +
                                                        "           ,[Gender]  ) "
                                        + "values (':StudentCode', ':Fullname', ':Birthday', ':Phone', ':Email', ':JoinTime', "
                                        + " ':Gender' )",
                        SQL_READALL = "Select * from Students",
                        SQL_READ_BY_COL = "Select * from Students where [:col] = ':value' ",
                        SQL_READ_BY_CODE = "Select * from Students where [StudentCode ]= ':StudentCode' ",
                        SQL_UPDATE = "Update Students set "
                                        + "[StudentCode]=':StudentCode',"
                                        + "[Birthday]=':Birthday',"
                                        + "[Email]=':Email',"
                                        + "[Phone]=':Phone',"
                                        + "[JoinTime]=':JoinTime', "
                                        + "[Gender]=':Gender'"
                                        + " where [StudentCode]=':StudentCode' ",
                        SQL_UPDATE_FULLNAME = "Update Students set "
                                                    + "[StudentCode]=':StudentCode',"
                                                    + "[Fullname]=':Fullname' "
                                                    + " where [Email]=':Email' and "
                                                    + "[Phone]=':Phone' and "
                                                    + "[JoinTime]=':JoinTime' and "
                                                    + "[Gender]=':Gender' ",
                        SQL_DELETE = "Delete from Students where [StudentCode]=':StudentCode'";    
    
    /**
     * Before using the create function, the Student instance must set the value of JOINTIME. Because this property is necessary
     * to create the value of "studentCode", BUT the constructor and the of the Student class don't set this value,
     * @return
     * @throws NullPointerException 
     */
    public int create() throws NullPointerException{
        this.setJoinTime(new Date().getTime()+"");
        String SQL = SQL_CREATE.replace(":StudentCode", this.getStudentCode())
                                .replace(":Fullname", this.getFullname())
                                .replace(":Birthday", this.getBirthday())
                                .replace(":Phone", this.getPhone())
                                .replace(":Email", this.getEmail())
                                .replace(":JoinTime", this.getJoinTime())
                                .replace(":Gender", this.getGender()+"")
                ;
        return this.getJdbcTemplate().update(SQL);
    }
    
    /**
     * WARNING: You mustn't change the Fullname concurrently with the others fields. 
     * @return int successfully (1) or failed (0)
     * @throws NullPointerException 
     */
    public int update() throws NullPointerException{
        String SQL = SQL_UPDATE.replace(":StudentCode", this.getStudentCode())
                                .replace(":Birthday", this.getBirthday())
                                .replace(":Phone", this.getPhone())
                                .replace(":Email", this.getEmail())
                                .replace(":JoinTime", this.getJoinTime())
                                .replace(":Gender", this.getGender()+"")
                ;
        return this.getJdbcTemplate().update(SQL);
    }
    
    public int updateFullname() throws NullPointerException{
        String SQL = SQL_UPDATE_FULLNAME.replace(":StudentCode", this.getStudentCode())
                                        .replace(":Fullname", this.getFullname())
                                        .replace(":Birthday", this.getBirthday())
                                        .replace(":Phone", this.getPhone())
                                        .replace(":Email", this.getEmail())
                                        .replace(":JoinTime", this.getJoinTime())
                                        .replace(":Gender", this.getGender()+"")
                ;
//        System.out.println(SQL);
        return this.getJdbcTemplate().update(SQL);
    }
    
    public int delete(){
        String SQL = SQL_DELETE.replace(":StudentCode", this.getStudentCode()) ;
        return this.getJdbcTemplate().update(SQL);
    }
    
    public List<Student> readAll(){
        List<Student> returnedList = new ArrayList<>();
        List<Map<String,Object>> list = this.getJdbcTemplate().queryForList(SQL_READALL);
        for(Map map : list){
            Student stu = new Student((String) map.get("Fullname"), (String) map.get("Birthday"), 
                                            (String) map.get("Phone"),(String) map.get("Email"), (int) map.get("Gender"));
            stu.setJoinTime((String) map.get("JoinTime")); 
            stu.setStudentCode((String) map.get("StudentCode"));
            returnedList.add(stu);
        }
        return returnedList;
    }
    
    public Student readByCode(String code){
        String SQL = SQL_READ_BY_CODE.replace(":StudentCode", code);
        List<Student> returnedList = new ArrayList<>();
        List<Map<String,Object>> list = this.getJdbcTemplate().queryForList(SQL);
        for(Map map : list){
            Student stu = new Student((String) map.get("Fullname"), (String) map.get("Birthday"), 
                                            (String) map.get("Phone"),(String) map.get("Email"), (int) map.get("Gender"));
            stu.setJoinTime((String) map.get("JoinTime"));
            stu.setStudentCode((String) map.get("StudentCode"));
            returnedList.add(stu);
        }
        return (returnedList.isEmpty()) ? null : returnedList.get(0);
    }
    
    
    public List<Student> readByCol(String col, Object value){
        String SQL = SQL_READ_BY_COL.replace(":col", col).replace(":value", String.valueOf(value));
        List<Student> returnedList = new ArrayList<>();
        List<Map<String,Object>> list = this.getJdbcTemplate().queryForList(SQL);
        for(Map map : list){
            Student stu = new Student((String) map.get("Fullname"), (String) map.get("Birthday"), 
                                            (String) map.get("Phone"),(String) map.get("Email"), (int) map.get("Gender"));
            stu.setJoinTime((String) map.get("JoinTime"));
            stu.setStudentCode((String) map.get("StudentCode"));
            returnedList.add(stu);
        }
        return returnedList;
    }
    
    // </editor-fold>



}
