package com.model;

import java.math.BigDecimal;
import java.sql.Date;

public class Student {

    private int studentID;
    private String studentName;
    private String roomNumber;
    private Date admissionDate;
    private BigDecimal feesPaid;
    private BigDecimal pendingFees;

    public int getStudentID() { return studentID; }
    public void setStudentID(int studentID) { this.studentID = studentID; }

    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }

    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }

    public Date getAdmissionDate() { return admissionDate; }
    public void setAdmissionDate(Date admissionDate) { this.admissionDate = admissionDate; }

    public BigDecimal getFeesPaid() { return feesPaid; }
    public void setFeesPaid(BigDecimal feesPaid) { this.feesPaid = feesPaid; }

    public BigDecimal getPendingFees() { return pendingFees; }
    public void setPendingFees(BigDecimal pendingFees) { this.pendingFees = pendingFees; }
}