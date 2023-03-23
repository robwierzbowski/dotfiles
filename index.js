const fs = require('fs');
const os = require('os');
const path = require('path');
const readline = require('readline/promises');
const { stdin: input, stdout: output } = require('process');

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

// Control character color codes
// There is no way in node to get the current color and restore it, so I'm gonna
// let the terminal commands run out in fuchsia and hope for the best. Doing
// this manually instead of adding chalk to keep this a dependency-less repo.
const red = '\x1B[38;5;196m';
const orange = '\x1B[38;5;214m';
const yellow = '\x1B[38;5;226m';
const fuchsia = '\x1B[38;5;198m';
const warning = `${red}WARNING!
${orange}This script is destructive and irreversible. It will overwrite any existing files at the symlink destinations.
${yellow}To continue, type YES: ${fuchsia}`;

const run = async () => {
  const rl = readline.createInterface({ input, output });
  const answer = await rl.question(warning);

  rl.close();

  if (answer === 'YES') {
    paths.forEach(createSymlinks);
  } else {
    process.exit(1);
  }
};

run();
