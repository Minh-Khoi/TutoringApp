/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import datas.Datasource;
import java.math.BigDecimal;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

/**
 *
 * @author USER
 */
public class Class extends JdbcDaoSupport{
    // <editor-fold desc="DTO field">
    private int classID, teacherID, status; // status have three integer values: 0, 1, 2
    private String subject;
    private List<String> listOfStudentCodes;
    private double fee, remuneration;

    public Class() {
        this.setDataSource(new Datasource());
    }

    public Class(int classID, int teacherID, String subject, String stringOfStudentCodes, double fee, double remuneration) {
        this.classID = classID;
        this.teacherID = teacherID;
//        this.status = 0;
        this.subject = subject;
        this.listOfStudentCodes = Arrays.asList(stringOfStudentCodes.split(","));
        this.fee = fee;
        this.remuneration = remuneration;
        this.setDataSource(new Datasource());
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getClassID() {
        return classID;
    }

    public void setClassID(int classID) {
        this.classID = classID;
    }

    public int getTeacherID() {
        return teacherID;
    }

    public void setTeacherID(int teacherID) {
        this.teacherID = teacherID;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public List<String> getListOfStudentCodes() {
        if (Objects.isNull(this.listOfStudentCodes)){
            return new ArrayList<>();
        }
        List<String> returnedList = new ArrayList<>();
        for(int i=0; i< this.listOfStudentCodes.size() ; i++){
            if(this.listOfStudentCodes.get(i).length() > 0){
                Student student = new Student().readByCode(this.listOfStudentCodes.get(i).trim());
                if(!Objects.isNull(student)) {
                    returnedList.add(this.listOfStudentCodes.get(i).trim());
                }
            } 
        }
        //System.out.println(returnedList); System.out.println("googo");
        return returnedList;
    }

    public void setListOfStudentCodes(String stringOfStudentCodes) {
        this.listOfStudentCodes = Arrays.asList(stringOfStudentCodes.split(","));
    }
    
    public void setListOfStudentCodes(List listStudentCodes) {
        this.listOfStudentCodes = listStudentCodes;
    }

    public double getFee() {
        return fee;
    }

    public void setFee(double fee) {
        this.fee = fee;
    }

    public double getRemuneration() {
        return remuneration;
    }

    public void setRemuneration(double remuneration) {
        this.remuneration = remuneration;
    }

    @Override
    public String toString() {
        JSONObject jsonObj = new JSONObject();
        jsonObj.put("ClassID", this.getClassID());
        jsonObj.put("TeacherID", this.getTeacherID());
        jsonObj.put("Status", this.getStatus());
        jsonObj.put("Subject", this.getSubject());
        jsonObj.put("Fee", this.getFee());
        jsonObj.put("Remuneration", this.getRemuneration());
        jsonObj.put("ListOfStudents", new JSONArray(this.getListOfStudentCodes()) );
//        System.out.println("");
        return jsonObj.toString(4);
    }
    //</editor-fold>
    
    // <editor-fold desc="DAO fields">
    private static final String SQL_CREATE="Insert into Classes ( [Subject]\n" +
                                                        "           ,[ListOfStudents]\n" +
                                                        "           ,[Fee]\n" +
                                                        "           ,[Remuneration]" +
                                                        "           , [TeacherID]  ) "
                                        + "values (':Subject', ':ListOfStudents', ':Fee', ':Remuneration', ':TeacherID' )",
                        SQL_READALL = "Select * from Classes",
                        SQL_READ_BY_COL = "Select * from Classes where :col = ':value' ",
                        SQL_READ_BY_ID = "Select * from Classes where ClassID = ':ClassID' ",
                        SQL_UPDATE = "Update Classes set "
                                        + "Subject=':Subject',"
                                        + "Status=':Status',"
                                        + "ListOfStudents=':ListOfStudents',"
                                        + "Fee=':Fee',"
                                        + "Remuneration=':Remuneration', "
                                        + "TeacherID=':TeacherID' "
                                        + " where ClassID=':ClassID'",
                        SQL_DELETE = "Delete from Classes where ClassID=':ClassID'";    
    
    public int create(){
        String SQL = SQL_CREATE.replace(":Subject", this.getSubject())
                                .replace(":ListOfStudents",
                                                            Arrays.toString(
                                                                    this.getListOfStudentCodes().toArray(new String[0])
                                                            ).replace("[", "").replace("]", "")
                                                        )
                                .replace(":Fee", this.getFee()+"")
                                .replace(":Remuneration", this.getRemuneration()+"")
                                .replace(":TeacherID", this.getTeacherID()+"")
//                                .replace(":ClassID", this.getClassID()+"")
                ;
        return this.getJdbcTemplate().update(SQL);
    }
    
    public int update(){
        String SQL = SQL_UPDATE.replace(":Subject", this.getSubject())
                                .replace(":ListOfStudents",
                                                            Arrays.toString(
                                                                    this.getListOfStudentCodes().toArray(new String[0])
                                                            ).replace("[", "").replace("]", "")
                                                        )
                                .replace(":Fee", this.getFee()+"")
                                .replace(":Status", this.getStatus()+"")
                                .replace(":Remuneration", this.getRemuneration()+"")
                                .replace(":TeacherID", this.getTeacherID()+"")
                                .replace(":ClassID", this.getClassID()+"")
                ;
        return this.getJdbcTemplate().update(SQL);
    }
    
    public int delete(){
        String SQL = SQL_DELETE.replace(":ClassID", this.getClassID()+"")  ;
        return this.getJdbcTemplate().update(SQL);
    }
    
    public List<Class> readAll(){
        List<Map<String,Object>> list = this.getJdbcTemplate().queryForList(SQL_READALL);
        List<Class> returnedList = new ArrayList<Class>();
        for(Map map : list){
            Class cl = new Class((int) map.get("ClassID"),(int) map.get("TeacherID"), (String) map.get("Subject"), 
                                    (String) map.get("ListOfStudents"), (double) map.get("Fee"), (double) map.get("Remuneration"));
            cl.setStatus((int) map.get("Status"));
            returnedList.add(cl);
        }
        return returnedList;
    }
    
    
    public Class readByID(int id){
        String SQL = SQL_READ_BY_ID.replace(":ClassID", id+"");
        List<Map<String,Object>> list = this.getJdbcTemplate().queryForList(SQL);
        List<Class> returnedList = new ArrayList<Class>();
        for(Map map : list){
            Class cl = new Class((int) map.get("ClassID"),(int) map.get("TeacherID"), (String) map.get("Subject"), 
                                    (String) map.get("ListOfStudents"), (double) map.get("Fee"), (double) map.get("Remuneration"));
            cl.setStatus((int) map.get("Status"));
            returnedList.add(cl);
        }
        return (returnedList.isEmpty()) ? null : returnedList.get(0);
    }
    
    
    public List<Class> readByCol(String col, Object value){
        String SQL = SQL_READ_BY_COL.replace(":col", col).replace(":value", String.valueOf(value));
        List<Map<String,Object>> list = this.getJdbcTemplate().queryForList(SQL);
        List<Class> returnedList = new ArrayList<Class>();
        for(Map map : list){
            Class cl = new Class((int) map.get("ClassID"),(int) map.get("TeacherID"), (String) map.get("Subject"), 
                                    (String) map.get("ListOfStudents"), (double) map.get("Fee"), (double) map.get("Remuneration"));
            cl.setStatus((int) map.get("Status"));
            returnedList.add(cl);
        }
        return returnedList;
    }
    
    public int findTheLastIdentityID(){
        String SQL = "SELECT IDENT_CURRENT ('Classes') as 'lastID' ";
        List<Map<String,Object>> results = this.getJdbcTemplate().queryForList(SQL);
        return ((BigDecimal)results.get(0).get("lastID")).intValue();
        
    }
    // </editor-fold>
}
