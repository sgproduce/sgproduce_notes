#!/bin/bash -eux
ELPY_REQUIREMENTS_URL="https://raw.githubusercontent.com/jorgenschaefer/elpy/master/requirements.txt"
ZERO=$(readlink -f "$0")
main() {
    sudo apt-get update && apt-get -y install virtualenvwrapper
    mkdir -p ~/p
    (
	# shellcheck source=../../../.profile
	source "$HOME/.profile"
	if [ -z "$PROJECT_HOME" ]; then
	    echo ~/p >> ~/.profile
	fi
    )
    git clone https://github.com/pakraticus/emacs.git ~/p/emacs
    mkdir -p ~/.emacs.d
    ln -snf ../p/emacs/init.el ~/.emacs.d/init.el
    # shellcheck disable=SC1094
    source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
    mkproject sgproduce_notes -r <(curl -fsSL "$ELPY_REQUIREMENTS_URL") -r "${ZERO%/*}/requirements.txt"
}
main "$@"
