## SETUP SSH FOR GITHUB
EMAIL_ID="email@globalwalkersco.jp"
NAME="name"
SSH_CONFIG_FILE="$HOME/.ssh/config"

sudo apt-get install -y git

ssh-keygen -t ed25519 -C "${EMAIL_ID}" -f ~/.ssh/id_ed25519_$NAME
ssh-add ~/.ssh/id_ed25519_$NAME   # work

# Check if the .ssh/config file exists, if not create it
if [ ! -f "$SSH_CONFIG_FILE" ]; then
  echo "Creating $SSH_CONFIG_FILE..."
  touch "$SSH_CONFIG_FILE"
fi

if ! grep -q "github-$NAME" "$SSH_CONFIG_FILE"; then
  echo -e "\n# $NAME GitHub" >> "$SSH_CONFIG_FILE"
  echo -e "Host github-$NAME" >> "$SSH_CONFIG_FILE"
  echo -e "    HostName github.com" >> "$SSH_CONFIG_FILE"
  echo -e "    User git" >> "$SSH_CONFIG_FILE"
  echo -e "    IdentityFile ~/.ssh/id_ed25519_$NAME" >> "$SSH_CONFIG_FILE"
  echo "Added $NAME GitHub configuration."
else
  echo "$NAME GitHub configuration already exists."
fi

echo "SSH config updated successfully!"

cat ~/.ssh/id_ed25519_$NAME.pub