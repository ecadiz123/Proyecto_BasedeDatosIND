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
	echo '<a href="IND_programa_modificar.html">Volver</a>';


    }else{
    //si encuentra un programa o mas
    
	 echo "<b><h2>Resultados Busqueda</h2> </b>";
	echo '<form action= "IND_programa_modificar.php" method="post">';
   	 
   	 echo "<table> ";

   	 echo "<tr> ";
   	 echo "<td>Programa a Modificar:</td>";
   	 echo '<td><select name="id">';
   	     while($resultado_busqueda=pg_fetch_array($nombre_r))
   	     {
   	     $id=$resultado_busqueda["id"];
   	     $nombre=$resultado_busqueda["nombre"];
   	     //Se usa select para elegir resultado a modificar
   	     echo '<option value = "'.$id.'">'.$nombre.'</option>';//valor = id region
   	      }
   	echo '</select>';
   	echo "</tr>";
   	echo "<tr> ";
	echo '<td><input type="submit" value="Modificar"></td>';
   	echo "</tr>";
	echo "</table>";
	echo '</form>';
	echo '<a href="IND_programa_modificar.html">Volver</a>';
	}


}else{

    echo '<h3>ERROR CAMPOS VACIOS</h3><br>';
    echo '<a href="IND_programa_modificar.html">Volver</a>';
}



?>
