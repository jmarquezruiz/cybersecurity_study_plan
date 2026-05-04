#!/bin/bash

# Script para escanear rutas con gobuster
# Uso: ./scan.sh

read -p "Introduce la URL (ej: https://example.com): " url

# Wordlist por defecto
wordlist="/usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt"

echo "-----------------------------------------------------"
echo " Ejecutando Gobuster en $url"
echo " Wordlist: $wordlist"
echo "-----------------------------------------------------"

# Si quieres ignorar longitudes fijas (ajústalo según tu servidor)
gobuster dir -u "$url" -w "$wordlist" --exclude-length 1033 -t 20
gobuster dir -u "$url" -w "$wordlist" --exclude-length 172 -t 20
