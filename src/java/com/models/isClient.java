/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.models;

import java.util.Arrays;
import java.util.Optional;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;


public class isClient extends jsonHandler {
    
    public Boolean validation(String user, int pass){
        
        JSONArray jsonArray = readFile(Mainpath+clientsP); 
        
        for(int i=0; i<jsonArray.size();i++){
            JSONObject cl = (JSONObject)jsonArray.get(i);
            if (user.equals(cl.get("client_number").toString()) && pass==Integer.parseInt(cl.get("pass").toString())){  
                return true;
            }
            
        }
        return false;
                
    }
    public JSONObject client(String user){
        
        System.out.println("\n----validand si el numero de cliente existe: " +user );
        
        JSONArray jsonArray = readFile(Mainpath+clientsP);
        for(int i=0; i<jsonArray.size();i++){
            JSONObject cl = (JSONObject)jsonArray.get(i);
            if (user.equals(cl.get("client_number").toString())){  
                System.out.println("\n----Cliente encontrado\n");
                return cl;
            }
            
        }
        System.out.println("\n----Cliente no encontrado\n");
        return null;
    }
    
    public Boolean isInDatabase(String user){
        
        System.out.println("validando si esta en la base de datos");
        
        JSONArray jsonArray = readFile(Mainpath+clientsP);
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
        
        return false;
    }
    
    public JSONArray accounts(String nclient,String naccount){
        
            JSONArray temp = new JSONArray();
            JSONArray jsonArray = readFile(Mainpath+clientsP);
            if(!nclient.isEmpty()){
                jsonArray = readFile(Mainpath+accP);
                System.out.println("buscando las cuentas con el numero de CLIENTE " + nclient);
                for(int i=0; i<jsonArray.size();i++){
                    JSONObject cl = (JSONObject)jsonArray.get(i);
                    //System.out.print(cl.get("client_number"));
                    int temp1 = 0;
                    if (nclient.equals(cl.get("client_number"))){ 
                        System.out.println(cl.get("client_number")+"ENCONTRADO" + cl.get("account_number"));
                        accountpos(i);
                        temp.add(temp1,cl);
                        temp1++;
                    }
                }
                System.out.println("TERMINADO");
                return temp;
            }
            else if(!naccount.isEmpty()){
                jsonArray = readFile(Mainpath+accP);
                System.out.println("buscando la cuenta con el numero de cuenta " + naccount);
                for(int i=0; i<jsonArray.size();i++){
                JSONObject cl = (JSONObject)jsonArray.get(i);
                String comp = cl.get("account_number").toString();
                if (naccount.equals(comp)){  
                    System.out.println("ENCONTRADO"+cl.toString()+"encontrado");
                    accountpos(i);
                    temp.add(cl);
                    return temp;
                }
                else{
                System.out.print("Cuenta:"+ naccount+" no encontrada "+ cl.get("account_number").toString());}

                }
            
            }
     
        System.out.println("TERMINADO");
        return null;
        
    }
    
    public int accountpos(int pos){
        return pos;
    }
}
