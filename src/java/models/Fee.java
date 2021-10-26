/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import datas.Datasource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.json.JSONObject;
import org.springframework.jdbc.core.support.JdbcDaoSupport;

/**
 *
 * @author USER
 */
public class Fee extends JdbcDaoSupport{
    //<editor-fold desc="DTO fields">
    private int id, classID, isPaid;
    private String studentCode;
        
    public Fee(){
        this.setDataSource(new Datasource());
    }
    
    public Fee(int id, int classID, int isPaid, String studentCode) {
        this.id = id;
        this.classID = classID;
        this.isPaid = isPaid;
        this.studentCode = studentCode;
        this.setDataSource(new Datasource());
    }
    
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getClassID() {
        return classID;
    }

    public void setClassID(int classID) {
        this.classID = classID;
    }

    public int getIsPaid() {
        return isPaid;
    }

    public void setIsPaid(int isPaid) {
        this.isPaid = isPaid;
    }

    public String getStudentCode() {
        return studentCode;
    }

    public void setStudentCode(String studentCode) {
        this.studentCode = studentCode;
    }

    @Override
    public String toString() {
        JSONObject jsonObj = new JSONObject();
        jsonObj.put("ID", this.getId());
        jsonObj.put("ClassID", this.getClassID());
        jsonObj.put("IsPaid", this.getIsPaid());
        jsonObj.put("StudentCode", this.getStudentCode());
        return  jsonObj.toString(4);
    }

    //</editor-fold >

    //<editor-fold desc="DAO fields">
    private static final String SQL_CREATE="Insert into FeeList ( [ClassID]\n" +
                                                        "           ,[StudentCode]\n" +
                                                        "           ,[IsPaid]) "
                                        + "values (':ClassID', ':StudentCode', ':IsPaid' )",
                        SQL_READALL = "Select * from FeeList",
                        SQL_READ_BY_COL = "Select * from FeeList where :col = ':value' ",
                        SQL_READ_BY_ID = "Select * from FeeList where ID = ':ID' ",
                        SQL_UPDATE = "Update FeeList set "
                                        + "ClassID=':ClassID',"
                                        + "StudentCode=':StudentCode',"
                                        + "IsPaid=':IsPaid' "
                                        + " where ID = ':ID' ",
                        SQL_DELETE = "Delete from FeeList where ID = ':ID' ";   
    
    public int create(){
        String SQL = SQL_CREATE.replace(":ClassID", this.getClassID()+"")
                                .replace(":StudentCode", this.getStudentCode())
                                .replace(":IsPaid", this.getIsPaid()+"")
                ;
        return this.getJdbcTemplate().update(SQL);
    }
        
    public int update(){
        String SQL = SQL_UPDATE.replace(":ClassID", this.getClassID()+"")
                                .replace(":StudentCode", this.getStudentCode())
                                .replace(":IsPaid", this.getIsPaid()+"")
                                .replace(":ID", this.getId()+"")
                ;
        return this.getJdbcTemplate().update(SQL);
    }
        
    public int delete(){
        String SQL = SQL_DELETE.replace(":ID", this.getId()+"")   ;
        return this.getJdbcTemplate().update(SQL);
    }
    
    public List<Fee> readAll(){
        List<Fee> returnedList = new ArrayList<>();
        List<Map<String,Object>> list = this.getJdbcTemplate().queryForList(SQL_READALL);
        for(Map map:list){
            Fee fee = new Fee((int) map.get("ID"), (int) map.get("ClassID"), (int) map.get("IsPaid"), (String) map.get("StudentCode"));
            returnedList.add(fee);
        }
        return returnedList;
    }
    
    public List<Fee> readByCol(String col, Object value){
        String SQL = SQL_READ_BY_COL.replace(":col", col).replace(":value", String.valueOf(value));
        List<Fee> returnedList = new ArrayList<>();
        List<Map<String,Object>> list = this.getJdbcTemplate().queryForList(SQL);
        for(Map map:list){
            Fee fee = new Fee((int) map.get("ID"), (int) map.get("ClassID"), (int) map.get("IsPaid"), (String) map.get("StudentCode"));
            returnedList.add(fee);
        }
        return returnedList;
    }
    
    
    public Fee readByID(int id){
        String SQL = SQL_READ_BY_ID.replace(":ID", this.getId()+"");
        List<Fee> returnedList = new ArrayList<>();
        List<Map<String,Object>> list = this.getJdbcTemplate().queryForList(SQL_READALL);
        for(Map map:list){
            Fee fee = new Fee((int) map.get("ID"), (int) map.get("ClassID"), (int) map.get("IsPaid"), (String) map.get("StudentCode"));
            returnedList.add(fee);
        }
        return returnedList.get(0);
    }
    
    public int findTheLastIdentityID(){
        String SQL = "SELECT IDENT_CURRENT ('FeeList') as 'lastID' ";
        List<Map<String,Object>> results = this.getJdbcTemplate().queryForList(SQL);
        return (int) (results.get(0).get("lastID"));
    }
       
    //</editor-fold>
}
