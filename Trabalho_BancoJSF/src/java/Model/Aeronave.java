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
public class Aeronave {
    private int idAeronave;
    private int idCategoria;
    private String modelo;

    public Aeronave() {
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

    public Aeronave(int idAeronave, int idCategoria, String modelo) {
        this.idAeronave = idAeronave;
        this.idCategoria = idCategoria;
        this.modelo = modelo;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 67 * hash + this.idAeronave;
        hash = 67 * hash + this.idCategoria;
        hash = 67 * hash + Objects.hashCode(this.modelo);
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
        final Aeronave other = (Aeronave) obj;
        if (this.idAeronave != other.idAeronave) {
            return false;
        }
        if (this.idCategoria != other.idCategoria) {
            return false;
        }
        if (!Objects.equals(this.modelo, other.modelo)) {
            return false;
        }
        return true;
    }

    
    
    
    
}
