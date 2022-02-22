/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.models;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author Usuario
 */
public class transferList extends jsonHandler {
    
    
    public JSONArray clientTransfers (String NC){
        JSONArray rf = readFile(Mainpath+transP);
        JSONArray ct = new JSONArray(); 
        for(int i=0 ; i<rf.size();i++){
            JSONObject temp = (JSONObject)rf.get(i);
            if (temp.get("client_number").toString().equals(NC) ){
                System.out.print(temp.get("client_number"));
                ct.add(temp);
            }
        }
    
        return ct;
    }
    public JSONArray recieveAccountTransfers(String NA){
        JSONArray rf = readFile(Mainpath+transP);
        JSONArray ct = new JSONArray();
        //System.out.print(rf.toJSONString());
        for(int i=0 ; i<rf.size();i++){
            JSONObject temp = (JSONObject)rf.get(i);
            if (temp.get("deposit_account").toString().equals(NA) ){
                System.out.print(temp.get("deposit_account"));
                ct.add(temp);
            }
        }
        return ct;
        
    }
   
}
