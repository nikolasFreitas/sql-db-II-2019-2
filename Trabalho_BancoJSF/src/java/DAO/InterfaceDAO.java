/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import java.util.List;

/**
 *
 * @author Giovani
 */
public interface InterfaceDAO<T> {
    
    public boolean insert(T obj);
    public List<T> listAll(T obj);
    public boolean update (T obj);
    public boolean delete (T obj);
}
