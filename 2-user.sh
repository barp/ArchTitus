#!/usr/bin/env bash
#-------------------------------------------------------------------------
#   █████╗ ██████╗  ██████╗██╗  ██╗████████╗██╗████████╗██╗   ██╗███████╗
#  ██╔══██╗██╔══██╗██╔════╝██║  ██║╚══██╔══╝██║╚══██╔══╝██║   ██║██╔════╝
#  ███████║██████╔╝██║     ███████║   ██║   ██║   ██║   ██║   ██║███████╗
#  ██╔══██║██╔══██╗██║     ██╔══██║   ██║   ██║   ██║   ██║   ██║╚════██║
#  ██║  ██║██║  ██║╚██████╗██║  ██║   ██║   ██║   ██║   ╚██████╔╝███████║
#  ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝   ╚═╝    ╚═════╝ ╚══════╝
#-------------------------------------------------------------------------

echo -e "\nINSTALLING AUR SOFTWARE\n"
# You can solve users running this script as root with this and then doing the same for the next for statement. However I will leave this up to you.

echo "CLONING: YAY"
cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm
cd ~

echo "Setting zsh"
echo Y | sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone "https://github.com/barp/zsh-config.git"
rm "$HOME/.zshrc"
ln -s "$HOME/zsh-config/.zshrc" $HOME/.zshrc

pushd ${HOME}/zsh-config

./install-zsh.sh

popd

PKGS=(
'autojump'
'awesome-terminal-fonts'
'google-chrome'
# 'dxvk-bin' # DXVK DirectX to Vulcan
'github-desktop-bin' # Github Desktop sync
'lightly-git'
'lightlyshaders-git'
# 'mangohud' # Gaming FPS Counter
# 'mangohud-common'
'nerd-fonts-fira-code'
'nordic-darker-standard-buttons-theme'
'nordic-darker-theme'
'nordic-kde-git'
'nordic-theme'
'noto-fonts-emoji'
'papirus-icon-theme'
'plasma-pa'
'ocs-url' # install packages from websites
'sddm-nordic-theme-git'
'snapper-gui-git'
'ttf-droid'
'ttf-hack'
'ttf-meslo' # Nerdfont package
'ttf-roboto'
# Japanese/Chinese fonts
'adobe-source-han-sans-jp-fonts'
'adobe-source-han-serif-jp-fonts'
'adobe-source-han-sans-cn-fonts'
'adobe-source-han-serif-cn-fonts'
'snap-pac'
)

for PKG in "${PKGS[@]}"; do
    yay -S --noconfirm $PKG
done

export PATH=$PATH:~/.local/bin
cp -r $HOME/ArchTitus/dotfiles/* $HOME/.config/
pip install konsave
konsave -i $HOME/ArchTitus/kde.knsv
sleep 1
konsave -a kde

# Install konsole profile
pushd ${HOME}/ArchTitus/konsole-configs

mkdir -p ${HOME}/.config/
cp konsolerc ${HOME}/.config/

mkdir -p ${HOME}/.local/share/konsole
cp MyProfile.profile ${HOME}/.local/share/konsole

popd

# Install dolphin context menu
pushd ${HOME}/ArchTitus/dolphin-context-menu

download_folder=$HOME/.local/share/servicemenu-download/
install_folder=$HOME/.local/share/kservices5/ServiceMenus/

mkdir -p "$download_folder"
mkdir -p "$install_folder"

for item in *.desktop; do
	cp "$item" "$download_folder"
	cp "$item" "$install_folder"
done

popd

echo -e "\nDone!\n"
exit
