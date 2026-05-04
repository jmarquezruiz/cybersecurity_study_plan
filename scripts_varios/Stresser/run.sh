#!/bin/bash

# Función para verificar la IP pública actual
get_current_ip() {
  echo "Obteniendo tu IP pública actual..."
  CURRENT_IP=$(curl -s https://check.torproject.org/api/ip | jq -r .IP)
  echo "Tu IP actual es: $CURRENT_IP"
}

# Función para activar Tor y verificar la nueva IP
enable_tor_and_check_ip() {
  echo "Activando Tor..."
  sudo systemctl start tor.service

  echo "Verificando la nueva IP a través de Tor..."
  TOR_IP=$(curl --socks5 localhost:9050 -s https://check.torproject.org/api/ip | jq -r .IP)
  echo "Tu nueva IP (a través de Tor) es: $TOR_IP"
}

# Función para ejecutar el test de carga con k6 y proxychains
run_stress_test() {
  read -p "Introduce la URL objetivo (ejemplo: https://example.com): " URL

  if [[ "$CHOICE1" =~ ^[Yy]$ ]]; then
    echo "Ejecutando el test de carga con k6 y proxychains..."
    K6_URL="$URL" proxychains -q k6 run script.js
  else
    echo "Ejecutando el test de carga con k6."
    K6_URL="$URL" k6 run script.js
  fi
}

# --- Ejecución principal ---
get_current_ip
read -p "¿Quieres usar la red Tor? (Y/N): " CHOICE1
if [[ "$CHOICE1" =~ ^[Yy]$ ]]; then
  enable_tor_and_check_ip
fi

# Confirmación del usuario
read -p "¿Deseas continuar con el test de carga? (Y/N): " CHOICE
if [[ "$CHOICE" =~ ^[Yy]$ ]]; then
  run_stress_test
  sudo systemctl stop tor.service
else
  echo "Operación cancelada."
  sudo systemctl stop tor.service
  exit 0
fi
