/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import DAO.DAO;
import java.util.List;
import java.util.Objects;

/**
 *
 * @author Giovani
 */
public class Voo {
    private int idVoo;
    private int idAeronave;
    private int idCompanhiaAerea;
    private int idPortao;
    private String data_chegada;
    private String data_saida;

    public Voo() {
    }

    public Voo(int idVoo, int idAeronave, int idCompanhiaAerea, int idPortao, String data_chegada, String data_saida) {
        this.idVoo = idVoo;
        this.idAeronave = idAeronave;
        this.idCompanhiaAerea = idCompanhiaAerea;
        this.idPortao = idPortao;
        this.data_chegada = data_chegada;
        this.data_saida = data_saida;
    }

    public int getIdVoo() {
        return idVoo;
    }

    public void setIdVoo(int idVoo) {
        this.idVoo = idVoo;
    }

    public int getIdAeronave() {
        return idAeronave;
    }

    public void setIdAeronave(int idAeronave) {
        this.idAeronave = idAeronave;
    }

    public int getIdCompanhiaAerea() {
        return idCompanhiaAerea;
    }

    public void setIdCompanhiaAerea(int idCompanhiaAerea) {
        this.idCompanhiaAerea = idCompanhiaAerea;
    }

    public int getIdPortao() {
        return idPortao;
    }

    public void setIdPortao(int idPortao) {
        this.idPortao = idPortao;
    }

    public String getData_chegada() {
        return data_chegada;
    }

    public void setData_chegada(String data_chegada) {
        this.data_chegada = data_chegada;
    }

    public String getData_saida() {
        return data_saida;
    }

    public void setData_saida(String data_saida) {
        this.data_saida = data_saida;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 31 * hash + this.idVoo;
        hash = 31 * hash + this.idAeronave;
        hash = 31 * hash + this.idCompanhiaAerea;
        hash = 31 * hash + this.idPortao;
        hash = 31 * hash + Objects.hashCode(this.data_chegada);
        hash = 31 * hash + Objects.hashCode(this.data_saida);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Voo other = (Voo) obj;
        if (this.idVoo != other.idVoo) {
            return false;
        }
        if (this.idAeronave != other.idAeronave) {
            return false;
        }
        if (this.idCompanhiaAerea != other.idCompanhiaAerea) {
            return false;
        }
        if (this.idPortao != other.idPortao) {
            return false;
        }
        if (!Objects.equals(this.data_chegada, other.data_chegada)) {
            return false;
        }
        if (!Objects.equals(this.data_saida, other.data_saida)) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "Voo{" + "idVoo=" + idVoo + ", idAeronave=" + idAeronave + ", idCompanhiaAerea=" + idCompanhiaAerea + ", idPortao=" + idPortao + ", data_chegada=" + data_chegada + ", data_saida=" + data_saida + '}';
    }
    
    public List<Voo> listAllVoos() { return new DAO().listAllVoos();}
    
    public List<Voo> listAllAvailableFlights() { return new DAO().listAllAvailableFlights();}
    
    
}
