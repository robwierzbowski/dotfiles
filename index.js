const fs = require('fs');
const os = require('os');
const path = require('path');

const paths = [
  ['.editorconfig', '.editorconfig'],
  ['.gitconfig', '.gitconfig'],
  ['.gitignore', '.gitignore'],
  ['.hyper.js', '.hyper.js'],
  ['.nvmrc', '.nvmrc'],
  ['.prettierrc.js', '.prettierrc.js'],
  ['.zshrc', '.zshrc'],
  ['LocalDictionary', 'Library/Spelling/LocalDictionary'],
  ['.zsh', '.zsh'],
];

const createSymlinks = ([src, dest]) => {
  const fullSrcPath = path.join(__dirname, src);
  const fullDestPath = path.join(os.homedir(), dest);

  fs.unlink(fullDestPath, () => {
    fs.symlink(fullSrcPath, fullDestPath, err => {
      if (err) console.log(err);

      console.log(`Symlinked ${src} \n  to ${fullDestPath}`);
    });
  });
};

paths.forEach(createSymlinks);
