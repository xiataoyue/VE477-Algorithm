let rec mergecount = function
  | list, [] -> list, 0
  | [], list -> list, 0
  | x1::xs1, x2::xs2 ->
    if x1 <= x2 then
      match (mergecount (xs1, x2::xs2)) with
        | (list, count) -> x1 :: list, count
      else
        match (mergecount (x1::xs1, xs2)) with
        | (list, count) -> x2 :: list, count + (List.length xs1) + 1
;;
let rec split_at n tmp list = 
  if n = 0 then List.rev tmp, list
  else match list with
  | [] -> List.rev tmp, []
  | head::tail -> split_at (n-1) (head::tmp) tail
;;

let split list = split_at ((List.length list + 1) / 2) [] list;;

let get_ele1 (a, _) = a;;
let get_ele2 (_, a) = a;;

let rec merge_sort = function
    | [] -> [], 0
    | [_] as list -> list, 0
    | list ->
        let l1, l2 = (split list) in
          let (s1, s2) = merge_sort l1, merge_sort l2 in
            let (result, count) = mergecount (get_ele1 s1, get_ele1 s2) in
          result, get_ele2 (s1) + get_ele2 (s2) + count
;;

let rec print_list list = match list with
  | [] -> print_string ""
  | head::[] -> print_int head
  | head::tail -> print_int head ; print_string ", " ; print_list tail
;;

let input = read_line();;
let ll = List.map int_of_string (Str.split (Str.regexp " ") input);;

let (list, count) = merge_sort ll;;
Printf.printf "%d\n" count;;
print_string "[";;
print_list list;;
print_string "]\n";;
