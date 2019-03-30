/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.models;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author Usuario
 */
public class transferList {
    
    
    public JSONArray clientTransfers (String NC){
        JSONArray rf = readFile();
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
    
    public JSONArray readFile(){
        try {
            JSONParser jsonParser = new JSONParser();
            Object obj = jsonParser.parse(new FileReader("E:\\Evidencia2DAW\\web\\json\\transfers.json"));
            JSONArray jsonArray = (JSONArray)obj;
            return jsonArray;
            
        } catch (FileNotFoundException ex) {
            Logger.getLogger(ClientsList.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException | ParseException ex) {
            Logger.getLogger(ClientsList.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
}
