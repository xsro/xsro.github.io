# compile typst
cargo install --git https://github.com/typst/typst typst-cli
cd typst/nlct
typst compile main.typ ../../static/print/nlct.pdf
cd ../..

# clone the forked zola project
git clone --depth=1  https://github.com/xsro/zola.git _zola
# git clone --depth=1 git@github.com:xsro/zola.git _zola
cd _zola

#download the compile binary or compile it
latest_hash=$(git rev-parse HEAD)
builded_hash=$(curl -fsSL https://xsro.github.io/zola.hash)
if [ "$latest_hash" = "$builded_hash" ]
then
    curl -fsSL https://xsro.github.io/zola -o ../zola
else
    git submodule init
    git submodule update --depth=1
    cargo build --release
    cp target/release/zola ../zola
fi

# build pages
cd ..
chmod +x ./zola
./zola build
mv ./zola public/zola
echo $latest_hash > public/zola.hash

# cross compile binary
if [ "$latest_hash" = "$builded_hash" ]
then
    echo hi
else
    cargo install cross --git https://github.com/cross-rs/cross
    cross build --target x86_64-pc-windows-gnu
    cross build --target i686-pc-windows-gnu
    ls -R
    cp -r target/ ../public/
fi

