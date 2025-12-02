<?php
include 'Conexion.php';//$coneccion

$id= $_POST["id"];
$nombre=$_POST["nombre"];
$desc=$_POST["descripcion"];
echo var_dump($id);
echo var_dump($nombre);
echo var_dump($desc);
//actualizacion nuevo nombre
if($_POST["nombre"]!='')
{
    $nombre_q="UPDATE programa_deporte SET nombre='$nombre' WHERE id=$id;";
    $nombre_r=pg_query($coneccion,$nombre_q);
    if($nombre_r)
    {
    echo '<h3>Nombre cambiado con exito.</h3><br>';
    }
}
//actualizacion descripcion
if($_POST["descripcion"]!='')
{
    $desc_q="UPDATE programa_deporte SET descripcion='$desc' WHERE id=$id;";
    $desc_r=pg_query($coneccion,$desc_q);
    if($desc_r)
    {
    echo '<h3>Descripcion cambiada con exito.</h3><br>';
    }
}
//si ambos campos vacios
if($desc == '' and $nombre =='')
{
    echo '<h3>Campos ingresados vacios, no hubo cambios</h3><br>';
}
    echo '<a href="IND_programa_modificar.html">Volver</a>';


?>
