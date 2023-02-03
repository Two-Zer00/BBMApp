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
public class accounts implements java.io.Serializable{
    private String naccount;
    private String nclient;
    private String type;
    private String amount;
    private String date;

    public accounts(String naccount, String nclient, String type, String amount, String date) {
        this.naccount = naccount;
        this.nclient = nclient;
        this.type = type;
        this.amount = amount;
        this.date = date;
    }

    public accounts() {
    }

    public String getNaccount() {
        return naccount;
    }

    public void setNaccount(String naccount) {
        this.naccount = naccount;
    }

    public String getNclient() {
        return nclient;
    }

    public void setNclient(String nclient) {
        this.nclient = nclient;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
