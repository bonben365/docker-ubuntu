sudo apt-get install ca-certificates curl gnupg

sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" \
  signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

mkdir /var/scripts
cat << EOF >> /var/scripts/viewer.sh
docker run -e APPLICATION_KEY=79d00bf1-79fd-4dfd-9491-98d383fb1d74 otohits/app:latest        
EOF
chmod +x /var/scripts/viewer.sh
cat << EOF >> /etc/systemd/system/viewerd.service
[Unit]
Description=My custom startup script
[Service]
ExecStart=/var/scripts/viewer.sh start
[Install]
WantedBy=multi-user.target        
EOF

systemctl start viewerd.service
systemctl enable viewerd.service

