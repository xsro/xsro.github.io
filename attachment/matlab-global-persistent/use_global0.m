clear all
a=1;
change()
show()


function change()
    global a
    a=2;
end


function show()
    global a
    disp(a)
end