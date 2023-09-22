---
title: "MATLAB 作用域"
date: 2023-06-14
tags: ["Control Theory"]
categories: ["Study notes"]
draft: false
---

# MATLAB 作用域机制测试代码

MATLAB中的作用域有些奇怪。这里用几个测试代码来分析一下。
本文所有代码段需要在matlab脚本中运行，不能在命令行中直接运行。

## MATLAB脚本可以访问工作区标量，但是函数不可以

这是MATLAB方便的地方，可以在Simulink和MATLAB脚本中直接使用工作区的变量。
但是函数是不能访问工作区的标量的，比如下面的代码会报错。
函数体里面无法使用变量a，因为a定义在脚本中，运行后会写入工作区。


```MATLAB
clear all
a=1;
func1();

function func1()
    disp(a) %函数或变量 'a' 无法识别。
end
```

那么如何才能访问到a变量呢？

## 法1：MATLAB函数的中的量可以向下层函数传递

MATLAB函数的中的量可以向下层函数传递，因此可以通过嵌套函数的方式使得脚本可以达到访问上一层变量的效果

```MATLAB
function func0()
    clear all
    a=1;
    func1();

    function func1()
        disp(a) %打印1
    end
end
```

## 法2：使用global关键字

`global`关键字可以将变量在全局范围内共享。

```MATLAB
clear all
global a %如果有这一行输出2，没有这一行输出1
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
```

## 附：MATLAB中的persistent关键字


```MATLAB
%持久变量与全局变量类似，因为 MATLAB 为二者都建立持久存储。二者的区别在于持久变量仅为声明它们的函数所知晓。因此，MATLAB 命令行或其他函数中的代码不能更改持久变量。

clear all
%persistent a %不支持在脚本中声明持久变量。如果这里用了会报错
a=1;
change()
show()%打印1,change函数只改变里面的值


function change()
    persistent a
    a=2;
end


function show()
   persistent a
    disp(a)
    whos a
end
```

## 总结

MATLAB 中函数的作用域可以嵌套，但是不能访问工作区变量。
global和persistent的主要作用在于，每一次调用都访问的是同一个变量，而不是每次调用都新建一个变量。
这两个关键字现在其实都不推荐了，因为会导致代码的可读性变差，不利于维护，也不利于matlab的处理。
global 编辑了的同名变量是一样的，persistent标记的同名变量是互相独立的。