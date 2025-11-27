<?php
//------------Variables para conexion---------
$equipo= "localhost";
$namebd= "";
$puerto= "5432"; //ingresar el puerto correcto;
$usuario= ""; //ingresar usuario correcta
$clave= ""; //ingresar password correcto

//------------Aqui la conexion----------------
$coneccion = pg_connect("host= $equipo
                        dbname= $namebd
                        port= $puerto
                        user= $usuario
                        password= $clave
                        ");
?>
