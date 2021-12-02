let rec random_search k array h length num = 
  if (Hashtbl.length h)  == length then
    (-1, num)
  else
    let i = Random.int length in 
    let elem = List.nth array i in 
    if elem == k then
      (i, num)
    else
      if Hashtbl.mem h i then
        random_search k array h length (num + 1)
      else
        begin
        Hashtbl.add h i true;
        random_search k array h length (num + 1)
        end
;;

let get_two (_, a) = a;;

let rec loop result list k h n = 
  if n == 1000 then result
  else
    let tuple = random_search k list h (List.length list) 1 in 
    let num = get_two tuple in
    begin
      Hashtbl.clear h;
      loop (num :: result) list k h (n + 1)
    end
;;

let rec generate_list result num = 
  if num == 10000 then result
  (* else if num == i1 then generate_list (k :: result) (num + 1) k i1 i2 i3
  else if num == i2 then generate_list (k :: result) (num + 1) k i1 i2 i3
  else if num == i3 then generate_list (k :: result) (num + 1) k i1 i2 i3 *)
  else
    let x = (Random.int 10000) in
    generate_list (x :: result) (num + 1)
;;


Random.self_init ();;
let k = Random.int 10000;;

let sequence = generate_list [] 0;;
let length = List.length sequence;;
let hash = Hashtbl.create length;;
let indices_list = loop [] sequence k hash 0;;
(* List.iter (fun x -> print_int x; print_string " ") indices_list;; *)
let avg = (List.fold_left (+) 0 indices_list) / 1000;;
print_string "The average number of indices is: ";;
print_int avg;;
print_string ".\n";;

(* let index, num = random_search k s hash length 1;;
if index == -1 then
  begin
  print_string "No such element in the array.\n";
  print_string "Total search time is: ";
  print_int num;
  print_string ".\n"
  end
else
  begin
  print_string "The index is ";
  print_int index;
  print_string ".\n";
  print_string "Total search time is: ";
  print_int num;
  print_string ".\n"
  end *)