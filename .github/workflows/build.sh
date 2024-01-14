PROJECT_ROOT=`pwd -P`

# compile typst
git clone  https://github.com/typst/typst _typst
cd _typst
cargo run compile --font-path $PROJECT_ROOT/_typst/assets/fonts/ \
    $PROJECT_ROOT/typst/nlct/main.typ \
    $PROJECT_ROOT/static/print/nlct.pdf
cd ..

# clone the forked zola project
git clone --depth=1  https://github.com/xsro/zola.git _zola
# git clone --depth=1 git@github.com:xsro/zola.git _zola
cd _zola
#download the compile binary or compile it
latest_hash=$(git rev-parse HEAD)
builded_hash=$(curl -fsSL https://xsro.github.io/zola.hash)
if [ "$latest_hash" = "$builded_hash" ]
then
    curl -fsSL https://xsro.github.io/zola -o $PROJECT_ROOT/static/zola
else
    git submodule init
    git submodule update --depth=1
    cargo build --release
    cp target/release/zola $PROJECT_ROOT/static/zola
    #cross compile 
    zola_targets=(x86_64-pc-windows-gnu, i686-pc-windows-gnu)
    cargo install cross --git https://github.com/cross-rs/cross
    for i in ${zola_targets[@]}; 
    do 
        cross build --release --target $i; 
        mkdir -p $PROJECT_ROOT/static/zola-cross/$i/
        cp $PROJECT_ROOT/_zola/target/$i/release/zola.* $PROJECT_ROOT/static/zola-cross/$i/
    done
fi
cd ..

# build pages
chmod +x  $PROJECT_ROOT/static/zola
$PROJECT_ROOT/static/zola build
echo $latest_hash > public/zola.hash