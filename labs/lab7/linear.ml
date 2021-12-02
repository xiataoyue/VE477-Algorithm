let rec linear_search k array i = 
  match array with
  | [] -> 1000000
  | head :: tail ->
    if head == k then
      i
    else
      linear_search k tail (i+1)
;;


let rec generate_list result num = 
  if num == 1000000 then result
  else
    let x = (Random.int 1000000) in
    generate_list (x :: result) (num + 1)
;;

let rec loop result num k = 
  if num == 1000 then result
  else
    let s = generate_list [] 0 in 
    let i = linear_search k s 1 in 
    loop (i :: result) (num + 1) k
;;

Random.self_init ();;
let k = Random.int 1000000;;

let sequence = loop [] 0 k;;
(* let s = List.map int_of_string (Str.split (Str.regexp " ") sequence);; *)
(* let length = List.length s;; *)
let times = (List.fold_left (+) 0 sequence) / 1000;;
(* let index = linear_search k sequence 1;; *)
(* let num_1000 = 1000 * index;; *)
print_string "The number of search of 1000 times is: ";;
print_int times;;
print_string ".\n";;
(* if index == -1 then
  print_string "No such element in the array.\n"
else
  begin
  print_string "The index is ";
  print_int index;
  print_string ".\n"
  end *)