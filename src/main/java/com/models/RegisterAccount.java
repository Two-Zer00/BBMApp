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
 * @author twozer00
 */
public class RegisterAccount extends jsonHandler {
    
    private RegisterClient rgc = new RegisterClient();
    private isClient val = new isClient();
    public void rac(accounts account){
        rgc = new RegisterClient();
        
            JSONArray jsonArray = readFile(Mainpath+accP);
            
            System.out.println(jsonArray);
            
            JSONObject cl = new JSONObject();
            cl.put("account_number", account.getNaccount());
            cl.put("client_number", account.getNclient());
            cl.put("type", account.getType());
            cl.put("amount", account.getAmount());
            cl.put("date", account.getDate());
            rgc.addAccountToClient(account.getNclient(),account.getNaccount());
            
            
            jsonArray.add(cl);
            //jsonArray.
            
            System.out.println(jsonArray);
            writeFile(jsonArray,Mainpath+accP);
    }

    public void updateNclient(String naccount,String nclient){
        JSONObject acc = (JSONObject)val.accounts("",naccount).get(0);
        //acc.replace("client_number", nclient);
       
    }
    
}
