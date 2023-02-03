/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.models;

/**
 *
 * @author Usuario
 */
public class Transference implements java.io.Serializable {
    private String acc1;
    private String acc2;
    private String nclient;
    private String amount;
    private String date;

    public Transference() {
    }

    public Transference(String acc1, String acc2, String cl, String amount, String date) {
        this.acc1 = acc1;
        this.acc2 = acc2;
        this.nclient = cl;
        this.amount = amount;
        this.date = date;
    }

    public String getAcc1() {
        return acc1;
    }

    public void setAcc1(String acc1) {
        this.acc1 = acc1;
    }

    public String getAcc2() {
        return acc2;
    }

    public void setAcc2(String acc2) {
        this.acc2 = acc2;
    }

    public String getNclient() {
        return nclient;
    }

    public void setNclient(String cl) {
        this.nclient = cl;
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
