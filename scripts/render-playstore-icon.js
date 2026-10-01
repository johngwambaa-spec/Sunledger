const sharp = require('sharp');
const path = require('path');

const src = path.join(__dirname, '..', 'assets', 'icon.svg');
const out = path.join(__dirname, '..', 'assets', 'playstore-icon-512.png');

sharp(src, { density: 384 })
  .resize(512, 512)
  .png()
  .toFile(out)
  .then(() => console.log('Wrote', out))
  .catch((err) => { console.error(err); process.exit(1); });
