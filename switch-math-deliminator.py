# Actually I move from hugo to zola for better katex support
# I found the syntax of math delimiter is different in different markdown engine and site generator
# A simple script to switch the math delimiter between different delimiter is needed
import re
import glob
from pathlib import Path

class Delimiter:
    def __init__(self,left,right,display) -> None:
        self.left = left;self.right = right;self.display = display

DelimiterList = {
    '$':Delimiter('$','$',False),
    '$$':Delimiter('$$','$$',True),
    "\(":Delimiter(r"\(",r"\)",False),
    "\(z":Delimiter(r"\\(",r"\\)",False),
    "\[z":Delimiter(r"\\[",r"\\]",True),
    "zola":Delimiter(r"{% katex(block=true) %}",r"{% end %}",True),
}

# files=glob.glob("content/**/*.md")
# for file in files:

def switch(file):
    file=Path(file)
    text=file.read_text()
    text=re.sub(r"$(.*?)$",r"\\\\(\1\\)",text)
    text=re.sub(r"$$(.*?)$$",r"\\[\1\\]",text)
    print(text)

switch("test.md")