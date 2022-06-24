#!/bin/sh
echo Por favor, introduce nombre archivos quest a borrar sin .quest
read NOMBRE
find . -type f -name "$NOMBRE*"
echo borrar S/N
read borrar
if [ $borrar = "s" ]; then
find . -type f -name "$NOMBRE*" -exec rm -v {} \;
fi
