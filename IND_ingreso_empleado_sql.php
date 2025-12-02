<?php
include 'Conexion.php';


if($_POST["rut"]!='' && $_POST["nombre"]!='' && $_POST["telefono"]!='' && $_POST["correo"]!='')//si no quedaron vacios
{

    $rut=$_POST["rut"];
    $nombre=$_POST["nombre"];
    $correo=$_POST["correo"];
    $telefono=$_POST["telefono"];
    $region=$_POST["region"];
    $area=$_POST["area"];
    $programa=$_POST["programa"];

    //check si rut ya esta ingresado
    $rutcheck_q="select rut from empleado where rut =". $rut .";";
    $rutcheck=pg_query($coneccion,$rutcheck_q);
    if($rutcheck)
    {
    if(pg_num_rows($rutcheck)!=0)// checkeo si aparece en la base de datos
    {
	echo '<h3>ERROR EMPLEADO YA ESTA INGRESADO</h3>';

    }else{
    //se ingresa empleado
    $sql="INSERT INTO empleado (rut, nombre, telefono, correo, id_area, direccion_regional) 
    VALUES(".$rut.", '$nombre', $telefono, '$correo', $area, (select id from direccion_regional where region= $region));";
    $insercion = pg_query($coneccion,$sql);

    if($programa!="0")//se añade programa si no es 0 el valor
    {
    $sql2="INSERT INTO supervisa (rut_empleado, id_programas_deporte) VALUES(".$rut.", ".$programa.");";
    $insercion2 = pg_query($coneccion,$sql2);
    }else
    {
	$insercion2=true; //se deja true para que el checkeo despues pase correcto cuando programa sea ninguno
    }	

    if($insercion && $insercion2){ //si no hubo problemas con insert
    echo "Guardado con exito, vuelva a atras para continuar.";
    echo '<a href="IND_empleado_ingresar.php">Volver</a>';
    
	}
    else{
	echo pg_last_error($coneccion);
	echo "Se ha producido un error al guardar";
    echo '<a href="IND_empleado_ingresar.php">Volver</a>';
	}
    }
    }else
    {
	echo "<h3>Ingresar rut valido</h3>";
    echo '<a href="IND_empleado_ingresar.php">Volver</a>';
    }
}else{

    echo '<h3>ERROR CAMPOS VACIOS</h3><br>';
    echo '<a href="IND_empleado_ingresar.php">Volver</a>';
}



?>
