# Escriba su código aquí
sed 's|^\([0-9]\)/\([0-9]\)/*|0\1/0\2/|'g data.csv > out1						# Adiciona un cero (0) a las fechas que no lo tienen
sed 's|/\([0-9]\)\([0-9]\)\([0-9]\)\([0-9]\);|/\3\4;|'g out1 > out2				# Elimina el 20 del año que ingresó con formato diferente1
sed 's|[a-z]|\U&|g' out2 > out3													# Transforma en mayúsculas todas las letras que encuentre en minúsculas
sed 's|;\(N\)|;\\N|g' out3 > out4												# Reemplaza los campos que traes sólo "N" por "\N"
sed 's|;;|;\\N;|'g out4 > out5													# Reemplaza campos vacíos entre filas por "\N"
sed 's|;$|;\\N|g' out5 > out6													# Reemplaza campos vacíos del final de las líneas por "\N"
sed 's|\([0-9][0-9]\)/\([0-9][0-9]\)/\([0-9][0-9]\)|\3/\2/\1|' out6 > out7		# Cambia el orden de la fecha de DD/MM/YY a YY/MM/DD
sed 's|\([0-9][0-9]\)/\([0-9][0-9]\)/\([0-9][0-9]\)|20\1/\2/\3|' out7 > out8	# Adiciona el "20" al año
sed 's|/|-|g' out8 > out9														# Reemplaza el símbolo "/" por "-"
sed 's|,|.|g' out9 > out10														# Reemplaza el separador de decimales de "," por "."
sed 's|;|,|g' out10 > out11														# Reemplaza el separador ";" por ","
sed 's|,\([0-9]\)\([0-9]\)\([0-9]\)$|,\1\2\3.0|'g out11 > out12					# Adiciona el decimal a los números que no lo tienen
perl -pe 's|\n|\r\n|' out12 > out13												# Adiciona los caracteres no imprimibles CRLF
rm out*																			# Borra los archivos temporales generados