/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import java.util.Objects;

/**
 *
 * @author Giovani
 */
public class CompanhiaAerea {
    private  int idCompanhia;
    private String nome;

    public CompanhiaAerea() {
    }

    public CompanhiaAerea(int idCompanhia, String nome) {
        this.idCompanhia = idCompanhia;
        this.nome = nome;
    }

    public int getIdCompanhia() {
        return idCompanhia;
    }

    public void setIdCompanhia(int idCompanhia) {
        this.idCompanhia = idCompanhia;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 73 * hash + this.idCompanhia;
        hash = 73 * hash + Objects.hashCode(this.nome);
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
        final CompanhiaAerea other = (CompanhiaAerea) obj;
        if (this.idCompanhia != other.idCompanhia) {
            return false;
        }
        if (!Objects.equals(this.nome, other.nome)) {
            return false;
        }
        return true;
    }
    
    
    
    
}
