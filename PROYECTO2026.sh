#!/bin/bash

# Ultima actualización: 29/9/26
opcion=0

archivo_log="log.txt"
if [ ! -f "$archivo_log" ]; then
	echo "El archivo log no existe, se creara uno nuevo."
	touch $archivo_log
fi

fecha_actual=$(date +"%d/%m/%Y - %T")
echo "Log de la fecha $fecha_actual" >> $archivo_log

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
			echo "[$(date +"%T") - $(whoami)]: Ingreso al menu 'Directorios'" >> $archivo_log
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
				echo "[$(date +"%T") - $(whoami)]: Se creo un nuevo directorio con el nombre $nombre" >> $archivo_log
			;;
			2)
				read -p "Nombre del directorio a eliminar: " nombre
				if rmdir $nombre 2>/dev/null
				then
					echo "Se eliminó el directorio correctamente."
				else
					echo "No se pudó borrar el directorio, verifique que exista y este vácio."
				fi
				echo "[$(date +"%T") - $(whoami)]: Se elimino un directorio con el nombre $nombre." >> $archivo_log
			;;
			0)
				echo "[$(date +"%T") - $(whoami)]: Volvio al menu principal." >> $archivo_log
				echo "Volviendo al menu principal."
			;;
			*)
				echo "[$(date +"%T") - $(whoami)]: Ingreso una opcion invalida." >> $archivo_log
				echo "Opción inválida"
			;;
		esac
		;;
		2)
			echo "[$(date +"%T") - $(whoami)]: Ingreso al menu 'Archivos'" >> $archivo_log
			echo "[--------Archivos--------]"
			echo "1. Eliminar archivo"
			echo "2. Copiar archivo"
			echo "3. Mover archivo"
			echo "4. Permisos de un archivo"
			echo "5. Listar archivos de un directorio"
			echo "0. Volver al menu"
			echo "[------------------------]"
			read -p "Opción >> " opcion_menu
			
			# Agregar opcion de crear archivo nuevo (no existe)
			case $opcion_menu in
				1)
					read -p "Nombre del archivo a eliminar: " nombre
					if rm $nombre
					then
						echo "Se eliminó el archivo correctamente"
					else
						echo "No se pudó eliminar el archivo"
					fi
					echo "[$(date +"%T") - $(whoami)]: Se elimino el archivo $nombre" >> $archivo_log
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
					echo "[$(date +"%T") - $(whoami)]: Se copio el archivo $nombre a $ruta" >> $archivo_log
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
					echo "[$(date +"%T") - $(whoami)]: Se movio el archivo $nombre a $ruta" >> $archivo_log
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
					echo "[$(date +"%T") - $(whoami)]: Pregunto que permisos tiene el archivo $nombre" >> $archivo_log
				;;
				5)
					read -p "Nombre del directorio: " nombre
					ls $nombre
					echo "[$(date +"%T") - $(whoami)]: Listo archivos del directorio $nombre " >> $archivo_log
				;;
				0)
					echo "Volviendo al menu principal:"
					echo "[$(date +"%T") - $(whoami)]: Volvio al menu principal." >> $archivo_log
				;;
				*)
					echo "Opción inválida."
					echo "[$(date +"%T") - $(whoami)]: Ingreso una opcion invalida." >> $archivo_log
				;;
			esac
		;;
		3)
			echo "[$(date +"%T") - $(whoami)]: Ingreso al menu 'Agenda'" >> $archivo_log
			agenda_nombre="agenda.txt"
			if touch $agenda_nombre
			then
				echo "El archivo $agenda_nombre no existe, se creó uno nuevo."
			else
				echo "Se cargo el archivo $agenda_nombre correctamente."
			fi
			echo "[$(date +"%T") - $(whoami)]: Se verifico la existencia del archivo $agenda_nombre" >> $archivo_log

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
					echo "[$(date +"%T") - $(whoami)]: Se agrego el contacto $nombre." >> $archivo_log
				;;
				2)
					cat $nombre_agenda
					echo "[$(date +"%T") - $(whoami)]: Se listaron todos los contactos." >> $archivo_log
				;;
				3)
					read -p "Ingrese la linea a visualizar: " linea
					head -n $linea $nombre_agenda | tail -n 1
					echo "[$(date +"%T") - $(whoami)]: Se visualizo el contacto de la linea $linea." >> $archivo_log
				;;
				4)
					read -p "Ingrese la CI: " ci
					read -p "Ingrese número de campo a mostrar: " campo
					cut -d":" -f$campo $nombre_agenda
					echo "[$(date +"%T") - $(whoami)]: Se busco informacion sobre el contacto cuya CI es $ci" >> $archivo_log
				;;
				5)
					echo "sin terminar"
					echo "[$(date +"%T") - $(whoami)]: " >> $archivo_log
				;;
				6)
					echo "sin terminar"
					echo "[$(date +"%T") - $(whoami)]: " >> $archivo_log
				;;
				0)
					echo "Volviendo al menu principal."
					echo "[$(date +"%T") - $(whoami)]: " >> $archivo_log
				;;
				*)
					echo "Opción inválida."
					echo "[$(date +"%T") - $(whoami)]: Ingreso una opcion invalida" >> $archivo_log
				;;
			esac
		;;
		4)
			echo "[$(date +"%T") - $(whoami)]: Ingreso al menu 'Permisos'" >> $archivo_log
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
					echo "[$(date +"%T") - $(whoami)]: Agrego permisos al archivo $nombre" >> $archivo_log	
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
					echo "[$(date +"%T") - $(whoami)]: Quito permisos al archivo $nombre" >> $archivo_log
				;;
				0)
					echo "Volviendo al menu principal."
					echo "[$(date +"%T") - $(whoami)]: Volvio al menu principal." >> $archivo_log
				;;
				*)
					echo "Opcion invalida."
					echo "[$(date +"%T") - $(whoami)]: Ingreso una opcion invalida." >> $archivo_log
				;;
			esac
		;;
		5)
			echo "[$(date +"%T") - $(whoami)]: Ingreso al menu de 'Fecha y hora'" >> $archivo_log
			# año/mes/dia
			echo $(date +"%Y/%m/%d")
			
			# Hoy es {dia} de {mes} del año {año}
			dia=$(date +"%d") # %d -> dia numerico del mes
			mes=$(date +"%B") # %B -> nombre del mes
			anio=$(date +"%Y") #%Y año actual
			echo "Hoy es $dia de $mes del año $anio"

			# Han pasado {dias} desde el comienzo del año.
			dias_pasados=$(date +"%j")
			echo "Han pasado $dias_pasados desde el comienzo del año."
		;;
		6)
			echo "[$(date +"%T") - $(whoami)]: Ingreso al menu de 'Mostrar mes del año'" >> $archivo_log
			# Mostrar mes con formato de calendario según el nro mes ingresado
			echo "[------Calendario------]" 
			read -p "Ingrese el mes a mostrar: " mes
			anio=$(date +"%Y")
			cal $mes $anio
			echo "[$(date +"%T") - $(whoami)]: Se mostro el mes $mes del año $anio" >> $archivo_log	 
		;;
		7)
			echo "[$(date +"%T") - $(whoami)]: Termino la sesion" >> $archivo_log
			echo "Saliendo..."
		;;
	esac
done


