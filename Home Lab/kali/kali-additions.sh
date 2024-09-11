#!/bin/bash

# Update apt cache and upgrade packages
sudo apt update && sudo apt upgrade -y

# Add Sublime Text GPG key
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null

# Add Sublime Text repository
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# Comment out the specified line in /etc/apt/sources.list
sudo sed -i '/deb https:\/\/deb.parrot.sh\/parrot lory main contrib non-free/s/^/#/' /etc/apt/sources.list

# Install necessary packages
sudo apt install -y pipx gdb git sublime-text synaptic apt-transport-https xclip terminator cifs-utils byobu exiftool jq ruby-full docker.io docker-compose locate tldr btop

# Ensure pipx path is available
pipx ensurepath

# Install package with pipx
# netexec
pipx install git+https://github.com/Pennyw0rth/NetExec || true
# crackmapexec
pipx install git+https://github.com/Porchetta-Industries/CrackMapExec.git || true
# updog
pipx install updog || true

# impacket
pipx install git+https://github.com/fortra/impacket.git || true
# certipy-ad 
pipx install git+https://github.com/ly4k/Certipy.git || true
# oletools
pipx install oletools


# Clone useful GitHub repositories
sudo git clone https://github.com/Flangvik/SharpCollection /opt/SharpCollection || true
sudo git clone https://github.com/danielmiessler/SecLists /opt/SecLists || true

# Install tools from Gems
sudo gem install logger stringio winrm builder erubi gssapi gyoku httpclient logging little-plugger nori rubyntlm winrm-fs evil-winrm

# Define aliases based on the shell
shell_aliases="
alias xclip=\"xclip -selection c\"
alias vulscanup=\"sudo bash /usr/share/nmap/scripts/vulscan/update.sh\"
alias removecomments=\"source /opt/removecomments.sh\"
alias cme=\"crackmapexec\"
alias chmox=\"chmod\"
eval \"\$(register-python-argcomplete pipx)\"
"

# Add aliases to the appropriate shell configuration file
if [ -n "$BASH_VERSION" ]; then
  echo "$shell_aliases" >> ~/.bashrc
elif [ -n "$ZSH_VERSION" ]; then
  echo "$shell_aliases" >> ~/.zshrc
fi

# Clean up
sudo apt autoremove -y


# Create temporary build directory
build_dir=$(mktemp -d)

# Copy python script to download github releases
cp ./githubdownload.py "$build_dir/githubdownload.py"

# Download github releases
sudo python3 "$build_dir/githubdownload.py" "jpillora/chisel" "_linux_amd64.gz" "/opt/chisel"
sudo python3 "$build_dir/githubdownload.py" "jpillora/chisel" "_windows_amd64.gz" "/opt/chisel"
# Uncomment the line below if you want to download for macOS
# python3 "$build_dir/githubdownload.py" "jpillora/chisel" "_darwin_amd64" "/opt/chisel" "chisel_osx"
sudo python3 "$build_dir/githubdownload.py" "carlospolop/PEASS-ng" "linpeas.sh" "/opt/peas"
sudo python3 "$build_dir/githubdownload.py" "carlospolop/PEASS-ng" "winPEASx64.exe" "/opt/peas"
sudo python3 "$build_dir/githubdownload.py" "WithSecureLabs/chainsaw" "chainsaw_all_" "/opt/"
sudo python3 "$build_dir/githubdownload.py" "BloodHoundAD/BloodHound" "BloodHound-linux-x64.zip" "/opt/"

# Remove temporary build directory
sudo rm -rf "$build_dir"

# update the db
sudo updatedb 2>/dev/null
