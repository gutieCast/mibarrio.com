<%-- 
    Document   : peticiones
    Created on : 9/10/2021, 06:35:20 PM
    Author     : GIOVANNY
--%>

<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.misiontic.sprint5.logica.Cliente"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="application/json;charset=iso-8859-1" language="java" pageEncoding="iso-8859-1" session="true"%>


<%    // Iniciando respuesta JSON.
    Cliente c1 = new Cliente();
    String respuesta = "{";

    //Lista de procesos o tareas a realizar 
    List<String> tareas = Arrays.asList(new String[]{
        "actualizarCliente",
        "eliminarCliente",
        "listarClientes",
        "guardarCliente"
    });

    String proceso = "" + request.getParameter("proceso");

    // Validación de parámetros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("guardarCliente")) {

            int ident = Integer.parseInt(request.getParameter("dni"));
            String nombre = request.getParameter("nombre");
            String telefono = request.getParameter("telefono");
            String direccion = request.getParameter("direccion");
            String fecha = request.getParameter("fecha");
            boolean favorito = Boolean.parseBoolean(request.getParameter("favorito"));
//
            Cliente c = new Cliente();
            c.setId(ident);
            c.setNombre(nombre);
            c.setTelefono(telefono);
            c.setDireccion(direccion);
            c.setFecha(fecha);
            c.setEstado("ACTIVE");
            if (c.guardarCliente()) {
//            if (true) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("eliminarCliente")) {
            Cliente c = new Cliente();
            int identificacion = Integer.parseInt(request.getParameter("id"));
            if (c.eliminarCliente(identificacion)) {
//            if (true) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listarClientes")) {
            Cliente c = new Cliente();
            try {
                List<Cliente> lista = c.listarClientes();
                respuesta += "\"" + proceso + "\": true,\"Clientes\":" + new Gson().toJson(lista);
            } catch (SQLException ex) {
                respuesta += "\"" + proceso + "\": true,\"Clientes\":[]";
                Logger.getLogger(Cliente.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("actualizarCliente")) {
            int ident = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            String telefono = request.getParameter("telefono");
            String direccion = request.getParameter("direccion");
            String fecha = request.getParameter("fecha");
            boolean favorito = Boolean.parseBoolean(request.getParameter("favorito"));
//
            Cliente c = new Cliente();
            c.setId(ident);
            c.setNombre(nombre);
            c.setTelefono(telefono);
            c.setDireccion(direccion);
            c.setFecha(fecha);
            if (c.actualizarCliente()) {
//            if (true) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        }

        // ------------------------------------------------------------------------------------- //
        // -----------------------------------FIN PROCESOS-------------------------------------- //
        // ------------------------------------------------------------------------------------- //
        // Proceso desconocido.
    } else {
        respuesta += "\"ok\": false,";
        respuesta += "\"error\": \"INVALID\",";
        respuesta += "\"errorMsg\": \"Lo sentimos, los datos que ha enviado,"
                + " son inválidos. Corrijalos y vuelva a intentar por favor.\"";
    }
    // Usuario sin sesión.
    // Responder como objeto JSON codificación ISO 8859-1.
    respuesta += "}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);
%>

<!--
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
-->
