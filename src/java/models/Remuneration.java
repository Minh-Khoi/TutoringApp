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
public class Remuneration extends JdbcDaoSupport{
    //<editor-fold desc="DTO fields">
    private int id, teacherID, classID, isDisbursed;
    
    
    public Remuneration() {
        this.setDataSource(new Datasource());
    }

    public Remuneration(int id, int teacherID, int classID, int isDisbursed) {
        this.id = id;
        this.teacherID = teacherID;
        this.classID = classID;
        this.isDisbursed = isDisbursed;
        this.setDataSource(new Datasource());
    }
    
    
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getTeacherID() {
        return teacherID;
    }

    public void setTeacherID(int teacherID) {
        this.teacherID = teacherID;
    }

    public int getClassID() {
        return classID;
    }

    public void setClassID(int classID) {
        this.classID = classID;
    }

    public int getIsDisbursed() {
        return isDisbursed;
    }

    public void setIsDisbursed(int isDisbursed) {
        this.isDisbursed = isDisbursed;
    }
    
    
    @Override
    public String toString() {
        JSONObject jsonObj = new JSONObject();
        jsonObj.putOnce("ID", this.getId());
        jsonObj.putOnce("ClassID", this.getClassID());
        jsonObj.putOnce("TeacherID", this.getTeacherID());
        jsonObj.putOnce("IsDisbursed", this.getIsDisbursed());
        return jsonObj.toString(4);
    }
    
    //</editor-fold>

    //<editor-fold desc="DAO fields">
    private static final String SQL_CREATE="Insert into RemunerationList ( [ClassID]\n" +
                                                        "           ,[TeacherID]\n" +
                                                        "           ,[IsDisbursed]) "
                                        + "values (':ClassID', ':TeacherID', ':IsDisbursed' )",
                        SQL_READALL = "Select * from RemunerationList",
                        SQL_READ_BY_COL = "Select * from RemunerationList where :col = ':value' ",
                        SQL_READ_BY_ID = "Select * from RemunerationList where ID = ':ID' ",
                        SQL_UPDATE = "Update RemunerationList set "
                                        + "ClassID=':ClassID',"
                                        + "TeacherID=':TeacherID',"
                                        + "IsDisbursed=':IsDisbursed' "
                                        + " where ID = ':ID' ",
                        SQL_DELETE = "Delete from RemunerationList where ID = ':ID' ";   
    
    public int create(){
        String SQL = SQL_CREATE.replace(":ClassID", this.getClassID()+"")
                                .replace(":TeacherID", this.getTeacherID()+"")
                                .replace(":IsDisbursed", this.getIsDisbursed()+"")
                ;
        return this.getJdbcTemplate().update(SQL);
    }
    
    public int update(){
        String SQL = SQL_UPDATE.replace(":ClassID", this.getClassID()+"")
                                .replace(":TeacherID", this.getTeacherID()+"")
                                .replace(":IsDisbursed", this.getIsDisbursed()+"")
                                .replace(":ID", this.getId()+"")
                ;
        return this.getJdbcTemplate().update(SQL);
    }
    
    public int delete(){
        String SQL = SQL_DELETE.replace(":ID", this.getId()+"");
        return this.getJdbcTemplate().update(SQL);
    }
    
    public List<Remuneration> readAll() {
        List<Remuneration> returnedList = new ArrayList<>();
        List<Map<String,Object>> list = this.getJdbcTemplate().queryForList(SQL_READALL);
        for(Map map:list){
            Remuneration rem = new Remuneration((int) map.get("ID"), (int) map.get("TeacherID"), 
                                                                    (int) map.get("ClassID"), (int) map.get("IsDisbursed"));
            returnedList.add(rem);
        }
        return returnedList;
    }
    
    
    public List<Remuneration> readByCol(String col, Object value) {
        String SQL = SQL_READ_BY_COL.replace(":col", col).replace(":value", String.valueOf(value));
        List<Remuneration> returnedList = new ArrayList<>();
        List<Map<String,Object>> list = this.getJdbcTemplate().queryForList(SQL);
        for(Map map:list){
            Remuneration rem = new Remuneration((int) map.get("ID"), (int) map.get("TeacherID"), 
                                                                    (int) map.get("ClassID"), (int) map.get("IsDisbursed"));
            returnedList.add(rem);
        }
        return returnedList;
    }
    
    public Remuneration readByID(int id) {
        String SQL = SQL_READ_BY_ID.replace(":ID", id+"");
        List<Remuneration> returnedList = new ArrayList<>();
        List<Map<String,Object>> list = this.getJdbcTemplate().queryForList(SQL);
        for(Map map:list){
            Remuneration rem = new Remuneration((int) map.get("ID"), (int) map.get("TeacherID"), 
                                                                    (int) map.get("ClassID"), (int) map.get("IsDisbursed"));
            returnedList.add(rem);
        }
        return returnedList.get(0);
    }
    
    public int findTheLastIdentityID(){
        String SQL = "SELECT IDENT_CURRENT ('RemunerationList') as 'lastID' ";
        List<Map<String,Object>> results = this.getJdbcTemplate().queryForList(SQL);
        return (int) (results.get(0).get("lastID"));
    }
    //</editor-fold>

}
