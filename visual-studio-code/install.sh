#!/usr/bin/env bash

code -v > /dev/null
if [[ $? -eq 0 ]];then
  read -r -p "Do you want to install VSC extensions? [y|N] " configresponse
  if [[ $configresponse =~ ^(y|yes|Y) ]];then
    echo "Installing extensions please wait..."
    code --install-extension dhoeric.ansible-vault
    code --install-extension donjayamanne.githistory
    code --install-extension joaompinto.asciidoctor-vscode
    code --install-extension HookyQR.beautify
    code --install-extension mauve.terraform
    code --install-extension PeterJausovec.vscode-docker
    code --install-extension vscoss.vscode-ansible

    echo "Extensions for VSC have been installed. Please restart your VSC."
  else
    echo "Skipping extension install.";
  fi

  read -r -p "Do you want to overwrite user config? [y|N] " configresponse
  if [[ $configresponse =~ ^(y|yes|Y) ]];then
    read -r -p "Do you want to back up your current user config? [Y|n] " backupresponse
    if [[ $backupresponse =~ ^(n|no|N) ]];then
      echo "Skipping user config save."
    else
      mkdir -p $HOME/Library/Application\ Support/Code/User
      mv $HOME/Library/Application\ Support/Code/User/settings.json $HOME/Library/Application\ Support/Code/User/settings.backup.json
      echo "Your previous config has been saved to: $HOME/Library/Application Support/Code/User/settings.backup.json"
    fi
    ln -s $HOME/.dotfiles/visual-studio-code/settings.json $HOME/Library/Application\ Support/Code/User/settings.json

    echo "New user config has been linked. Please restart your VSC."
  else
    echo "Skipping user config overwriting.";
  fi
else
  error "It looks like the command 'code' isn't accessible."
  error "Please make sure you have Visual Studio Code installed"
  error "And that you executed this procedure: https://code.visualstudio.com/docs/setup/mac"
fi