/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package demo;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import models.Teacher;
import models.Class;
import models.Fee;
import models.Remuneration;
import models.Student;

/**
 *
 * @author USER
 */
public class Demo {
    public static void main(String[] args) {
//        Teacher tea = new Teacher().readByID(1);
//        tea.setEmail("jon.snow@tutoring.org");
//        System.out.println(tea.update());

//        List<Class> cla = new Class().readByCol("Subject","History");
////        cla.setFee(7);
//        System.out.println(cla.get(0).toString());

//        Student stu = new Student("Gren Hill", "08/08/1988", "251055455", "gren.hill@night.watch", 0);
////        stu.setFullname("Sam Tilly");
//        System.out.println(stu.create());
//        // U2FtIFRpbGxlcjE2MzI4MDM0NTA3NDY

//        List<Fee> fees = new Fee().readByCol("IsPaid", 1);
//        System.out.println(fees.get(0));
        
//        Remuneration rem = new Remuneration().readByID(1);
//        rem.setIsDisbursed(1);
//        System.out.println(rem);
//        System.out.println(rem.update());

//        Teacher tea = new Teacher().readByID(1);
//        tea.getIsAdmin();
//        System.out.println(class.getresource);
        new models.Class().findTheLastIdentityID();
    }
}
