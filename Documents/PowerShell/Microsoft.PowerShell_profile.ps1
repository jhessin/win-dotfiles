# Import modules here
Import-Module posh-git
Import-Module oh-my-posh
Import-Module cd-extras

# Save MYVIMRC so I can quickly refer to it later
$MYVIMRC = "C:\Users\jhess\AppData\Local\nvim\init.vim"
# Save the neovim config directory
$VIM = "C:\tools\neovim\Neovim\share\nvim\runtime"

# Set up the Prompt
Set-PoshPrompt -Theme powerline

# Use vim style readline options
Set-PSReadlineOption -EditMode vi -BellStyle Visual -ViModeIndicator Cursor

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
	& $PROFILE
}

# quickly edit wez's config file
function wezconfig() {
	nvim 'C:\Program Files\WezTerm\wezterm.lua'
}

# Go to my github projects folder
function github() {
	cd $HOME/Projects
}

# an easier way to make symbolic links
function mklink($link, $target) {
	sudo pwsh -NoExit -Command "New-Item -ItemType SymbolicLink -Path $link -Target $target"
}
