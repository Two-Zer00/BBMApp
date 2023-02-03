/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.models;

import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Usuario
 */
public class jsonHandler {
    
    public static String Mainpath;
    public static String accP = "/accounts.json";
    public static String clientsP = "/clients.json";
    public static String transP = "/transfers.json";

    public static void setMainpath(String Mainpath) {
        jsonHandler.Mainpath = Mainpath;
    }
    
    
    

    public JSONArray readFile(String filepath){
    JSONParser jsonParser = new JSONParser();
        Object obj = null;
        try {
            System.out.println(filepath);
            obj = jsonParser.parse(new BufferedReader(new InputStreamReader(new FileInputStream(filepath), "UTF-8")));

            //obj = jsonParser.parse(new FileReader(filepath));
        } catch (IOException | ParseException ex) {
            Logger.getLogger(RegisterClient.class.getName()).log(Level.SEVERE, null, ex);
        }
        JSONArray jsonArray = (JSONArray)obj;
        return jsonArray;
    }
    public void writeFile(JSONArray arr,String Path){
        //File filep=();
        FileWriter file = null;
        try {
            file = new FileWriter(Path);
            file.write(arr.toJSONString());
            file.flush();
            file.close();
        } catch (IOException ex) {
            Logger.getLogger(RegisterClient.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                file.close();
            } catch (IOException ex) {
                Logger.getLogger(RegisterClient.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
