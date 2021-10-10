/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.misiontic.sprint5.logica;

import com.misiontic.sprint5.persistencia.Conexion;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author GIOVANNY
 */
public class Proveedor {
    
    private int id;
    private String nit;
    private String nombre;
    private String direccion;
    private String telefono;

    public Proveedor() {
    }

    public Proveedor(int id, String nit, String nombre, String direccion, String telefono) {
        this.id = id;
        this.nit = nit;
        this.nombre = nombre;
        this.direccion = direccion;
        this.telefono = telefono;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNit() {
        return nit;
    }

    public void setNit(String nit) {
        this.nit = nit;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
    
    
    public boolean guardarProveedor() {
        Conexion conexion = new Conexion();
        String sentencia = "INSERT INTO suppliers(supplier_nit, supplier_name, supplier_address, supplier_phone) "
                + " VALUES ( '" + this.nit + "','" + this.nombre + "',"
                + "'" + this.direccion + "','" + this.telefono + "');  ";
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.insertarBD(sentencia)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                return true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
                return false;
            }
        } else {
            conexion.cerrarConexion();
            return false;
        }
    }

    public boolean borrarProveedor(int id) {
        String Sentencia = "DELETE FROM `suppliers` WHERE `supplier_id`='" + id + "'";
        Conexion conexion = new Conexion();
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.actualizarBD(Sentencia)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                return true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
                return false;
            }
        } else {
            conexion.cerrarConexion();
            return false;
        }
    }

    public boolean actualizarProveedor() {
        Conexion conexion = new Conexion();
        String Sentencia = "UPDATE `suppliers` SET supplier_name='" + this.nombre + "',supplier_address='" + this.direccion 
                + "',supplier_phone='" + this.telefono + ";";
        if (conexion.setAutoCommitBD(false)) {
            if (conexion.actualizarBD(Sentencia)) {
                conexion.commitBD();
                conexion.cerrarConexion();
                return true;
            } else {
                conexion.rollbackBD();
                conexion.cerrarConexion();
                return false;
            }
        } else {
            conexion.cerrarConexion();
            return false;
        }
    }

    public List<Proveedor> listarProveedores() throws SQLException {
        Conexion conexion = new Conexion();
        List<Proveedor> listaProveedores = new ArrayList<>();
        String sql = "select * from suppliers order by supplier_id asc";
        ResultSet rs = conexion.consultarBD(sql);
        Proveedor p;
        while (rs.next()) {
            p = new Proveedor();
            p.setId(rs.getInt("supplier_id"));
            p.setNit(rs.getString("supplier_nit"));
            p.setNombre(rs.getString("supplier_name"));
            p.setDireccion(rs.getString("supplier_address"));
            p.setTelefono(rs.getString("supplier_phone"));
            listaProveedores.add(p);
        }
        conexion.cerrarConexion();
        return listaProveedores;
    }

    public Proveedor getProveedor() throws SQLException {
        Conexion conexion = new Conexion();
        String sql = "select * from suppliers where supplier_id='" + this.id + "'";
        ResultSet rs = conexion.consultarBD(sql);
        if (rs.next()) {
            this.id = rs.getInt("supplier_id");
            this.nit = rs.getString("supplier_nit");
            this.nombre = rs.getString("supplier_name");
            this.direccion = rs.getString("supplier_address");
            this.telefono = rs.getString("supplier_phone");
            conexion.cerrarConexion();
            return this;

        } else {
            conexion.cerrarConexion();
            return null;
        }

    }

    @Override
    public String toString() {
        return "Proveedor{" + "id=" + this.id + ", nit=" + this.nit + ", nombre=" + this.nombre + 
                ", direccion=" + this.direccion + ", telefono=" + this.telefono + '}';
    }

}
