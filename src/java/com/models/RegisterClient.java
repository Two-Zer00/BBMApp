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
public class RegisterClient {
    private isClient val = new isClient();
    
    public void rc(clients client) throws FileNotFoundException, IOException, ParseException{
        /*JSONParser jsonParser = new JSONParser();
        Object obj = jsonParser.parse(new FileReader("/Users/twozer00/NetBeansProjects/Evidencia2DAW/web/json/clients.json"));
        JSONArray jsonArray = (JSONArray)obj;
*/  
        JSONArray jsonArray = readFile();
        System.out.println("ñañlskjñdlaksjdñ");
        val = new isClient();
        JSONObject cl = null;
        int pos=0;
        System.out.println("NUMERO DE CLIENTE" + client.getNclient());
        
        if(val.isInDatabase(client.getNclient())){
            /*System.out.print("UPDATE");
            for(int i=0; i<jsonArray.size();i++){
                JSONObject cl1 = (JSONObject)jsonArray.get(i);
                System.out.println("" + client.getNclient() +" "+ cl1.get("client_number"));
                if (client.getNclient().equals(cl1.get("client_number").toString())){ 
                    pos=i;
                }
            
            }*/
            pos = clientInFile(client,"",jsonArray,pos);
            cl = val.client(client.getNclient());
            cl.put("name", client.getName());
            cl.put("last_name", client.getLname());
            cl.put("adress", client.getAdress());
            cl.put("zip_code", client.getZip());
            cl.put("state", client.getState());
            cl.put("city", client.getCity());
            cl.put("country", client.getCountry());
            cl.put("phone", client.getTel());
            cl.put("birth_date", client.getBdate());
            cl.put("client_number", client.getNclient());
            cl.put("email", client.getEmail());
            if(client.getPass()==null){
                JSONObject temp = val.client(client.getNclient());
                cl.put("pass",temp.get("pass"));
            }
            //cl.put("pass", client.getPass().hashCode());
            //val.client(client.getNclient()).get("role");

            cl.put("role", val.client(client.getNclient()).get("role"));
            jsonArray.remove(pos);
            jsonArray.add(pos,cl);
        }
        else{
        System.out.println("NO UPDATE");
        cl = new JSONObject();
        cl.put("name", client.getName());
        cl.put("last_name", client.getLname());
        cl.put("adress", client.getAdress());
        cl.put("zip_code", client.getZip());
        cl.put("state", client.getState());
        cl.put("city", client.getCity());
        cl.put("country", client.getCountry());
        cl.put("phone", client.getTel());
        cl.put("birth_date", client.getBdate());
        cl.put("client_number", client.getNclient());
        cl.put("account_number", "");
        cl.put("email", client.getEmail());
        cl.put("pass", client.getPass().hashCode());
        cl.put("role", "user");
        jsonArray.add(cl);
        }

        writeFile(jsonArray,pos);
        /*System.out.println(jsonArray.get(pos));
        FileWriter file = new FileWriter("/Users/twozer00/NetBeansProjects/Evidencia2DAW/web/json/clients.json");
        file.write(jsonArray.toJSONString());
        file.flush();
        file.close();*/

    }
    
    public void addAccountToClient(String nclient,String naccount){
        int pos =0;
        JSONArray jsonArray = readFile();
        pos=clientInFile(null,nclient,jsonArray,pos);
        JSONObject cl = val.client(nclient);
        //JSONObject acc = val.account(nclient,"");
        //System.out.print("lol/"+acc.get("account_number")+"---------"+nclient);
        cl.put("account_number",naccount);
        jsonArray.remove(pos);
        jsonArray.add(pos,cl);
        writeFile(jsonArray,pos);
    }
    
    public JSONArray readFile(){
    JSONParser jsonParser = new JSONParser();
        Object obj = null;
        try {
            obj = jsonParser.parse(new FileReader("E:\\Evidencia2DAW\\web\\json\\clients.json"));
        } catch (IOException ex) {
            Logger.getLogger(RegisterClient.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(RegisterClient.class.getName()).log(Level.SEVERE, null, ex);
        }
        JSONArray jsonArray = (JSONArray)obj;
        return jsonArray;
    }
    
    public void writeFile(JSONArray arr,int pos){
        //File filep=();
        FileWriter file = null;
        try {
            System.out.println(arr.get(pos));
            file = new FileWriter("E:\\Evidencia2DAW\\web\\json\\clients.json");
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
    public int clientInFile(clients client,String Nclient,JSONArray jsonArray,int pos){
        System.out.print("UPDATE" + Nclient+"///");
        if(client!=null){
            for(int i=0; i<jsonArray.size();i++){
                JSONObject cl1 = (JSONObject)jsonArray.get(i);
                System.out.println("obj"+client.getNclient());
                if (client.getNclient().equals(cl1.get("client_number").toString())){ 
                    pos=i;
                }
            }
        }
        else{
            for(int i=0; i<jsonArray.size();i++){
                JSONObject cl1 = (JSONObject)jsonArray.get(i);
                System.out.println("strin"+Nclient);
                if (Nclient.equals(cl1.get("client_number").toString())){ 
                    pos=i;
                }
            }
        }
        return pos;
    }
    
}
