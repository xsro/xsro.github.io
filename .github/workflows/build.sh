PROJECT_ROOT=`pwd -P`

# compile typst
git clone  https://github.com/typst/typst _typst

python3 doc/typst/cp.py --dev _typst