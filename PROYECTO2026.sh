#!/bin/bash

# Ultima actualización: 13/10/26
# date %{formato} -> Define que se mostrará con el comando date.
# EJ: %T hora, %Y año, %m mes, %d dia, %B mes del año.
# if [ -r/-w/-x "archivo ] -> Verifica si ese archivo tiene uno de esos permisos.

opcion=0

usuario_autorizado="admin"
clave="utubuceo"

archivo_log="log.txt"
if [ ! -f "$archivo_log" ]; then
	echo "El archivo log no existe, se creara uno nuevo."
	touch "$archivo_log"
fi

fecha_actual=$(date +"%d/%m/%Y - %T")
echo "Log de la fecha $fecha_actual" >> "$archivo_log"

while [ "$opcion" -ne 8 ]
do
	echo "[--------Menu--------]"
	echo "1. Directorios"
	echo "2. Archivos"
	echo "3. Agenda"
	echo "4. Modificar permisos"
	echo "5. Fecha y hora"
	echo "6. Mostrar mes del año"
	echo "7. Archivo de log"
	echo "8. Salir"
	echo "[--------------------]"

	read -p "Opción >> " opcion
	case $opcion in
		1)
			echo "[$(date +"%T") - $(whoami)]: Ingreso al menu 'Directorios'" >> "$archivo_log"
			echo "[--------Directorios--------]"
			echo "1. Crear directorio"
			echo "2. Eliminar directorio"
			echo "0. Volver al menu"
			echo "[---------------------------]"
			read -p "Opción >> " opcion_menu

			case $opcion_menu in
			1)
				read -p "Nombre del directorio a crear: " nombre
				if mkdir "$nombre" 2>/dev/null
				then
					echo "Se creo el directorio $nombre correctamente."
					echo "[$(date +"%T") - $(whoami)]: Se creo un nuevo directorio con el nombre $nombre" >> "$archivo_log"
				else

					echo "No se pudó crear el directorio $nombre, ya existe."
					echo "[$(date +"%T") - $(whoami)]: No se pudo crear el directorio $nombre, ya existe." >> "$archivo_log"
				fi
			;;
			2)
				read -p "Nombre del directorio a eliminar: " nombre
				if rmdir "$nombre" 2>/dev/null
				then
					echo "Se eliminó el directorio correctamente."
					echo "[$(date +"%T") - $(whoami)]: Se elimino un directorio con el nombre $nombre." >> "$archivo_log"
				else
					echo "No se pudó borrar el directorio, verifique que exista y este vácio."
					echo "[$(date +"%T") - $(whoami)]: No se pudo eliminar el directorio $nombre, no existe o no esta vacio." >> "$archivo_log"
				fi
			;;
			0)
				echo "[$(date +"%T") - $(whoami)]: Volvio al menu principal." >> "$archivo_log"
				echo "Volviendo al menu principal."
			;;
			*)
				echo "[$(date +"%T") - $(whoami)]: Ingreso una opcion invalida." >> "$archivo_log"
				echo "Opción inválida"
			;;
		esac
		;;
		2)
			echo "[$(date +"%T") - $(whoami)]: Ingreso al menu 'Archivos'" >> "$archivo_log"
			echo "[--------Archivos--------]"
			echo "1. Eliminar archivo"
			echo "2. Copiar archivo"
			echo "3. Mover archivo"
			echo "4. Permisos de un archivo"
			echo "5. Listar archivos de un directorio"
			echo "0. Volver al menu"
			echo "[------------------------]"
			read -p "Opción >> " opcion_menu

			case $opcion_menu in
				1)
					read -p "Nombre del archivo a eliminar: " nombre
					if rm "$nombre"
					then
						echo "Se eliminó el archivo correctamente"
						echo "[$(date +"%T") - $(whoami)]: Se elimino el archivo $nombre" >> "$archivo_log"
					else
						echo "No se pudó eliminar el archivo"
						echo "[$(date +"%T") - $(whoami)]: No se pudo eliminar el archivo $nombre" >> "$archivo_log"
					fi
				;;
				2)
					read -p "Nombre del archivo a copiar: " nombre
					read -p "Ruta a donde copiar el archivo: " ruta
					if cp "$nombre" "$ruta"
					then
						echo "Se copió el archivo correctamente."
						echo "[$(date +"%T") - $(whoami)]: Se copio el archivo $nombre a $ruta" >> "$archivo_log"
					else
						echo "No se pudó copiar el archivo."
						echo "[$(date +"%T") - $(whoami)]: No se pudo copiar el archivo $nombre a $ruta" >> "$archivo_log"
					fi
				;;
				3)
					read -p "Nombre del archivo a mover: " nombre
					read -p "Ruta a donde copiar el archivo: " ruta
					if mv "$nombre" "$ruta"
					then
						echo "Se movió el archivo correctamente."
						echo "[$(date +"%T") - $(whoami)]: Se movio el archivo $nombre a $ruta" >> "$archivo_log"
					else
						echo "No se pudó copiar el archivo."
						echo "[$(date +"%T") - $(whoami)]: No se pudo mover el archivo $nombre a $ruta" >> "$archivo_log"
					fi
				;;
				4)
					read -p "Nombre del archivo: " nombre
					if [ -f "$nombre" ]; then
						if [ -r "$nombre" ]; then
							echo "El archivo tiene permisos de lectura."
						fi
						if [ -w "$nombre" ]; then
							echo "El archivo tiene permisos de escritura."
						fi
						if [ -x "$nombre" ]; then
							echo "El archivo tiene permisos de ejecución."
						fi
						echo "[$(date +"%T") - $(whoami)]: Pregunto que permisos tiene el archivo $nombre" >> "$archivo_log"
					else
						echo "El archivo $nombre no existe."
						echo "[$(date +"%T") - $(whoami)]: No se pudo consultar los permisos del archivo $nombre, no existe." >> "$archivo_log"
					fi
				;;
				5)
					read -p "Nombre del directorio: " nombre
					if ls "$nombre"
					then
						echo "[$(date +"%T") - $(whoami)]: Listo archivos del directorio $nombre " >> "$archivo_log"
					else
						echo "[$(date +"%T") - $(whoami)]: No se pudo listar los archivos del directorio $nombre " >> "$archivo_log"
					fi
				;;
				0)
					echo "Volviendo al menu principal:"
					echo "[$(date +"%T") - $(whoami)]: Volvio al menu principal." >> "$archivo_log"
				;;
				*)
					echo "Opción inválida."
					echo "[$(date +"%T") - $(whoami)]: Ingreso una opcion invalida." >> "$archivo_log"
				;;
			esac
		;;
		3)
			echo "[$(date +"%T") - $(whoami)]: Ingreso al menu 'Agenda'" >> "$archivo_log"
			agenda_nombre="agenda.txt"
			if [ ! -f "$agenda_nombre" ]; then
				echo "El archivo $agenda_nombre no existe, se creó uno nuevo."
			else
				echo "Se cargo el archivo $agenda_nombre correctamente."
			fi
			echo "[$(date +"%T") - $(whoami)]: Se verifico la existencia del archivo $agenda_nombre" >> "$archivo_log"

			echo "[--------AGENDA--------]"
			echo "1. Agregar contacto"
			echo "2. Listar contactos"
			echo "3. Ver contacto"
			echo "4. Buscar información de un contacto"
			echo "5. Eliminar contacto"
			echo "6. Modificar telefono"
			echo "0. Volver al menu"
			echo "[----------------------]"

			read -p "Opción >> " opcion_menu
			case $opcion_menu in
				1)
					read -p "Ingrese la CI: " ci
					read -p "Ingrese el nombre: " nombre
					read -p "Ingrese el apellido: " apellido
					read -p "Ingrese el número de telefono: " telefono
					read -p "Ingrese la fecha de nacimiento (dia/mes/año) " fecha
					echo "$ci:$nombre:$apellido:$telefono:$fecha" >> "$agenda_nombre"
					echo "[$(date +"%T") - $(whoami)]: Se agrego el contacto $nombre." >> "$archivo_log"
				;;
				2)
					cat "$agenda_nombre"
					echo "[$(date +"%T") - $(whoami)]: Se listaron todos los contactos." >> "$archivo_log"
				;;
				3)
					read -p "Ingrese la linea a visualizar: " linea
					head -n "$linea" "$agenda_nombre" | tail -n 1
					echo "[$(date +"%T") - $(whoami)]: Se visualizo el contacto de la linea $linea." >> "$archivo_log"
				;;
				4)
					read -p "Ingrese la CI: " ci
					read -p "Ingrese número de campo a mostrar (1=CI, 2=nombre, 3=apellido, 4=teléfono, 5=fecha): " campo
					encontrado=0
					while read -r linea
					do
						ci_linea=$(echo "$linea" | cut -d":" -f1)
						if [ "$ci_linea" = "$ci" ]
						then
							encontrado=1
							echo "$linea" | cut -d":" -f"$campo"
						fi
					done < "$agenda_nombre"
					if [ "$encontrado" -eq 1 ]
					then
						echo "[$(date +"%T") - $(whoami)]: Se busco informacion sobre el contacto cuya CI es $ci" >> "$archivo_log"
					else
						echo "No se encontró ningún contacto con CI $ci."
						echo "[$(date +"%T") - $(whoami)]: Se busco el contacto cuya CI es $ci, no existe." >> "$archivo_log"
					fi
				;;
				5)
					read -p "Ingrese la CI del contacto a eliminar: " ci
					temporal="agenda_temp.txt"
					: > "$temporal"
					encontrado=0
					while read -r linea
					do
						ci_linea=$(echo "$linea" | cut -d":" -f1)
						if [ "$ci_linea" = "$ci" ]
						then
							encontrado=1
						else
							echo "$linea" >> "$temporal"
						fi
					done < "$agenda_nombre"
					mv "$temporal" "$agenda_nombre"
					if [ "$encontrado" -eq 1 ]
					then
							echo "Se eliminó el contacto con CI $ci correctamente."
						echo "[$(date +"%T") - $(whoami)]: Se elimino el contacto cuya CI es $ci" >> "$archivo_log"
					else
						echo "No se encontró ningún contacto con CI $ci."
						echo "[$(date +"%T") - $(whoami)]: No se pudo eliminar el contacto cuya CI es $ci, no existe." >> "$archivo_log"
					fi
				;;
				6)
					read -p "Ingrese la CI del contacto: " ci
					read -p "Ingrese el nuevo número de telefono: " telefono_nuevo
					temporal="agenda_temp.txt"
					: > "$temporal"
					encontrado=0
					while read -r linea
					do
						ci_linea=$(echo "$linea" | cut -d":" -f1)
						if [ "$ci_linea" = "$ci" ]
						then
							encontrado=1
							nombre_c=$(echo "$linea" | cut -d":" -f2)
							apellido_c=$(echo "$linea" | cut -d":" -f3)
							resto_c=$(echo "$linea" | cut -d":" -f5-)
							echo "$ci:$nombre_c:$apellido_c:$telefono_nuevo:$resto_c" >> "$temporal"
						else
							echo "$linea" >> "$temporal"
						fi
					done < "$agenda_nombre"
					mv "$temporal" "$agenda_nombre"
					if [ "$encontrado" -eq 1 ]
					then
						echo "Se modificó el telefono del contacto con CI $ci correctamente."
						echo "[$(date +"%T") - $(whoami)]: Se modifico el telefono del contacto cuya CI es $ci" >> "$archivo_log"
					else
						echo "No se encontró ningún contacto con CI $ci."
						echo "[$(date +"%T") - $(whoami)]: No se pudo modificar el telefono del contacto cuya CI es $ci, no existe." >> "$archivo_log"
					fi
				;;
				0)
					echo "Volviendo al menu principal."
					echo "[$(date +"%T") - $(whoami)]: " >> "$archivo_log"
				;;
				*)
					echo "Opción inválida."
					echo "[$(date +"%T") - $(whoami)]: Ingreso una opcion invalida" >> "$archivo_log"
				;;
			esac
		;;
		4)
			echo "[$(date +"%T") - $(whoami)]: Ingreso al menu 'Permisos'" >> "$archivo_log"
			echo "[----Permisos----]"
			echo "1. Agregar permiso"
			echo "2. Quitar permiso"
			echo "0. Volver"
			echo "[----------------]"
			read -p "Opción >> " opcion_menu
			case $opcion_menu in
				1)
					read -p "Ingrese el nombre del archivo: " nombre
					echo "[----Permisos---]"
					echo "1. Lectura"
					echo "2. Escritura"
					echo "3. Ejecución"
					echo "0. Volver al menu"
					echo "[---------------]"

					read -p "Opción >> " opcion_menu
					case $opcion_menu in
						1)
							if chmod +r "$nombre"
							then
								echo "Se agregó el permiso correctamente."
								echo "[$(date +"%T") - $(whoami)]: Agrego permisos al archivo $nombre" >> "$archivo_log"
							else
								echo "No se pudó agregar el permiso."
								echo "[$(date +"%T") - $(whoami)]: No se pudo agregar permisos al archivo $nombre" >> "$archivo_log"
							fi
						;;
						2)
							if chmod +w "$nombre"
							then
								echo "Se agregó el permiso correctamente."
								echo "[$(date +"%T") - $(whoami)]: Agrego permisos al archivo $nombre" >> "$archivo_log"
							else
								echo "No se pudó agregar el permiso."
								echo "[$(date +"%T") - $(whoami)]: No se pudo agregar permisos al archivo $nombre" >> "$archivo_log"
							fi
						;;
						3)
							if chmod +x "$nombre"
							then
								echo "Se agregó el permiso correctamente."
								echo "[$(date +"%T") - $(whoami)]: Agrego permisos al archivo $nombre" >> "$archivo_log"
							else
								echo "No se pudó agregar el permiso."
								echo "[$(date +"%T") - $(whoami)]: No se pudo agregar permisos al archivo $nombre" >> "$archivo_log"
							fi
						;;
						0)
							echo "Volviendo al menu principal."
							echo "[$(date +"%T") - $(whoami)]: Volvio al menu principal." >> "$archivo_log"
						;;
						*)
							echo "Permiso inválido."
							echo "[$(date +"%T") - $(whoami)]: Ingreso una opcion invalida." >> "$archivo_log"
						;;
					esac
				;;
				2)
					read -p "Ingrese el nombre del archivo: " nombre
					echo "[----Permisos----]"
					echo "1. Lectura"
					echo "2. Escritura"
					echo "3. Ejecución"
					echo "0. Volver al menu"
					echo "[----------------]"

					read -p "Opción >> " opcion_menu
					case $opcion_menu in
						1)
							if chmod -r "$nombre"
							then
								echo "Se quitó el permiso correctamente."
								echo "[$(date +"%T") - $(whoami)]: Quito permisos al archivo $nombre" >> "$archivo_log"
							else
								echo "No se pudó quitar el permiso."
								echo "[$(date +"%T") - $(whoami)]: No se pudo quitar permisos al archivo $nombre" >> "$archivo_log"
							fi
						;;
						2)
							if chmod -w "$nombre"
							then
								echo "Se quitó el permiso correctamente."
								echo "[$(date +"%T") - $(whoami)]: Quito permisos al archivo $nombre" >> "$archivo_log"
							else
								echo "No se pudó quitar el permiso."
								echo "[$(date +"%T") - $(whoami)]: No se pudo quitar permisos al archivo $nombre" >> "$archivo_log"
							fi
						;;
						3)
							if chmod -x "$nombre"
							then
								echo "Se quitó el permiso correctamente."
								echo "[$(date +"%T") - $(whoami)]: Quito permisos al archivo $nombre" >> "$archivo_log"
							else
								echo "No se pudó quitar el permiso."
								echo "[$(date +"%T") - $(whoami)]: No se pudo quitar permisos al archivo $nombre" >> "$archivo_log"
							fi
						;;
						0)
							echo "Volviendo al menu principal."
							echo "[$(date +"%T") - $(whoami)]: Volvio al menu principal." >> "$archivo_log"
						;;
						*)
							echo "Permiso inválido."
							echo "[$(date +"%T") - $(whoami)]: Ingreso una opcion invalida." >> "$archivo_log"
						;;
					esac
				;;
				0)
					echo "Volviendo al menu principal."
					echo "[$(date +"%T") - $(whoami)]: Volvio al menu principal." >> "$archivo_log"
				;;
				*)
					echo "Opcion invalida."
					echo "[$(date +"%T") - $(whoami)]: Ingreso una opcion invalida." >> "$archivo_log"
				;;
			esac
		;;
		5)
			echo "[$(date +"%T") - $(whoami)]: Ingreso al menu de 'Fecha y hora'" >> "$archivo_log"

			echo "$(date +"%Y/%m/%d")"

			dia=$(date +"%d") # %d -> dia numerico del mes
			mes=$(date +"%B") # %B -> nombre del mes
			anio=$(date +"%Y") #%Y año actual
			echo "Hoy es $dia de $mes del año $anio"

			dias_pasados=$(date +"%j")
			echo "Han pasado $dias_pasados desde el comienzo del año."
		;;
		6)
			echo "[$(date +"%T") - $(whoami)]: Ingreso al menu de 'Mostrar mes del año'" >> "$archivo_log"

			echo "[------Calendario------]"
			read -p "Ingrese el mes a mostrar: " mes
			anio=$(date +"%Y")
			if cal "$mes" "$anio"
			then
				echo "[$(date +"%T") - $(whoami)]: Se mostro el mes $mes del año $anio" >> "$archivo_log"
			else
				echo "[$(date +"%T") - $(whoami)]: No se pudo mostrar el mes $mes del año $anio" >> "$archivo_log"
			fi
		;;
		7)
			echo "[$(date +"%T") - $(whoami)]: Ingreso al menu 'Archivo de log'" >> "$archivo_log"
			echo "[--------Log--------]"
			echo "1. Eliminar log"
			echo "0. Volver al menu"
			echo "[-------------------]"
			read -p "Opción >> " opcion_menu
			case $opcion_menu in
				1)
					read -p "Ingrese el usuario: " usuario_ingresado
					read -p "Ingrese la contraseña: " clave_ingresada
					if [ "$usuario_ingresado" = "$usuario_autorizado" ] && [ "$clave_ingresada" = "$clave" ]
					then
						rm "$archivo_log"
						echo "Se eliminó el log correctamente."
						echo "[$(date +"%T") - $(whoami)]: Se elimino el log (usuario autorizado $usuario_ingresado)." >> "$archivo_log"
					else
						echo "Usuario o contraseña incorrectos, no se eliminó el log."
						echo "[$(date +"%T") - $(whoami)]: Intento fallido de eliminar el log con el usuario $usuario_ingresado." >> "$archivo_log"
					fi
				;;
				0)
					echo "Volviendo al menu principal."
					echo "[$(date +"%T") - $(whoami)]: Volvio al menu principal." >> "$archivo_log"
				;;
				*)
					echo "Opción inválida."
					echo "[$(date +"%T") - $(whoami)]: Ingreso una opcion invalida." >> "$archivo_log"
				;;
			esac
		;;
		8)
			echo "[$(date +"%T") - $(whoami)]: Termino la sesion" >> "$archivo_log"
			echo "Saliendo..."
		;;
	esac
done
