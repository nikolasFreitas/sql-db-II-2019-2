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
public class Portao {
    private int idPortao;
    private int idCategoria;
    private int disponibilidade;

    public Portao() {
    }

    public Portao(int idPortao, int idCategoria, int disponibilidade) {
        this.idPortao = idPortao;
        this.idCategoria = idCategoria;
        this.disponibilidade = disponibilidade;
    }

    public int getIdPortao() {
        return idPortao;
    }

    public void setIdPortao(int idPortao) {
        this.idPortao = idPortao;
    }

    public int getIdCategoria() {
        return idCategoria;
    }

    public void setIdCategoria(int idCategoria) {
        this.idCategoria = idCategoria;
    }

    public int getDisponibilidade() {
        return disponibilidade;
    }

    public void setDisponibilidade(int disponibilidade) {
        this.disponibilidade = disponibilidade;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 31 * hash + this.idPortao;
        hash = 31 * hash + this.idCategoria;
        hash = 31 * hash + this.disponibilidade;
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
        final Portao other = (Portao) obj;
        if (this.idPortao != other.idPortao) {
            return false;
        }
        if (this.idCategoria != other.idCategoria) {
            return false;
        }
        if (this.disponibilidade != other.disponibilidade) {
            return false;
        }
        return true;
    }
    
   
    
    

}
