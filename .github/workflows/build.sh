PROJECT_ROOT=`pwd -P`

wget https://github.com/typst/typst/releases/download/v0.13.1/typst-x86_64-unknown-linux-musl.tar.xz -O /tmp/typst.tar.xz
mkdir -p /tmp/typst
tar -xf /tmp/typst.tar.xz -C /tmp/typst
export PATH="$PATH:/tmp/typst/typst-x86_64-unknown-linux-musl/"
python typst/cp.py