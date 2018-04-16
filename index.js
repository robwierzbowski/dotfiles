// Symlink dotfiles

const fs = require('fs');
const path = require('path')

const symlinkFile = (srcFile, linkFile) => {
  fs.unlink(linkFile, () => {
    fs.symlink(
      srcFile,
      linkFile,
      () => { console.log(`Symlinked ${srcFile} to ${linkFile}`); }
    );
  });
}

const symlinkByDirectory = (srcDir, linkDir) => {
  fs.readdir(srcDir, (err, files) => {
    if (err) { console.log(err); }

    files.forEach((file) => {
      const srcFile = path.join(srcDir, file);
      const linkFile = path.join(linkDir, file);

      symlinkFile(srcFile, linkFile);
    });
  });
};

const srcHomeFiles = path.join(__dirname, 'symlinks/home');
const destHomeFiles = process.env['HOME'];

symlinkByDirectory(srcHomeFiles, destHomeFiles);

const srcAtomFiles = path.join(__dirname, 'symlinks/atom');
const destAtomFiles = path.join(process.env['HOME'], '.atom');

symlinkByDirectory(srcAtomFiles, destAtomFiles);

const srcLibraryFile = path.join(__dirname, 'symlinks/OSX/LocalDictionary');
const destLibraryFile = path.join(process.env['HOME'], 'Library/Spelling/LocalDictionary');

symlinkFile(srcLibraryFile, destLibraryFile);
