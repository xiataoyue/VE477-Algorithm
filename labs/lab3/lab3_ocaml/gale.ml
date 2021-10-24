type man =
  { m_index: int;
    mutable free: bool;
    women_rank: int list;
    has_proposed: (int, bool) Hashtbl.t (* a set *)
  }
;; 
type woman =
  { w_index: int;
    men_rank: int list;
    mutable engaged: int option    (*can be either none or an index of man*)
  }
;;
  
(*The function to read inputs and convert to a list of tuples which contains an index and a rank list*)
let rec read_person i n ll = 
  if i = n then List.rev ll
  else 
    let s = read_line() in 
      let l = List.map int_of_string (Str.split (Str.regexp " ") s) in
        match l with
        | [] -> List.rev ll
        | head::tail -> read_person (i+1) n ((i,l)::ll)
;;

(*returns true if m1 is of higher rank than m2 for w*)
let prefer w m1 m2 =
  let rec comp = function
  | [] -> invalid_arg "cannot find such index"
  | x::_ when x = m1 -> true
  | x::_ when x = m2 -> false
  | _::xs -> comp xs
  in
  comp w.men_rank
;;
 
(*Func*)
let build_structs men women n =
  List.map (fun (index, rank) -> {m_index = index; women_rank = rank; free = true; has_proposed = Hashtbl.create n}) men,
  List.map (fun (index, rank) -> {w_index = index; men_rank = rank; engaged = None}) women
;;
 
let gale_helper m_list w_list n =
  (*Create two hashtables for men and women, key is the index, value is the corresponding struct*)
  let men = Hashtbl.create n in
  List.iter (fun m -> Hashtbl.add men m.m_index m) m_list;
  let women = Hashtbl.create n in
  List.iter (fun w -> Hashtbl.add women w.w_index w) w_list;
  try
    while true do
      let m = List.find (fun m -> m.free) m_list in    (*Find the first free man from the list of men*)
      let w_index = List.find (fun w -> not (Hashtbl.mem m.has_proposed w)) m.women_rank in    (*Find the woman of highest rank who has not been proposed by m*)
      Hashtbl.add m.has_proposed w_index true;    (*Add the woman to the proposed hashtable, key is index, value is en empty unit*)
      let w = Hashtbl.find women w_index in     (*The hashtable can shorter the finding process to O(1)*)
      match w.engaged with
      | None -> w.engaged <- Some m.m_index; m.free <- false    (*If the woman is free, let m and w be a pair*)
      | Some m'_index ->    (* some pair (m', w) already exists *)
          if prefer w m.m_index m'_index then     (*If woman "w" prefer "m" to "m'"*)
          begin    
            w.engaged <- Some m.m_index;
            let m' = Hashtbl.find men m'_index in    (*Quick find in hashtable*)
            m'.free <- true;
            m.free <- false
          end
    done;
  with Not_found -> ()
;;
 
let gale men women n =
  let m_list, w_list = build_structs men women n in
  gale_helper m_list w_list n;
  let some = function Some v -> v | None -> -1 in
  List.stable_sort compare (List.map (fun w -> some w.engaged, w.w_index) w_list)
;;

let get_ele1 (a, _) = a;;
let get_ele2 (_, a) = a;;
let rec print result =
  match result with
  | [] -> print_string ""
  | head::[] -> print_string "["; print_int (get_ele1 head); print_string ", "; print_int (get_ele2 head); print_string "]"
  | head::tail -> print_string "["; print_int (get_ele1 head); print_string ", "; print_int (get_ele2 head); print_string "], "; print tail
;;
 
let () =
  let n = read_int() in 
  let men= read_person 0 n [] in 
  let tmp = read_line() in
  let women = read_person 0 n [] in 
  let result = gale men women n in
  print_string tmp;
  print_string "[";
  print result;
  print_string "]\n"
;;