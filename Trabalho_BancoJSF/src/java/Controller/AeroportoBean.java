/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.*;
import java.util.LinkedList;
import java.util.List;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;

/**
 *
 * @author Giovani
 */


@ManagedBean
@SessionScoped
public class AeroportoBean {
    private Aeroporto aeroporto = new Aeroporto();
    private Voo voo = new Voo();
    private List<Voo> listaVoo = new LinkedList();
    
    
    public Voo getVoo(){return voo;}
    
     public List<Voo> getTodosVoos() {
        
        listaVoo = aeroporto.listAllVoos();
        
        return listaVoo;
    }
    
}
