# Lispex
a lisp-like language's interpreter in elixir
## reference
[writing-lispex-a-lisp-interpreter-in-elixir(inspired me a lot)](https://medium.com/@sfhrizvi/writing-lispex-a-lisp-interpreter-in-elixir-423cd2c439ac)  
https://www.bilibili.com/video/BV1kX4y1w73r  
[csdn: finding gold in shits](https://blog.csdn.net/weixin_33862041/article/details/91431089)  
https://monetaphilis.github.io/2017/08/09/lispy/  
## syntax
### general
```lisp
literal  
variable  
#t #f
(def var exp)  
(set var value)
(lambda (args) body)  
(quote exp)  
(cond (p0 e0) (p1 e1) (pn en))  
(proc args)  
```
### stdlib(global env)
```lisp
(+) (-) (*) (/)
(eq?)
(>) (<) (>=) (<=)
```



