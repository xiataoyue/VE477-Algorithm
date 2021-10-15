let rec gcd a b = 
  match (a mod b) with
  | 0 -> b
  | r -> gcd b r;;

print_endline "Please enter two numbers to calculate their greatest common divisor: ";;
let (a, b) = Scanf.scanf "%d %d" (fun a b -> (a, b));;

let d = gcd a b;;
Printf.printf "The greatest common divisor of %d and %d is %d.\n" a b d;;