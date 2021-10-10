<%-- 
    Document   : index
    Created on : 9/10/2021, 06:34:59 PM
    Author     : GIOVANNY
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--//Bootstrap core CSS--> 
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <!--Angular--> 
        <script src = "https://ajax.googleapis.com/ajax/libs/angularjs/1.2.15/angular.min.js"></script>  
        <style>
            /*div {border-style: dotted; }*/
        </style>
    </head>

    <body>
        <div class="container-fluid" ng-app = "sprint5" ng-controller = "ClienteController as cn">
            <div class="row">
                <div class="col-12">
                    <center><h2>Tienda Virtual - Clientes</h2></center> 
                </div>
            </div>
            <div class="row">
                <div class="col-6">
                    <h3>Sección 1</h3>
                    <div class="row">
                        <div class="col-6">
                            <label >Identificacion</label>
                            <input class="form-control" type="number" min="0" ng-model="cn.id">
                        </div>
                        <div class="col-6">
                            <label>DNI</label>
                            <input class="form-control" type="text" ng-model="cn.dni">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label>Nombre</label>
                            <input class="form-control" type="text" ng-model="cn.nombre">
                        </div>
                        
                        <div class="col-6">
                            <label>Telefono</label>
                            <input class="form-control" type="text" ng-model="cn.telefono">
                        </div>
                        
                        
                   <!--     <div class="col-6">
                            <label>Genero</label>
                            <select class="form-control" ng-model="cn.genero">
                                <option>Masculino</option>
                                <option>Femenino</option>
                            </select>
                        </div> -->
                    </div>
                    <div class="row">
                        
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label>Dirección</label>
                            <input class="form-control" type="text" ng-model="cn.direccion">
                        </div>
                        <div class="col-6">
                            <label>Fecha</label>
                            <input class="form-control" type="text" ng-model="cn.fecha">
                        </div>
                    </div> <br>
                    <div class="row">
                        <div class="col-3">
                            <button  class="btn btn-success" ng-click="cn.guardarCliente()">Guardar</button>
                        </div>
                        <div class="col-3">
                            <button  class="btn btn-primary" ng-click="cn.listarClientes()">Listar Cliente</button>
                        </div>
                        <div class="col-3">
                            <button  class="btn btn-danger" ng-click="cn.eliminarCliente()">Eliminar Cliente</button>
                        </div>
                        <div class="col-3">
                            <button  class="btn btn-warning" ng-click="cn.actualizarCliente()">Actualizar Cliente</button>
                        </div>
                    </div><br>
                </div>
                <div class="col-6">
                    <h3>Sección 2</h3>
                    <div class="row">
                        <div class="col-6">
                            <label >DNI</label>
                            <input class="form-control" type="text" value="{{cn.dni}}" disabled="">
                        </div>
                        <div class="col-6">
                            <label>Nombre</label>
                            <input class="form-control" type="text" value="{{cn.nombre}}" disabled="">
                        </div>
                    </div>
                   
                    <div class="row">
                      
                        <div class="col-6">
                            <label>Telefono</label>
                            <input class="form-control" type="text" value="{{cn.telefono}}" disabled="">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label>Dirección</label>
                            <input class="form-control" type="text" value="{{cn.direccion}}" disabled="">
                        </div>
                        <div class="col-6">
                            <label>Fecha</label>
                            <input class="form-control" type="text" value="{{cn.fecha}}" disabled="">
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" >
                <div class="col-12 table-responsive-xl">
                    <h3>Sección 3</h3>
                    <table class="table table-striped table-hover">  
                        <thead class="thead-dark">
                            <tr>  
                                <th>DNI</th>  
                                <th>Nombre</th>  
                                <th>Telefono</th>  
                                <th>Direccion</th>  
                                <th>Fecha</th>  
                            </tr>  
                        </thead>

                        <tr ng-repeat = "cliente in cn.clientes">  
                            <td>{{cliente.dni}}</td>  
                            <td>{{cliente.nombre}}</td>    
                            <td>{{cliente.telefono}}</td>  
                            <td>{{cliente.direccion}}</td>  
                            <td>{{cliente.fecha}}</td>  
                        </tr>  
                    </table> 
                </div>
            </div>
        </div>
    </body>
    
    <script>
        var app = angular.module('sprint5', []);
        app.controller('ClienteController', ['$http', controladorClientes]);
        function controladorClientes($http) {
            var cn = this;
            cn.listarClientes = function () {
                var url = "peticiones.jsp";
                var params = {
                    proceso: "listarClientes"
                };
                $http({
                    method: 'POST',
                    url: 'peticiones.jsp',
                    params: params
                }).then(function (res) {
                    cn.clientes = res.data.Clientes;
                });
            };
            cn.guardarCliente = function () {
                if (validar('todos')) {
                    var cliente = {
                        proceso: "guardarCliente",
                        dni: cn.dni,
                        nombre: cn.nombre,
                        telefono: cn.telefono,
                        direccion: cn.direccion,
                        fecha: cn.fecha
                    };
                    $http({
                        method: 'POST',
                        url: 'peticiones.jsp',
                        params: cliente
                    }).then(function (res) {
                        if (res.data.ok === true) {
                            if (res.data[cliente.proceso] === true) {
                                alert("Guardado con éxito");
//                                                            cn.listarContactos();
                            } else {
                                alert("Por favor vefifique sus datos");
                            }
                        } else {
                            alert(res.data.errorMsg);
                        }
                    });
                }
            };
            cn.eliminarCliente = function () {
                if (validar('soloId')) {
                    var cliente = {
                        proceso: "eliminarCliente",
                        id: cn.id
                    };
                    $http({
                        method: 'POST',
                        url: 'peticiones.jsp',
                        params: cliente
                    }).then(function (res) {
                        if (res.data.ok === true) {
                            if (res.data[cliente.proceso] === true) {
                                alert("Eliminado con éxito");
                                //                                cn.listarContactos();
                            } else {
                                alert("Por favor vefifique sus datos");
                            }
                        } else {
                            alert(res.data.errorMsg);
                        }
                    });
                }
            };
            cn.actualizarCliente = function () {
                if (validar('todos')) {
                    var cliente = {
                        proceso: "actualizarCliente",
                        id: cn.id,
                        nombre: cn.nombre,
                        telefono: cn.telefono,
                        direccion: cn.direccion,
                        fecha: cn.fecha
                    };
                    $http({
                        method: 'POST',
                        url: 'peticiones.jsp',
                        params: cliente
                    }).then(function (res) {
                        if (res.data.ok === true) {
                            if (res.data[cliente.proceso] === true) {
                                alert("actualizarCliente con éxito");
                                //                                cn.listarContactos();
                            } else {
                                alert("Por favor vefifique sus datos");
                            }
                        } else {
                            alert(res.data.errorMsg);
                        }
                    });
                }
            };
            validar = function (tipoValidacion) {
                var vId = cn.id ? true : false;
                var vNombre = cn.nombre ? true : false;
                var vTelefono = cn.telefono ? true : false;
                var vDireccion = cn.direccion ? true : false;
                var vFecha = cn.fecha ? true : false;
                if (tipoValidacion === 'soloId') {
                    if (!vId) {
                        alert('Valide el campo id');
                        return false;
                    } else {
                        return true;
                    }
                } else if (tipoValidacion === 'todos') {
                    if (!vId) {
                        alert('Valide el campo id');
                        return false;
                    } else if (!vNombre) {
                        alert('Valide el campo nombre');
                        return false;
                    } else if (!vTelefono) {
                        alert('Valide el campo telefono');
                        return false;
                    } else if (!vDireccion) {
                        alert('Valide el campo direccion');
                        return false;
                    } else if (!vFecha) {
                        alert('Valide el campo fecha');
                        return false;
                    } else {
                        return true;
                    }
                }
            };
        }
    </script>  
    
    
</html>
