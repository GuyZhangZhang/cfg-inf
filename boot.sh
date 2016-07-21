#!/usr/bin/env bash

############################  SETUP PARAMETERS
# cfg-inf
app_name='cfg-inf'
[ -z "$CFG_INF_PATH" ] && CFG_INF_PATH="$HOME/.cfg-inf"
[ -z "$REPO_URI" ] && REPO_URI='https://github.com/GuyCheung/cfg-inf.git'
[ -z "$REPO_BRANCH" ] && REPO_BRANCH='master'

# spf13-vim
spf13_vim_boot="$CFG_INF_PATH/spf13-vim3.boot.sh"
[ -z "$SPF13VIM_PATH" ] && SPF13VIM_PATH="$HOME/.spf13-vim"

# scripts
debug_mode='1'

############################  BASIC SETUP TOOLS
msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
        msg "\33[32m[✔]\33[0m ${1}${2}"
    fi
}

error() {
    msg "\33[31m[✘]\33[0m ${1}${2}"
    exit 1
}

debug() {
    if [ "$debug_mode" -eq '1' ] && [ "$ret" -ge '1' ]; then
        msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
    fi
}

program_exists() {
    local ret='0'
    command -v $1 >/dev/null 2>&1 || { local ret='1'; }

    # fail on non-zero return value
    if [ "$ret" -ne 0 ]; then
        return 1
    fi

    return 0
}

program_must_exist() {
    program_exists $1

    # throw error on non-zero return value
    if [ "$?" -ne 0 ]; then
        error "You must have '$1' installed to continue."
    fi
}

variable_set() {
    if [ -z "${!1}" ]; then
        error "You must have your $1 environmental variable set to continue."
    fi
}

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
    ret="$?"
    debug
}

############################ SETUP FUNCTIONS
sync_repo() {
    local repo_path="$1"
    local repo_uri="$2"
    local repo_branch="$3"
    local repo_name="$4"

    msg "Trying to update $repo_name"

    if [ ! -e "$repo_path" ]; then
        mkdir -p "$repo_path"
        git clone -b "$repo_branch" "$repo_uri" "$repo_path"
        ret="$?"
        success "Successfully cloned $repo_name."
    else
        cd "$repo_path" && git pull origin "$repo_branch"
        ret="$?"
        success "Successfully updated $repo_name"
    fi

    msg "Trying to update submodules"
    cd "$repo_path" && git submodule update --init

    debug
}

create_symlinks() {
    local source_path="$1"
    local target_path="$2"

    lnif "$source_path/.ctags"             "$target_path/.ctags"
    lnif "$source_path/.gitconfig"         "$target_path/.gitconfig"
    lnif "$source_path/.gitignore_global"  "$target_path/.gitignore_global"
    lnif "$source_path/.tmux.conf"         "$target_path/.tmux.conf"
    lnif "$source_path/.tmux"              "$target_path/.tmux"

    lnif "$source_path/.vimrc.before.local"     "$target_path/.vimrc.before.local"
    lnif "$source_path/.vimrc.bundles.local"    "$target_path/.vimrc.bundles.local"
    lnif "$source_path/.vimrc.local"            "$target_path/.vimrc.local"

    ret="$?"
    success "Setting up vim symlinks."
    debug
}

godeps() {
    msg "Trying to install deps of go packages"

    program_exists 'go'
    if [ "$?" -ne 0 ];then
        msg "No binary go found on your system! forget install this"
        return
    fi

    go get -u github.com/rogpeppe/godef
    go get -u github.com/nsf/gocode

    ret="$?"
    success "Install deps of go packages"
    debug
}

vimdeps() {
    msg "Trying to install deps of vim plugins"

    if [ -e "~/.vim/bundle/vim-jsbeautify" ];then
        cd ~/.vim/bundle/vim-jsbeautify && git submodule update --init --recursive && cd -
        ret="$?"
        success "Install deps of vim-jsbeautify"
        debug
    fi
}

spf13_vim() {
    msg "Trying to install spf13-vim"

    (
        export APP_PATH=$SPF13VIM_PATH
        sh $spf13_vim_boot
    )

    ret="$?"
    success "Install spf13-vim successed!"
    debug
}

############################ MAIN()
variable_set 'HOME'
program_must_exist 'vim'
program_must_exist 'git'

sync_repo       "$CFG_INF_PATH" \
                "$REPO_URI" \
                "$REPO_BRANCH" \
                "$app_name"

create_symlinks "$CFG_INF_PATH" \
                "$HOME"

spf13_vim

godeps
vimdeps

msg             "\nThanks for installing $app_name."
msg             "© `date +%Y` https://github.com/GuyCheung/cfg-inf"
