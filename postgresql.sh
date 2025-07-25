#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/dityaang/Proxmox/main/build.func)
# Copyright (c) 2021-2024 tteck
# Author: tteck (tteckster)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
    ____             __                 _____ ____    __ 
   / __ \____  _____/ /_____ _________ / ___// __ \  / / 
  / /_/ / __ \/ ___/ __/ __  / ___/ _ \\__ \/ / / / / /  
 / ____/ /_/ (__  ) /_/ /_/ / /  /  __/__/ / /_/ / / /___
/_/    \____/____/\__/\__, /_/   \___/____/\___\_\/_____/
                     /____/                              
EOF
}
header_info
echo -e "Loading..."
APP="PostgreSQL"
var_disk="4"
var_cpu="1"
var_ram="1024"
var_os="debian"
var_version="12"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function update_script() {
header_info
if [[ ! -f /etc/apt/sources.list.d/pgdg.list ]]; then msg_error "No ${APP} Installation Found!"; exit; fi
msg_info "Updating ${APP} LXC"
apt-get update &>/dev/null
apt-get -y upgrade &>/dev/null
msg_ok "Updated Successfully"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
