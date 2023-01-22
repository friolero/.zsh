## Usage: Install oh-my-zsh with antigen
```
sudo apt-get update
sudo apt-get install zsh curl
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo apt-get install fonts-powerline 
git clone git@github.com:friolero/.zsh.git  
rm ~/.zshrc
ln -sf ~/.zsh/.zshrc
```


## (Not Strictly) Dependencies

### install trash
```
sudo apt-get update
sudo apt-get install trash-cli
```

### install gpustat
```
# install pip if not already installed
pip install gpustat 
```

### install git
```
sudo apt-get update
sudo apt-get install git
git config --global user.email "zeng0070@e.ntu.edu.sg"
git config --global user.name "Zeng Yuwei"
# proceed to add ssh key
```

### install docker
```
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker $USER
sudo reboot
```
