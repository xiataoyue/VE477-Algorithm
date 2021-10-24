let rec small_first list target result = 
  match list with
  | [] -> []
  | head::tail -> 
    if target = head then List.rev (head::result)
    else if target > head then small_first tail (target - head) (head::result)
    else []
;;

let rec large_first list target result = 
  match list with
  | [] -> []
  | head::tail ->
    if target = head then List.rev (head::result)
    else if target > head then large_first tail (target - head) (head::result)
    else large_first tail target result
;;


let time f = 
  let start = Unix.gettimeofday () in
  let res = f () in
  let stop = Unix.gettimeofday () in
  Printf.printf "Execution time: %f\n" (stop -. start);
  res
;;

let small n l = 
  let result = small_first l n [] in
  begin
    Printf.printf "%d: " n;
    print_string "[";
    List.iter (Printf.printf "%d ") result;
    print_string "]\n"
  end
;;

let large n ll = 
  let result = large_first ll n [] in
  begin
    Printf.printf "%d: " n;
    print_string "[";
    List.iter (Printf.printf "%d ") result;
    print_string "]\n";
  end
;;

let rec create_list n = 
  match n with 
  | 0 -> []
  | _ -> (Random.int 25) :: create_list (n-1)
;;

let rec init_lists n = 
  match n with
  | 0 -> []
  | _ -> let x = 100 + (Random.int 30) in
         let y = List.stable_sort compare (create_list 7) in
         (x, y) :: init_lists (n-1)
;;
 
let get_ele1 (a, _) = a;;
let get_ele2 (_, a) = a;;

let rec small_test l = 
  match l with
  | [] -> print_string "end\n"
  | head :: tail -> let (x, y) = head in
                    small x y;
                    small_test tail
;;

let rec large_test l = 
  match l with
  | [] -> print_string "end\n"
  | head :: tail -> let (x, y) = head in
                    large x y;
                    large_test tail
;;


Random.self_init ();;
let num_loop = 100;;
(* let n = read_int();;
let s = read_line();;
let l = List.stable_sort compare (List.map int_of_string (Str.split (Str.regexp " ") s));; *)
let l = init_lists num_loop;;
time (fun () -> small_test l);;

(* let n = read_int();;
let s = read_line();;
let ll = List.stable_sort (fun x y -> compare y x) (List.map int_of_string (Str.split (Str.regexp " ") s));; *)
let ll = init_lists num_loop;;
time (fun () -> large_test ll);;