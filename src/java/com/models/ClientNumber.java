/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.models;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author twozer00
 */
public class ClientNumber {
    
    private int validateNumber(){
        try {
            System.out.print("entrando");
        JSONParser jsonParser = new JSONParser();
        Object obj = jsonParser.parse(new FileReader("E:\\Evidencia2DAW\\web\\json\\clients.json"));
        JSONArray jsonArray = (JSONArray)obj;
        
        return jsonArray.size()+1;
       } catch (FileNotFoundException ex) {
           Logger.getLogger(isClient.class.getName()).log(Level.SEVERE, null, ex);
       } catch (IOException | ParseException ex) {
           Logger.getLogger(isClient.class.getName()).log(Level.SEVERE, null, ex);
       }
        return 1;

    }
    private int validateNumberAcc(){
        try {
            System.out.print("entrando");
        JSONParser jsonParser = new JSONParser();
        Object obj = jsonParser.parse(new FileReader("E:\\Evidencia2DAW\\web\\json\\accounts.json"));
        JSONArray jsonArray = (JSONArray)obj;
        
        return jsonArray.size()+1;
       } catch (FileNotFoundException ex) {
           Logger.getLogger(isClient.class.getName()).log(Level.SEVERE, null, ex);
       } catch (IOException | ParseException ex) {
           Logger.getLogger(isClient.class.getName()).log(Level.SEVERE, null, ex);
       }
        return 1;

    }
    
    public String getNumber(){
        String number=Integer.toString(validateNumber());
        for(int i=number.length(); number.length()<5;i++){
            number ="0"+number;
        }
        return number;
    }
    public String getNumberAcc(){
        String number=Integer.toString(validateNumberAcc());
        for(int i=number.length(); number.length()<5;i++){
            number ="0"+number;
        }
        return number;
    }
    
    
    
    
    
}
