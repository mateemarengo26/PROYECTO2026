#!/bin/bash

# Ultima actualización: 29/9/26
opcion=0

while [ $opcion -ne 7 ]
do
	echo "[--------Menu--------]"
	echo "1. Directorios"
	echo "2. Archivos"
	echo "3. Agenda"
	echo "4. Modificar permisos"
	echo "5. Fecha y hora"
	echo "6. Mostrar mes del año"
	echo "7. Salir"
	echo "[--------------------]"
	
	read -p "Opción >> " opcion
	case $opcion in
		1)
			echo "[--------Directorios--------]"
			echo "1. Crear directorio"
			echo "2. Eliminar directorio"
			echo "3. Agenda"
			echo "0. Volver al menu"
			echo "[---------------------------]"
			read -p "Opción >> " opcion_menu

			case $opcion_menu in
			1)
				read -p "Nombre del directorio a crear: " nombre
				if mkdir $nombre 2>/dev/null
				then
					echo "Se creo el directorio $nombre correctamente."
				else

					echo "No se pudó crear el directorio $nombre, ya existe."
				fi
			;;
			2)
				read -p "Nombre del directorio a eliminar: " nombre
				if rmdir $nombre 2>/dev/null
				then
					echo "Se eliminó el directorio correctamente."
				else
					echo "No se pudó borrar el directorio, verifique que exista y este vácio."
				fi
			;;
			0)
				echo "Volviendo al menu principal."
			;;
			*)
				echo "Opción inválida"
			;;
		esac
		;;
		2)
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
					if rm $nombre
					then
						echo "Se eliminó el archivo correctamente"
					else
						echo "No se pudó eliminar el archivo"
					fi
				;;
				2)
					read -p "Nombre del archivo a copiar: " nombre
					read -p "Ruta a donde copiar el archivo: " ruta
					if cp $nombre $ruta
					then
						echo "Se copió el archivo correctamente."
					else
						echo "No se pudó copiar el archivo."
					fi
				;;
				3)
					read -p "Nombre del archivo a mover: " nombre
					read -p "Ruta a donde copiar el archivo: " ruta
					if mv $nombre $ruta
					then
						echo "Se movió el archivo correctamente."
					else
						echo "No se pudó copiar el archivo."
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
					fi

				;;
				5)
					read -p "Nombre del directorio: " nombre
					ls $nombre
				;;
				0)
					echo "Volviendo al menu principal:"
				;;
				*)
					echo "Opción inválida."
				;;
			esac
		;;
		3)
			agenda_nombre="agenda.txt"
			if touch $agenda_nombre
			then
				echo "El archivo $agenda_nombre no existe, se creó uno nuevo."
			else
				echo "Se cargo el archivo $agenda_nombre correctamente."
			fi

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
					echo "$ci:$nombre:$apellido:$telefono$fecha" >> $nombre_agenda
				;;
				2)
					cat $nombre_agenda
				;;
				3)
					read -p "Ingrese la linea a visualizar: " linea
					head -n $linea $nombre_agenda | tail -n 1
				;;
				4)
					read -p "Ingrese la CI: " ci
					read -p "Ingrese número de campo a mostrar: " campo
					cut -d":" -f$campo $nombre_agenda
				;;
				5)
					echo "sin terminar"
				;;
				6)
					echo "sin terminar"
				;;
				0)
					echo "Volviendo al menu principal."
				;;
				*)
					echo "Opción inválida."
				;;
			esac
		;;
		4)
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
							chmod +r nombre	
						;;
						2)
							chmod +w nombre
						;;
						3)
							chmod +x nombre
						;;
						0)
							echo "Volviendo al menu principal."
						;;
						*)
							echo "Permiso inválido."
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
							chmod -r nombre
						;;
						2)
							chmod -w nombre
						;;
						3)
							chmod -x nombre
						;;
						0)
							echo "Volviendo al menu principal."
						;;
						*)
							echo "Permiso inválido."
						;;
					esac
				;;
				0)
					echo "Volviendo al menu principal"
				;;
				*)

				;;
			esac
i
		;;
		5)
			# año/mes/dia

			# Hoy es {dia} de {mes} del año {año}
			
			# Han pasado {dias} desde el comienzo del año.
			
		;;
		6)
			echo "en proceso"
		;;
		7)
			echo "Saliendo..."
		;;
	esac
done


