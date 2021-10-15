# VE477 Project1

There are two OCaml source file `project-40_gcd.ml` and `project-40_exgcd.ml` in the zip.

To run the codes, you can just type the command `ocaml project-40_gcd.ml` and `ocaml project-40_exgcd.ml`. 

Both of them will ask you to input two integers `a` and `b` to calculate their greatest common divisor (GCD). Moreover, `project-40_exgcd.ml` will also give you two integers denoting the Bezout's identity.

The codes are listed below:

* `project-40_gcd.ml`

  ```ocaml
  let rec gcd a b = 
    match (a mod b) with
    | 0 -> b
    | r -> gcd b r;;
  
  print_endline "Please enter two numbers to calculate their greatest common divisor: ";;
  let (a, b) = Scanf.scanf "%d %d" (fun a b -> (a, b));;
  
  let d = gcd a b;;
  Printf.printf "The greatest common divisor of %d and %d is %d.\n" a b d;;
  ```

  

* `project-40_exgcd.ml`

  ```ocaml
  let rec exgcd a b = 
    if b = 0 then a, 1, 0
    else match (exgcd b (a mod b)) with
      (d, x, y) -> d, y, x - a/b*y;;
  
  print_endline "Please input two numbers to find the greatest common divisor: ";;
  let (a, b) = Scanf.scanf " %d %d" (fun a b -> (a, b));;
  
  let (d, x, y) = exgcd a b;;
  Printf.printf "The greatest common divisor is %d, and the Bezout's identity for the two numbers is %d and %d\n" d x y;;
  ```

The sample output will be like:

* `project-40_gcd.ml`

![image-20211012171729664](C:\Users\JamesXia\AppData\Roaming\Typora\typora-user-images\image-20211012171729664.png)

* `project-40_exgcd.ml`

![image-20211012171936036](C:\Users\JamesXia\AppData\Roaming\Typora\typora-user-images\image-20211012171936036.png)

By calculation, we can easily find that for the first test, $14641\cdot 1 + 363\cdot(-40) = 14641-14520 = 121 = \text{gcd}(14641, 363)$.

Using python for calculation, it is proved that for the second test, $4381758974\cdot 1036870 + 4129843\cdot (-1100117953) = 1 = \text{gcd}(4381758974, 4129843)$.

