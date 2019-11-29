/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import Model.Voo;
import java.util.ArrayList;
import java.util.List;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;

/**
 *
 * @author nikolas
 */
@ManagedBean
@SessionScoped
public class VooBean {
    private Voo voo = new Voo();
    private List<Voo> vooList;
    
    public VooBean() {
        if (this.vooList == null) {
            this.vooList = voo.listAllVoos();
        }
    }
    
    public String redirectLista(){
        return "listaVoo";
    }
    
    public Voo getVoo() {
        return voo;
    }

    public void setVoo(Voo voo) {
        this.voo = voo;
    }

    public List<Voo> getVooList() {
        return vooList;
    }

    public void setVooList(List<Voo> vooList) {
        this.vooList = vooList;
    }
    
    public void getAllFlights(){
        List<Voo> newList = voo.listAllVoos();
        if(!newList.isEmpty()) {
            vooList = newList;
        }
    }
    
    public void getAllAvailableFlights(){
        List<Voo> newList = voo.listAllAvailableFlights();
        if(!newList.isEmpty()) {
            vooList = newList;
        }
    }
}
