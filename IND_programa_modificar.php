<?php
include 'Conexion.php';//$coneccion


if($_POST["id"]!='')//si no quedaron vacios
{

    $id=$_POST["id"];

    $id_q="select * from programa_deporte pd where id =$id";
    $id_r=pg_query($coneccion,$id_q);
    if(pg_num_rows($id_r)==0)
    {	//Si no existe programa con esa id
	echo '<h3>ERROR PROGRAMA NO EXISTE, INGRESAR PROGRAMA VALIDO</h3>';
	echo '<a href="IND_programa_modificar.html">Volver</a>';


    }else{
    //Si existe el programa
    $programa=pg_fetch_array($id_r);
    $id=$programa["id"];
    $nombre=$programa["nombre"];
    $desc=$programa["descripcion"];
    //Se imprimen datos actuales
	    echo "<hr>";
    echo '<h3>DATOS ACTUALES:</h3><br>';
    
	    echo "<b><h4>Nombre=".$nombre."</h4></b>";
	    echo "<b><h4>ID=".$id."</h4></b>";
	    echo "<b><h4>Descripcion:</h4></b>";
	    echo $desc;
	    echo "<hr>";
	    echo "<hr>";
    echo '<h3>NUEVOS DATOS:</h3><br>';
    echo '<h4>(Advertencia: Reemplazan datos anteriores. No se permite reemplazar ID)</h4>';
    echo '<h4>Si no desea modificar campo, dejarlo vacio</h4>';
    
	    echo '<table>';
	    echo '<form action= "IND_programa_update.php" method="post">';
	    echo '<tr>';
	    echo '<td>Nombre:</td>';
	    echo '<td><input type="text" name="nombre"></td>';
	    echo '</tr>';
	    echo '<tr>';
	    echo '<td>Descripcion:</td>';
	    echo '<td><input type="textarea" name="descripcion"></td>';
	    echo '</tr>';
	    echo '<tr>';
	    echo '<input type="hidden" name="id" value='.$id.'>';//hidden para pasar id a traves de post en la misma form sin pedirlo
	    echo '<td><input type="submit" value="Modificar"></td>';
	    echo '</tr>';
	    echo '</form>';
	    echo '</table>';
	    echo '<hr>';
	echo '<a href="IND_programa_modificar.html">Volver</a>';
    }

}else{

    echo '<h3>ERROR CAMPOS VACIOS</h3><br>';
    echo '<a href="IND_programa_modificar.html">Volver</a>';
}



?>
