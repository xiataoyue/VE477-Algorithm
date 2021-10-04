let s = read_line();;

let list = List.map int_of_string (Str.split (Str.regexp ", ") s);;

let rec quicksort = function 
  | [] -> []
  | head::tail -> let smaller, larger = List.partition ((>) head) tail in quicksort smaller @ (head::quicksort larger)
;;

let ll = quicksort list;;

List.iter (Printf.printf "%d ") ll;;