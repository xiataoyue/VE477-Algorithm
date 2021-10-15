let rec exgcd a b = 
  if b = 0 then a, 1, 0
  else match (exgcd b (a mod b)) with
    (d, x, y) -> d, y, x - a/b*y;;

print_endline "Please input two numbers to find the greatest common divisor: ";;
let (a, b) = Scanf.scanf " %d %d" (fun a b -> (a, b));;

let (d, x, y) = exgcd a b;;
Printf.printf "The greatest common divisor is %d, and the Bezout's identity for the two numbers is %d and %d\n" d x y;;