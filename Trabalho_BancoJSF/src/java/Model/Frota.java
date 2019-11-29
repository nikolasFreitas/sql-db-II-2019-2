/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author Giovani
 */
public class Frota {
    private int idCallsign;
    private int idAeronave;
    private int idCompanhiaAerea;

    public Frota() {
    }

    public Frota(int idCallsign, int idAeronave, int idCompanhiaAerea) {
        this.idCallsign = idCallsign;
        this.idAeronave = idAeronave;
        this.idCompanhiaAerea = idCompanhiaAerea;
    }

    public int getIdCallsign() {
        return idCallsign;
    }

    public void setIdCallsign(int idCallsign) {
        this.idCallsign = idCallsign;
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

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 47 * hash + this.idCallsign;
        hash = 47 * hash + this.idAeronave;
        hash = 47 * hash + this.idCompanhiaAerea;
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
        final Frota other = (Frota) obj;
        if (this.idCallsign != other.idCallsign) {
            return false;
        }
        if (this.idAeronave != other.idAeronave) {
            return false;
        }
        if (this.idCompanhiaAerea != other.idCompanhiaAerea) {
            return false;
        }
        return true;
    }
    
    
}
