/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.misiontic.sprint5.logica;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.misiontic.sprint5.persistencia.Conexion;
/**
 *
 * @author GIOVANNY
 */
public class Cliente {

    private int id;
    private String dni;
    private String nombre;
    private String telefono;
    private String direccion;
    private String estado;
    private String fecha;

    public Cliente() {
    }

    public Cliente(int id, String dni, String nombre, String telefono, String direccion, String estado, String fecha) {
        this.id = id;
        this.dni = dni;
        this.nombre = nombre;
        this.telefono = telefono;
        this.direccion = direccion;
        this.estado = estado;
        this.fecha = fecha;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }


    
    public boolean guardarCliente() {
        Conexion conexion = new Conexion();
        String sentencia = "INSERT INTO customers(customer_dni, customer_name, customer_phone, customer_address, customer_status, customer_date) "
                + " VALUES ( '" + this.dni + "','" + this.nombre + "',"
                + "'" + this.telefono + "','" + this.direccion + "','ACTIVE',"
                + "'" + this.fecha +  "');  ";
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

    public boolean eliminarCliente(int id) {
        String Sentencia = "DELETE FROM `customers` WHERE `customer_id`='" + id + "'";
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

    public boolean actualizarCliente() {
        Conexion conexion = new Conexion();
        String Sentencia = "UPDATE `customers` SET customer_name='" + this.nombre + "',customer_phone='" + this.telefono 
                + "',customer_address='" + this.direccion
                + "',customer_status='" + this.estado + "',customer_date='" + this.fecha
                +  "' WHERE customer_id=" + this.id + ";";
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

    public List<Cliente> listarClientes() throws SQLException {
        Conexion conexion = new Conexion();
        List<Cliente> listaClientes = new ArrayList<>();
        String sql = "select * from customers order by customer_id asc";
        ResultSet rs = conexion.consultarBD(sql);
        Cliente c;
        while (rs.next()) {
            c = new Cliente();
            c.setId(rs.getInt("customer_id"));
            c.setDni(rs.getString("customer_dni"));
            c.setNombre(rs.getString("customer_name"));
            c.setTelefono(rs.getString("customer_phone"));
            c.setDireccion(rs.getString("customer_address"));
            c.setEstado(rs.getString("customer_status"));
            c.setFecha(rs.getString("customer_date"));
            listaClientes.add(c);
        }
        conexion.cerrarConexion();
        return listaClientes;
    }

    public Cliente getClientes() throws SQLException {
        Conexion conexion = new Conexion();
        String sql = "select * from customers where customer_id='" + this.id + "'";
        ResultSet rs = conexion.consultarBD(sql);
        if (rs.next()) {
            this.id = rs.getInt("customer_id");
            this.dni = rs.getString("customer_dni");
            this.nombre = rs.getString("customer_name");
            this.telefono = rs.getString("customer_phone");
            this.direccion = rs.getString("customer_address");
            this.estado = rs.getString("customer_status");
            this.fecha = rs.getString("customer_date");
            conexion.cerrarConexion();
            return this;

        } else {
            conexion.cerrarConexion();
            return null;
        }

    }

    @Override
    public String toString() {
        return "Cliente{" + "identificacion=" + id + ", dni=" + dni + ", nombre=" + nombre + 
                ", telefono=" + telefono + ", direccion=" + direccion + ", estado=" + estado + 
                ", fecha=" + fecha + '}';
    }
    
}
