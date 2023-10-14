git clone --depth=1 -b xsro https://github.com/xsro/zola.git _zola
cd _zola
latest_hash=$(git rev-parse HEAD)
builded_hash=$(curl -fsSL https://xsro.github.io/zola.hash)
if [ "$latest_hash" = "$builded_hash" ]
then
    curl -fsSL https://xsro.github.io/zola -o ../zola
else
    cargo build --release
    cp target/release/zola ../zola
fi
cd ..
chmod +x ./zola
./zola build
mv ./zola public/zola
echo $latest_hash > public/zola.hash