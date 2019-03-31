/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.models;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.LinkOption;
import java.nio.file.Path;
import java.nio.file.Paths;
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
public class isClient {
    
    public static String path;

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        isClient.path = path;
    }
    
    
    
    public Boolean validation(String user, int pass){
        try {
        JSONParser jsonParser = new JSONParser();
        //File current
        Object obj = jsonParser.parse(new FileReader(path+"clients.json"));
        JSONArray jsonArray = (JSONArray)obj;
        for(int i=0; i<jsonArray.size();i++){
            JSONObject cl = (JSONObject)jsonArray.get(i);
            if (user.equals(cl.get("client_number").toString()) && pass==Integer.parseInt(cl.get("pass").toString())){  
                return true;
            }
            
        }
        
       } catch (FileNotFoundException ex) {
           Logger.getLogger(isClient.class.getName()).log(Level.SEVERE, null, ex);
       } catch (IOException | ParseException ex) {
           Logger.getLogger(isClient.class.getName()).log(Level.SEVERE, null, ex);
       }
        return false;
    }
    public JSONObject client(String user){
        try {
            System.out.print("validand si el numero de cliente existe");
        JSONParser jsonParser = new JSONParser();
        Object obj = jsonParser.parse(new FileReader(path+"clients.json"));
        JSONArray jsonArray = (JSONArray)obj;
        for(int i=0; i<jsonArray.size();i++){
            JSONObject cl = (JSONObject)jsonArray.get(i);
            if (user.equals(cl.get("client_number").toString())){  
                return cl;
            }
            
        }
        
       } catch (FileNotFoundException ex) {
           Logger.getLogger(isClient.class.getName()).log(Level.SEVERE, null, ex);
       } catch (IOException | ParseException ex) {
           Logger.getLogger(isClient.class.getName()).log(Level.SEVERE, null, ex);
       }
        return null;
    }
    
    public Boolean isInDatabase(String user){
        try {
        System.out.println("validando si esta en la base de datos");
        JSONParser jsonParser = new JSONParser();
        Object obj = jsonParser.parse(new FileReader(path+"clients.json"));
        JSONArray jsonArray = (JSONArray)obj;
        System.out.println(jsonArray.size());
        for(int i=0; i<jsonArray.size();i++){
            //System.out.print("For - revisando" + i + " "+ jsonArray.size());
            JSONObject cl = (JSONObject)jsonArray.get(i);
            //System.out.println(cl.get("client_number"));
            if (user.equals(cl.get("client_number").toString())){
                System.out.println("validando si esta en la base de datos" + "validado");
                return true;
            }
            
        }
        
        
       } catch (FileNotFoundException ex) {
           Logger.getLogger(isClient.class.getName()).log(Level.SEVERE, null, ex);
       } catch (IOException | ParseException ex) {
           Logger.getLogger(isClient.class.getName()).log(Level.SEVERE, null, ex);
       }
        return false;
    }
    
    public JSONObject account(String nclient,String naccount){
        try {
            
            JSONParser jsonParser = new JSONParser();
            Object obj = jsonParser.parse(new FileReader(path+"accounts.json"));
            JSONArray jsonArray = (JSONArray)obj;
            if(!nclient.isEmpty()){
                System.out.println("buscando la cuenta con el numero de CLIENTE " + nclient);
                for(int i=0; i<jsonArray.size();i++){
                    JSONObject cl = (JSONObject)jsonArray.get(i);
                    System.out.print(cl.get("client_number"));
                    if (nclient.equals(cl.get("client_number"))){ 
                        System.out.println("ENCONTRADO");
                        accountpos(i);
                        return cl;
                    }
                }
            }
            else if(!naccount.isEmpty()){
                System.out.println("buscando la cuenta con el numero de cuenta " + naccount);
                for(int i=0; i<jsonArray.size();i++){
                JSONObject cl = (JSONObject)jsonArray.get(i);
                String comp = cl.get("account_number").toString();
                if (naccount.equals(comp)){  
                    System.out.println("ENCONTRADO"+cl.toString()+"encontrado");
                    accountpos(i);
                    
                    return cl;
                }
                else{
                System.out.print("Cuenta:"+ naccount+" no encontrada "+ cl.get("account_number").toString());}

                }
            
            }
            
            
        
       } catch (FileNotFoundException ex) {
           Logger.getLogger(isClient.class.getName()).log(Level.SEVERE, null, ex);
       } catch (IOException | ParseException ex) {
           Logger.getLogger(isClient.class.getName()).log(Level.SEVERE, null, ex);
       }
        System.out.println("TERMINADO");
        return null;
        
    }
    
    public int accountpos(int pos){
        return pos;
    }
    
}
