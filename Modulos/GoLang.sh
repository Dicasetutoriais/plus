#!/bin/bash
# Date: 30/03/2022

remove_go() {
    # Remove existing Go installations
    rm -rf /usr/local/go
    rm -rf "$HOME/go"
    killall go &>/dev/null
}

install_go() {
    tput clear
    echo -e "\033[1;33m   GO Lang Installer (Multi-Protocol) \033[0m"
    echo
    echo -e "\033[1;33m This will install the GO Lang package,\n which serves as the base for various protocols. \033[0m"
    echo -e "\033[1;33m Continue? \033[0m"

    read -p " [S/N]: " yesno
    tput cuu1 && tput dl1

    if [[ "${yesno,,}" == "y" ]]; then
        echo -e "\033[1;32m Installing... \033[0m"
        cd || exit

        # Download and extract Go
        wget -q https://golang.org/dl/go1.15.linux-amd64.tar.gz
        tar -C /usr/local -xzf go1.15.linux-amd64.tar.gz

        # Check if GOROOT is already set in .bashrc
        if grep -q GOROOT /root/.bashrc; then
            echo -e "\033[1;31m GoROOT already exists - Skipping \033[0m"
        else
            # Add GOROOT, GOPATH, and PATH to .bashrc
            cat <<EOF >> /root/.bashrc
export GOROOT=/usr/local/go
export GOPATH=\$HOME/go
export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH
EOF
            rm go1.15.linux-amd64.tar.gz
            source /root/.bashrc
        fi

        sleep 3
        echo -e "\033[1;32m Restarting the Terminal... \033[0m"
    fi

    echo -e "\033[1;33m To complete the GO installation process, run: \033[0m"
    echo -e "\033[1;32m source ~/.profile \033[0m"
}

go_menu() {
    tput clear
    echo -e "\033[1;33m     GO Lang Installer    \033[0m"
    echo -e
    echo -e "\033[1;32m  [1] \033[1;33mInstall GO Lang \033[0m"
    echo -e "\033[1;32m  [2] \033[1;33mUninstall GO Lang \033[0m"
    echo -e "\033[1;33m ▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎▪︎ \033[0m"
    echo -e "\033[1;32m  [0] \033[1;33mEXIT \033[0m"
    echo -e
    read -p "CHOOSE AN OPTION: " option

    case $option in
        0) exit ;;
        1) install_go ;;
        2) remove_go ;;
        *)
            echo -e "\033[1;31m\n CHOOSE A VALID OPTION...!!! \033[0m"
            sleep 1
            go_menu ;;
    esac
}

go_menu
