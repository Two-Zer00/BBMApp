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
 * @author twozer00
 */
public class ClientsList {
    
    public JSONArray listClients(){
        try {
            JSONParser jsonParser = new JSONParser();
            Object obj = jsonParser.parse(new FileReader("E:\\Evidencia2DAW\\web\\json\\clients.json"));
            JSONArray jsonArray = (JSONArray)obj;
            return jsonArray;
            /*for(int i=0; i<jsonArray.size();i++){
                JSONObject cl = (JSONObject)jsonArray.get(i);
            }*/
        } catch (FileNotFoundException ex) {
            Logger.getLogger(ClientsList.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(ClientsList.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(ClientsList.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    
}
