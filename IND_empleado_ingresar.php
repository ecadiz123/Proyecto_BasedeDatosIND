<?php
//Se imprime mediante php para poder acceder a ciertos registros de la base de datos
include 'Conexion.php';//$coneccion

echo "<html>";
echo "<head>";
echo "<title> IND - Ingreso Empleado</title>";
echo "</head>";

echo "<body>";
echo "<hr>";
echo "<h3>Ingreso de nuevo Empleado</h3>";
echo "<p>Ingrese datos de nuevo empleado</p>";
//form y tabla para ingreso de empleado
echo '<form id="ingreso_empleado" action="IND_ingreso_empleado_sql.php" method="post">';
echo "<table> <!-- tabla para el formato-->";
//rut
echo "<tr> <!-- fila tabla -->";
echo "<td>Rut:</td><!-- td: columna tabla-->";
echo '<td><input type="text" name="rut"></td>';
echo "</tr>";
//nombre
echo "<tr>";
echo "<td>Nombre Completo:</td>";
echo '<td><input type="text" name="nombre"></td>';
echo "</tr>";
//correo
echo "<tr>";
echo "<td>Correo:</td>";
echo '<td><input type="text" name="correo"></td>';
echo "</tr>";
//telefono
echo "<tr>";
echo "<td>Telefono:</td>";
echo '<td><input type="text" name="telefono"></td>';
echo "</tr>";
//direccion regional
echo "<tr>";
echo "<td>Direccion Regional:</td>";
echo '<td><select name="region">';
// se accede a base de datos para colocar las regiones que tengan direccion regional
$regiones_q = "select r.id,r.nombre from region r, direccion_regional dr where dr.region=r.id;";
$region_result=pg_query($coneccion,$regiones_q);
while($region_datos = pg_fetch_array($region_result))
{
echo '<option value = "'.$region_datos["id"].'">'.$region_datos["nombre"].'</option>';//valor = id region

}
echo '</select>';
echo "</td>";
echo "</tr>";

//Area
echo "<tr>";
echo "<td>Area:</td>";
echo '<td><select name="area">';
// se pregunta a base de datos las areas
$area_q = "select id, nombre from area;";
$area_result=pg_query($coneccion,$area_q);
while($area_datos = pg_fetch_array($area_result))
{
echo '<option value = '.$area_datos["id"].'>'.$area_datos["nombre"].'</option>';//valor = id region

}
echo '</select>';
echo "</td>";
echo "</tr>";

//Programa
echo "<tr>";
echo "<td>Programa al cual estara asociado:</td>";
echo '<td><select name="programa">';
// se accede a base de datos para colocar programas existentes
echo '<option value = 0>Ninguno</option>';
$programa_q = "select id, nombre from programa_deporte pd;";
$programa_result=pg_query($coneccion,$programa_q);
while($programa_datos = pg_fetch_array($programa_result))
{
echo '<option value = '.$programa_datos["id"].'>'.$programa_datos["nombre"].'</option>'; // valor= id programa, 0 si es ninguno

}
echo '</select>';
echo "</td>";
echo "</tr>";

//submit
echo "<tr>";
echo '<td><input type="submit" value="Ingresar"></td>';
echo "</tr>";

echo "</form>";
echo "<hr>";
echo "</body>";

echo "</html>";
?>
