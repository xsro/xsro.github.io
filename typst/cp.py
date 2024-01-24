import subprocess
import argparse
from pathlib import Path
from itertools import islice
import shutil
import platform

def chunk_list(it, limit):
    it = iter(it)
    return iter(lambda: list(islice(it, limit)), [])

TYPYST_FILES="""
nlct/main.typ
nlct.pdf

control/main.typ
control.pdf

control/main.typ
control-{n}.png
"""

def parse_args():
    parser = argparse.ArgumentParser(description='compile my typst files')
    parser.add_argument('--bin', type=str, help='my typst binary to run')
    parser.add_argument('--dev', type=str, help='path to source code of typst')
    parser.add_argument('--font-path', type=str, help='path to load fonts')
    return parser.parse_args()

def make_command(src:Path,dst:Path,bin="typst",fonts=None,):
    if bin is None:
        bin="typst"
    cmd=[str(bin),"compile"]
    if fonts is not None:
        cmd.append("--font-path")
        cmd.append(str(fonts))
    cmd.append(str(src.resolve()))
    cmd.append(str(dst.resolve()))
    return cmd

if __name__=="__main__":
    TYPST_ROOT=Path(__file__).parent
    PRINT_ROOT=TYPST_ROOT.parent.joinpath("static","print")
    if PRINT_ROOT.exists():
        shutil.rmtree(PRINT_ROOT)
    PRINT_ROOT.mkdir(parents=True)
    files=TYPYST_FILES.splitlines()
    args=parse_args()
    print(args)

    bin=args.bin
    font_path=args.font_path
    if args.dev is not None:
        typst_code=Path(args.dev).resolve()
        subprocess.run(["cargo","build","--release"],cwd=typst_code)
        if platform.system() == "Windows":
            bin=typst_code.joinpath("target","release","typst.exe")
        else:
            bin=typst_code.joinpath("target","release","typst")
            subprocess.run(["chmod","+x",str(bin)])
        font_path=typst_code.joinpath("assets","fonts")
    
    print(bin,font_path)
    for f in chunk_list(files,3):
        src=TYPST_ROOT.joinpath(f[1])
        dst=PRINT_ROOT.joinpath(f[2])
        cmd=make_command(src,dst,bin=bin,fonts=font_path)
        print("run",cmd)
        subprocess.run(cmd)
    


