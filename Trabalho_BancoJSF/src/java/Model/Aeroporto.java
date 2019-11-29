/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import Model.*;
import DAO.DAO;
import java.util.List;

/**
 *
 * @author Giovani
 */
public class Aeroporto {
    private int idAeronave;
    private int idCategoria;
    private String modelo;
    private String nome;
    private int quantidade;
    private  int idCompanhia;
    private String nomeComp;
    private int idCallsign;
    private int idPortao;
    private int disponibilidade;

    public Aeroporto() {
    }

    public int getIdAeronave() {
        return idAeronave;
    }

    public void setIdAeronave(int idAeronave) {
        this.idAeronave = idAeronave;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        this.modelo = modelo;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
    }

    public int getIdCompanhia() {
        return idCompanhia;
    }

    public void setIdCompanhia(int idCompanhia) {
        this.idCompanhia = idCompanhia;
    }

    public String getNomeComp() {
        return nomeComp;
    }

    public void setNomeComp(String nomeComp) {
        this.nomeComp = nomeComp;
    }

    public int getIdCallsign() {
        return idCallsign;
    }

    public void setIdCallsign(int idCallsign) {
        this.idCallsign = idCallsign;
    }

    public int getIdPortao() {
        return idPortao;
    }

    public void setIdPortao(int idPortao) {
        this.idPortao = idPortao;
    }

    public int getDisponibilidade() {
        return disponibilidade;
    }

    public void setDisponibilidade(int disponibilidade) {
        this.disponibilidade = disponibilidade;
    }
    
    
    
    public List<Voo> listAllVoos() { return new DAO().listAllVoos();}
    
}
