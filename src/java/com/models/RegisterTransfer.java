/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.models;


import java.io.FileNotFoundException;
import java.io.IOException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;


/**
 *
 * @author Usuario
 */
public class RegisterTransfer extends jsonHandler {
    
    
    public void RegTransfer(Transference trans) throws FileNotFoundException, IOException, ParseException{
        
         JSONArray jsonArray = readFile(Mainpath+transP);
         JSONObject tf = new JSONObject();
         tf.put("retire_account", trans.getAcc1());
         tf.put("deposit_account", trans.getAcc2());
         tf.put("amount", trans.getAmount());
         tf.put("date", trans.getDate());
         tf.put("client_number", trans.getNclient());
         jsonArray.add(tf);
         DoTransfer(trans.getAcc1(),trans.getAcc2(),trans.getAmount());
         
         writeFile(jsonArray,Mainpath+transP);
        
    }
    
    public void DoTransfer(String acc1, String acc2,String amount){
       
        isClient val = new isClient();
        JSONObject acount1 = (JSONObject) val.accounts("", acc1).get(0);
        JSONObject acount2 = (JSONObject) val.accounts("", acc2).get(0);
        
        double a1 = Double.parseDouble((String)acount1.get("amount"))- Double.valueOf(amount);
        double a2 = Double.parseDouble((String)acount2.get("amount"))+ Double.valueOf(amount) ;
        
        update(acount1.get("account_number").toString(),String.valueOf(a1));
        update(acount2.get("account_number").toString(),String.valueOf(a2));
        
    }
    
    public void update (String an, String am) {
         
        JSONObject ac = null;
        JSONArray OG = readFile(Mainpath+accP);
        int index = 0;
        for (int i=0; i <= OG.size();i++ ){
            ac = (JSONObject)OG.get(i);
            if (ac.get("account_number").equals(an)){
                ac.put("amount", am);
                index =i;
                
            break;
            }
        }
        OG.remove(index);
        OG.add(index, ac);
        writeFile(OG,Mainpath+accP);
        

        }
}
    
   
