if [ -e "$TYPST_COMPILE" ]
then TYPST_COMPILE="typst compile"
fi
echo $TYPST_COMPILE

cd $(dirname $0)
mkdir -p ../static/print/

$TYPST_COMPILE \
    ./nlct/main.typ \
    ../static/print/nlct.pdf

$TYPST_COMPILE \
    ./misc/control-theory-discontinuous-ternary.typ \
    ../static/print/control-theory-discontinuous-ternary.png

