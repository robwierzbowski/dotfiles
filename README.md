# Dotfiles

A minimal repo of dotfiles I want to record and version, and a shortlist of useful utilities.

## Installation from the command line

Install [homebrew](https://brew.sh/).  
Install [nvm](https://github.com/nvm-sh/nvm).

Install the latest node:

```shell
nvm use node
```

Install homebrew packages, VS Code, and VS Code packages from the brewfile:

```shell
brew bundle --file=Brewfile
```

_If you want to update the brewfile at a later date, run `brew bundle dump --all --describe --force`._

Install global node packages:

```shell
xargs npm install < npm-list.txt
```

Add symlinks:

```shell
node index.js
```

<!-- TODO instructions about adding SSH for GH, etc -->

## Manual installation

Some nice apps. Just the necessities.

🏡: _For home_  
🧑🏽‍💻: _For work_

- 🏡🧑🏽‍💻 [Appzapper](https://www.appzapper.com/)
- 🏡🧑🏽‍💻 [DaisyDisk](https://daisydiskapp.com/)
- 🏡🧑🏽‍💻 [NordVPN](https://nordvpn.com/)
- 🏡🧑🏽‍💻 [Slack](https://slack.com/)
- 🏡🧑🏽‍💻 [Spotify](https://spotify.com/)
- 🏡🧑🏽‍💻 [Unclutter](https://unclutterapp.com/)
- 🏡 [Doppler](https://brushedtype.co/doppler/)
- 🏡 [mpv](https://mpv.io/installation/)
- 🧑🏽‍💻 [Hyper](https://hyper.is/)
- 🧑🏽‍💻 [nvm](https://github.com/nvm-sh/nvm)
- 🧑🏽‍💻 [VS Code](https://code.visualstudio.com/)
- 🧑🏽‍💻 [XCode](https://apps.apple.com/us/app/xcode/id497799835?mt=12/)
- 🧑🏽‍💻 [Zoom](https://zoom.us/download?os=mac/)
