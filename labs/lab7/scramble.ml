(* let rec permutation list = 
  let rec select rest n = function
  | [] -> raise Not_found
  | head :: tail -> 
    if n == 0 then (head, rest @ tail)
    else select (head :: rest) (n - 1) tail
  in
  let rec select_rand l length = 
    select [] (Random.int length) l
  in
  let rec loop result length list = 
    if length == 0 then result
    else
      let elem, rest = select_rand list length in
      loop (elem :: result) (length - 1) rest
  in
  loop [] (List.length list) list
;; *)

let safe_map f xs =
  let rec helper acc = function
    | [] -> List.rev acc
    | x :: xs ->
       helper (f x :: acc) xs
  in
  helper [] xs
;;

let shuffle list =
  let ll = safe_map (fun c -> (Random.bits (), c)) list in
  let sorted = List.sort compare ll in
  safe_map snd sorted
;;

let rec linear_search k array i = 
  match array with
  | [] -> 1000000
  | head :: tail ->
    if head == k then
      i
    else
      linear_search k tail (i+1)
;;

(* let rec scramble_search k array i = 
  let s = permutation array in
  linear_search k s i
;; *)

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
    let perm = shuffle s in 
    let i = linear_search k perm 1 in 
    loop (i :: result) (num + 1) k
;;

Random.self_init ();;
let k = Random.int 1000000;;
print_string "start\n";;
(* let sequence = generate_list [] 0;;
let s = shuffle sequence;;
List.iter (fun x -> print_int x; print_string " ") s;; *)

let indices = loop [] 0 k;;
let avg = (List.fold_left (+) 0 indices) / 1000;;
print_string "The number of search of 1000 times is: ";;
print_int avg;;
print_string ".\n";;

(* let perm = permutation l;;
List.iter (fun x -> print_int x; print_string" ") perm;;
let index = linear_search k perm 0;;
let index = scramble_search k l 0;; *)
(* if index == -1 then print_string "No such element in the array.\n"
else
  begin
    print_string "The index is ";
    print_int index;
    print_string ".\n"
  end *)