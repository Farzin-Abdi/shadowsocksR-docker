#!/bin/bash

# Function to generate a password
generate_password() {
  external_ip=$(curl -s ifconfig.me)
  seed_string="${external_ip}_secret_salt"  # Add a secret salt for additional randomness
  password=$(echo -n "$seed_string" | sha256sum | head -c 16)
  echo "$password"
}


generate_name() {
  external_ip=$(curl -s ifconfig.me)
  seed_string="${external_ip}_secret_salt"  # Add a secret salt for additional randomness
  password=$(echo -n "$seed_string" | sha256sum | head -c 5)
  echo "$password"
}


# Function to get the external IP address of the host
get_external_ip() {
  # Use a service like ifconfig.me to get the external IP
  curl -s ifconfig.me
}

password=$(generate_password)
names=$(generate_name)

# Get the external IP address of the host
external_ip=$(get_external_ip)

# Create the JSON file
cat <<EOF >/usr/src/farzin/config.json
{
  "server": "0.0.0.0",
  "server_port": 443,
  "local_address": "127.0.0.1",
  "local_port": 3591,
  "password": "$password",
  "method": "aes-128-cfb",
  "protocol": "auth_aes128_md5",
  "protocol_param": "",
  "obfs": "http_post",
  "obfs_param": "",
  "redirect": "",
  "timeout": 5,
  "fast_open": false,
  "dns_server": "8.8.8.8"
}
EOF
echo
echo "Config JSON file created with a password: $password"

# Generate link and QR code
tmp_pw=$(echo -n "${password}" | base64 -w0 | sed 's/=//g;s/\//_/g;s/+/-/g')
tmp_name=$(echo -n "farzin-ssr-${names}" | base64 -w0)
tmp_gr=$(echo -n "SSR-2024" | base64 -w0)
tmp2=$(echo -n "$external_ip:443:auth_aes128_md5:aes-128-cfb:http_post:${tmp_pw}/?obfsparam=&protoparam=&remarks=${tmp_name}&group=${tmp_gr}" | base64 -w0)
qr_code="ssr://${tmp2}"
echo
echo
echo "SSR Link: $qr_code"
echo
qrencode -t ANSIUTF8 "$qr_code"
echo
echo

