Config=[
    {
        "name": "nlct",
        "path": "nlct/main.typ",
        "out":[
            "nlct.pdf"
        ]
    },
    {
        "name": "Control-for-Integrator-Systems",
        "path": "Control-for-Integrator-Systems/part1.typ",
        "out":[
            "Control-for-Integrator-Systems.pdf"
        ]},
    {
        "name": "Control-for-Integrator-Systems",
        "path": "Control-for-Integrator-Systems/part2.typ",
        "out":[
            "Control-for-Integrator-Systems-2.pdf"
        ]},
    {
        "name": "Control-for-Integrator-Systems",
        "path": "Control-for-Integrator-Systems/part3.typ",
        "out":[
            "Control-for-Integrator-Systems-3.pdf",
            r"Control-{p}.png"
        ]}
]

import os
from pathlib import Path
for conf in Config:
    name = conf["name"]
    path = Path(__file__).parent.joinpath(conf["path"])
    out = conf["out"]
    print(f"Generating {name}...")
    for i in out:
        print(f"  Generating {i}...")
        outfile= Path(__file__).parent.parent.joinpath("static/print").joinpath(i)
        os.system(f"typst compile {path} {outfile}")
        print(f"  Generated {i}.")
    print(f"Generated {name}.")
