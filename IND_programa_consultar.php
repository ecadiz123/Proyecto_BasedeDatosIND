<?php
include 'Conexion.php';//$coneccion


if($_POST["nombre"]!='')//si no quedaron vacios
{

    $nombre=$_POST["nombre"];

    $nombre_q="select * from programa_deporte pd where nombre ilike '%".$nombre."%';"; //ilike : va a buscar independiente de las mayusculas todo lo que contenga lo que contenga lo ingresado
    $nombre_r=pg_query($coneccion,$nombre_q);
    if(pg_num_rows($nombre_r)==0)
    {	//si no hay programa de ese nombre
	echo '<h3>NO HAY RESULTADOS</h3>';
	echo '<a href="IND_programa_consultar.html">Volver</a>';


    }else{
    //si encuentra uno o mas programas
    
    echo "<b><h2>Resultados</h2> </b>";

	while($resultado_busqueda=pg_fetch_array($nombre_r))//impresion de programa
	{
	$id=$resultado_busqueda["id"];
	$nombre=$resultado_busqueda["nombre"];
	$descripcion=$resultado_busqueda["descripcion"];
	//<details>: es un elemento de html para colapsar un texto
	echo "<details>";
	    echo "<summary>".$nombre."</summary>";
	    echo "<hr>";
	    echo "<b><h4>ID=".$id."</h4></b>";
	    echo "<b><h4>Descripcion</h4></b>";
	    echo $descripcion;
	    echo "<hr>";
	    echo "<hr>";
	echo "<details>";
	    echo "<summary>Empleados Asociados</summary>";//Impresion de los empleados
	echo '<table>';
	echo '<tr>';
	echo '<td>Nombre</td>';
	echo '<td>Area</td>';
	echo '<td>Region</td>';
	echo '</tr>';
	
	//se buscan empleados asociados al programa junto con su area y region respectivas
	$empleados_q="	select e.nombre,a.nombre as area,r.nombre as region
			from empleado e,supervisa s , programa_deporte pd,direccion_regional dr,region r ,area a   
			where e.rut=s.rut_empleado 
			and pd.id=s.id_programas_deporte 
			and dr.id =e.direccion_regional 
			and r.id =dr.region 
			and e.id_area =a.id 
			and pd.id =$id";

	$empleados_r=pg_query($coneccion,$empleados_q);
	while($empleado_datos=pg_fetch_array($empleados_r))
	{	
	$n_empleado=$empleado_datos["nombre"];
	$area_empleado=$empleado_datos["area"];
	$region_empleado=$empleado_datos["region"];
	echo '<tr>';
	echo '<td>'.$n_empleado.'</td>';
	echo '<td>'.$area_empleado.'</td>';
	echo '<td>'.$region_empleado.'</td>';
	echo '</tr>';
	}

	echo '</table>';
	echo "</details>";
	echo "</details>";
	    echo "<hr>";
	echo '<br>';
	echo '<br>';
	 }
	echo '<a href="IND_programa_consultar.html">Volver</a>';
    }
}else{

    echo '<h3>ERROR CAMPOS VACIOS</h3><br>';
    echo '<a href="IND_programa_consultar.html">Volver</a>';
}



?>
