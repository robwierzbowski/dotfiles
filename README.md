# Dotfiles and Environment Cheat Sheet

This repo is divided into three sections: Direct downloads, install files, and symlinked dotfiles. Install files are used once when setting up the computer, and symlinked files are used to record settings, configuration, etc. 

## Dotfiles

Dotfiles are in the folder `symlink/`! As you could guess, they need to be symlinked to their locations.

## Environment Cheat sheet

The essentials for setting up a new computer. Just the necessities.

### Direct Downloads

- nvm
- rvm
- Chrome
- Firefox
- Unclutter
- Focus
- Flux
- Unarchiver
- Appzapper
- Spotify
- Licecap
- Slack
- Photoshop
- Sublime
- XCode and XCode Command Line Tools

### Install files

```
# Homebrew
xargs brew install < install/brew-packages.txt

# Atom
apm install --packages-file install/package-list.txt
```

### Global Node packages

- [pure-prompt](https://github.com/sindresorhus/pure)

## TODO

- [ ] Write an install script.
- [ ] Revise the readme to be more coherent. 
