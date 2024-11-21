


def outdir(filename):
    import os
    folder=os.path.join(os.path.dirname(__file__),"out")
    if not os.path.exists(folder):
        os.makedirs(folder)
    outpath=os.path.join(folder,filename)
    print("saving to",outpath)
    return outpath

if __name__ == '__main__':
    import sta
    for main in sta.sta:
        print(main.__name__,sta.__path__)
        main(outdir)