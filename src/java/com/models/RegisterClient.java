
package com.models;

import java.io.FileNotFoundException;
import java.io.IOException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import org.json.simple.parser.ParseException;


public class RegisterClient extends jsonHandler {
    private isClient val = new isClient();
    
    public void rc(clients client) throws FileNotFoundException, IOException, ParseException{
        /*JSONParser jsonParser = new JSONParser();
        Object obj = jsonParser.parse(new FileReader("/Users/twozer00/NetBeansProjects/Evidencia2DAW/web/json/clients.json"));
        JSONArray jsonArray = (JSONArray)obj;
*/  
        JSONArray jsonArray = readFile( Mainpath+clientsP);
        System.out.println("ñañlskjñdlaksjdñ");
        val = new isClient();
        JSONObject cl = null;
        int pos=0;
        System.out.println("NUMERO DE CLIENTE" + client.getNclient());
        
        if(val.isInDatabase(client.getNclient())){
            
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

        writeFile(jsonArray,Mainpath+clientsP);
       

    }
    
    public void addAccountToClient(String nclient,String naccount){
        int pos =0;
        JSONArray jsonArray = readFile(Mainpath+clientsP);
        pos=clientInFile(null,nclient,jsonArray,pos);
        JSONObject cl = val.client(nclient);
        //JSONObject acc = val.account(nclient,"");
        //System.out.print("lol/"+acc.get("account_number")+"---------"+nclient);
        cl.put("account_number",naccount);
        jsonArray.remove(pos);
        jsonArray.add(pos,cl);
        writeFile(jsonArray,Mainpath+clientsP);
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
