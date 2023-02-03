
package com.models;


public class ClientNumber extends jsonHandler {
    
    private int validateNumber(){
        
            System.out.print("Creando numbero de Cliente");
          
        return readFile(Mainpath+clientsP).size()+1;
       
    }
    private int validateNumberAcc(){
       
            System.out.print("Creando Numero de cuenta");
            return readFile(Mainpath+accP).size()+1;

    }
    
    public String getNumber(){
        String number=Integer.toString(validateNumber());
        for(int i=number.length(); number.length()<5;i++){
            number ="0"+number;
        }
        return number;
    }
    public String getNumberAcc(){
        String number=Integer.toString(validateNumberAcc());
        for(int i=number.length(); number.length()<5;i++){
            number ="0"+number;
        }
        return number;
    }
    
    
    
    
    
}
