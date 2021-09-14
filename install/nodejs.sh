VERSION=14.17.6

cd /tmp
curl -LO "https://nodejs.org/dist/v$VERSION/node-v$VERSION-linux-x64.tar.xz"

tar -xf node-v$VERSION-linux-x64.tar.xz

mkdir -p $HOME/.local/src
mv node-v$VERSION-linux-x64 $HOME/.local/src/node

echo "NodeJS install finished. Now run:\n$ echo \"export PATH=\\\$HOME/.local/src/node/bin:\\\$PATH\" >> \$HOME/.zshrc"
