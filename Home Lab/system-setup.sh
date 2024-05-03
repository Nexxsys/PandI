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
sudo apt install -y pipx gdb git sublime-text synaptic apt-transport-https xclip terminator cifs-utils byobu lsd exiftool jq ruby-full docker.io docker-compose locate

# Ensure pipx path is available
pipx ensurepath

# Install package with pipx
# netexec
pipx install git+https://github.com/Pennyw0rth/NetExec || true
# crackmapexec
pipx install git+https://github.com/Porchetta-Industries/CrackMapExec.git || true

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

# Add alias to ~/.bashrc
echo 'alias xclip="xclip -selection c"' >> ~/.bashrc
echo 'alias vulscanup="sudo bash /usr/share/nmap/scripts/vulscan/update.sh"' >> ~/.bashrc
echo 'alias removecomments "source /opt/removecomments.sh"' >> ~/.bashrc
echo 'alias cme="crackmapexec"' >> ~/.bashrc
echo 'alias chmox="chmod"' >> ~/.bashrc

# Add aliases to ~/.bashrc
cat <<EOF >> ~/.bashrc

# Add the following aliases
# ||| Alias's for multiple directory listing commands
alias la='lsd -Alh' # show hidden files
alias ls='lsd --color=auto'
alias la='lsd -a'
alias lx='lsd -lXBh' # sort by extension
alias lk='lsd -lSrh' # sort by size
alias lc='lsd -lcrh' # sort by change time
alias lu='lsd -lurh' # sort by access time
alias lr='lsd -lRh' # recursive ls
alias lt='lsd -ltrh' # sort by date
alias lm='lsd -alh |more' # pipe through 'more'
alias lw='lsd -xAh' # wide listing format
alias ll='lsd -alFh' # long listing format
alias labc='lsd -lap' #alphabetical sort
alias lf="lsd -l | egrep -v '^d'" # files only
alias ldir="lsd -l | egrep '^d'" # directories only
alias l='lsd'
alias l.="lsd -A | egrep '^\.'"

EOF
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
sudo updatedb 2>dev/null

