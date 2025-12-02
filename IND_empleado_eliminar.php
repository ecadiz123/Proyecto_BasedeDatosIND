<?php
include 'Conexion.php'; //$coneccion

if($_POST["rut"]=="")//checkeo vacio
{
    echo '<h3>ERROR RUT VACIO</h3>';
    echo '<a href="IND_empleado_eliminar.html">Volver</a>';
}else{

    $rut=$_POST["rut"];
    $existe_q="select rut from empleado where rut=$rut";
    $existe_r=pg_query($coneccion,$existe_q);
    if(pg_num_rows($existe_r)==0)//Checkeo si rut esta en la base de datos
    {
    echo '<h3>RUT NO EXISTE EN EL SISTEMA</h3>';
    echo '<a href="IND_empleado_eliminar.html">Volver</a>';
    }else{
    
    $eliminar_q="DELETE FROM empleado WHERE rut=$rut;";
    $eliminar_r=pg_query($coneccion,$eliminar_q);
    if($eliminar_r)//si se elimina con exito
    {
    echo "<h3>Eliminado con exito de la base de datos</h3>";
    echo '<a href="IND_empleado_eliminar.html">Volver</a>';
    }
	
    }
    
}


?>
