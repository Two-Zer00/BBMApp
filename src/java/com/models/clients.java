/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.models;

/**
 *
 * @author twozer00
 */
public class clients implements java.io.Serializable{
    private String name;
    private String lname;
    private String nclient;
    private String adress;
    private String zip;
    private String state;
    private String city;
    private String country;
    private String tel;
    private String bdate;
    private String email;
    private String pass;
    private String role;

    public clients(String name, String lname, String adress, String zip, String state, String city, String country, String tel, String bdate, String email, String pass,String nclient,String role) {
        this.name = name;
        this.lname = lname;
        this.adress = adress;
        this.zip = zip;
        this.state = state;
        this.city = city;
        this.country = country;
        this.tel = tel;
        this.bdate = bdate;
        this.email = email;
        this.pass = pass;
        this.nclient = nclient;
        this.role = role;
    }

    public clients() {
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getAdress() {
        return adress;
    }

    public void setAdress(String adress) {
        this.adress = adress;
    }

    public String getZip() {
        return zip;
    }

    public void setZip(String zip) {
        this.zip = zip;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getBdate() {
        return bdate;
    }

    public void setBdate(String bdate) {
        this.bdate = bdate;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getNclient() {
        return nclient;
    }

    public void setNclient(String nclient) {
        this.nclient = nclient;
    }
    
    
}
