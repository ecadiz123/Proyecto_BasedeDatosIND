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

	while($resultado_busqueda=pg_fetch_array($nombre_r))
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
	echo "</details>";
	 }
	echo '<a href="IND_programa_consultar.html">Volver</a>';
    }
}else{

    echo '<h3>ERROR CAMPOS VACIOS</h3><br>';
    echo '<a href="IND_programa_consultar.html">Volver</a>';
}



?>
