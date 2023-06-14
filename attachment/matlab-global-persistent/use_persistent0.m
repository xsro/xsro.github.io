%持久变量与全局变量类似，因为 MATLAB 为二者都建立持久存储。二者的区别在于持久变量仅为声明它们的函数所知晓。因此，MATLAB 命令行或其他函数中的代码不能更改持久变量。

clear all
a=1;
change()
show()


function change()
    persistent a
    a=2;
end


function show()
   persistent a
    disp(a)
    whos a
end