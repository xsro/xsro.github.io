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

Control-for-Integrator-Systems/part1.typ
Control-for-Integrator-Systems.pdf

Control-for-Integrator-Systems/part2.typ
Control-for-Integrator-Systems-part2.pdf
"""

def parse_args():
    parser = argparse.ArgumentParser(description='compile my typst files')
    parser.add_argument('--bin', type=str, help='my typst binary to run')
    parser.add_argument('--dev', type=str, help='path to source code of typst')
    parser.add_argument('--font-path', type=str, help='path to load fonts')
    parser.add_argument('--watch', action="store_true", help='watch files')
    return parser.parse_args()

def make_command(src:Path,dst:Path,bin="typst",fonts=None,watch=False):
    if bin is None:
        bin="typst"
    cmd=[str(bin),"watch" if watch else "compile"]
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

    
    cmds=[]
    for f in chunk_list(files,3):
        src=TYPST_ROOT.joinpath(f[1])
        dst=PRINT_ROOT.joinpath(f[2])
        cmd=make_command(src,dst,bin=bin,fonts=font_path,watch=args.watch)
        cmds.append(cmd)
    if args.watch:
        for i,cmd in enumerate(cmds):
            print(f"[{i}] {cmd}")
        a=input("input the number of command to exec: ")
        try:
            idx=int(a)
            cmd=cmds[idx]
            subprocess.run(cmd)
        except Exception as e:
            print(e)
            exit()
    else:
        from multiprocessing.dummy import Pool
        import time

        def run_typst(conf):
            i,cmd=conf
            print(f"[{i}] run {cmd}")
            try:
                subprocess.run(cmd)
            except Exception as e:
                print(e)

        time1 = time.time()
        datalist = []  #创建参数列表
        for i in range(10):
            datalist.append(i)
            
        pool = Pool(10)  #创建10个子线程
        result = pool.map(run_typst,enumerate(cmds))  # 参数列表长度为10 所以要执行10个任务
        pool.close()
        pool.join()  #等待所有子线程执行完毕后退出，在此之前要执行 .close 方法
        time2 = time.time()
        print(f"spend {time2-time1}s to compile typst")  #从开始到结束所用的时间

    


