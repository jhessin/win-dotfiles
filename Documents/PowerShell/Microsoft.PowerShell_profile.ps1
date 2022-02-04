# Import modules here
Import-Module posh-git
Import-Module oh-my-posh
Import-Module cd-extras

# Save MYVIMRC so I can quickly refer to it later
$Env:VIMRC = "C:/Users/jhess/AppData/Local/nvim"
$Env:MYVIMRC = "$Env:VIMRC/init.vim"
$Env:PAGER = "nvim -u ~/.vimrc.more -"
# Save the neovim config directory
# This is where the system wide vimrc is.
# $Env:VIM = "C:/tools/neovim/Neovim/share/nvim/runtime"

# Set the default editor
$Env:EDITOR = $Env:VISUAL = 'nvim'
# Set up the Prompt
Set-PoshPrompt -Theme powerline

# Use vim style readline options
$OnViModeChange = [scriptblock]{
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[1 q"
    }
    else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
}

Set-PsReadLineOption -EditMode Vi
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $OnViModeChange
# Set-PSReadlineOption -EditMode vi -BellStyle Visual -ViModeIndicator Cursor

# Set up some aliases for vim
Set-Alias vim nvim
Set-Alias vi nvim

<# !!!--- Use functions instead of aliases for almost everything ---!!! #>
# unix style which command
function which($name) {
	Get-Command $name | Select-Object -ExpandProperty Definition
}

# quickly edit the config file
function psconfig() {
	nvim $PROFILE
	. $PROFILE
}

# quickly edit wez's config file
function wezconfig() {
	nvim 'C:/Program Files/WezTerm/wezterm.lua'
}

# Go to my github projects folder
function github() {
	cd $HOME/Projects
}

# an easier way to make symbolic links
function mklink($link, $target) {
	sudo pwsh -NoExit -Command "New-Item -ItemType SymbolicLink -Path $link -Target $target"
}

function gitconfig() {
	nvim $HOME/.gitconfig
}

function vimrc() {
	cd $HOME/AppData/Local/nvim/
}

function sysvimrc() {
	cd $Env:VIM
}

function psrc() {
	cd $HOME/Documents/PowerShell/
}

function git-autocrlf() {
	git config core.autocrlf true
}

function vimconfig() {
	vim $Env:MYVIMRC
}

function syncall() {
	cd $HOME
	git pull
	gitui
	git push
	cd $HOME/AppData
	git pull
	gitui
	git push
	github
	echo "TODO: Traverse the Projects directory"
}
