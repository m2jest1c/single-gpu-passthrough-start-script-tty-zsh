# Single GPU Passthrough VM Start/Stop Script for Zsh
### This script is meant to be sourced from your user's Z shell. I prefer to do this with an alias.

## Why does this exist?
I wanted a script that could make sure that my GPU doesn't crash after I shut down my VM, because for one reason or another
an application like VSCode, OBS, etc. would stick around even after I shutdown my desktop environment, and then break `amdgpu`.

It really sucks. I don't like rebooting if I don't have to, and especially if I'm not expecting to.

I also wanted a script that was easy to add extra little things to, like mounting drives, changing the status of a service,
or something else. You can add your own commands.

Finally, because of the previous reason, I wanted a script that could run as the user.

This method also tends to work more reliably for me than hook scripts? Why? I don't know.

## How do I use it?
I personally set up an alias in my `~/.zshrc`, using a line like `alias startqemuvm="source somepath/start.sh"` 
and `alias revertqemuvm="source somepath/revert.sh"`. You can just call the script directly using `source` if you want.

I sign out of my DE and then switch to a tty using `Ctrl + Alt + F4` (or some other function key). I then sign in there, 
and run one of the aliases. 

## I'm not responsible if your computer explodes, your root directory disappears, or anything similar. None of that should happen, but if it does I'm not responsible. You can read the code. 



