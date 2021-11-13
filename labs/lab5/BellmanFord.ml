type node = {
  name: string;
  mutable distance: float;
  mutable prev: string option;
};;

type edge = {
  start: node;
  dest: node;
  weight: float;
};;

let rec read_edges num edge_list h = 
  if num == 0 then
    List.rev edge_list
  else
    let edge_name = read_line() in
    let parse = Str.split (Str.regexp " ") edge_name in
    let start = List.nth parse 0 in
    let dest = List.nth parse 1 in
    let weight = float_of_string (List.nth parse 2) in
    if (Hashtbl.mem h start) && (Hashtbl.mem h dest) then
      read_edges (num - 1) ({start = Hashtbl.find h start; dest = Hashtbl.find h dest; weight = weight} :: edge_list) h
    else if (Hashtbl.mem h start) then
      let nodeB = {name = dest; distance = infinity; prev = None} in
      Hashtbl.add h dest nodeB;
      read_edges (num - 1) ({start = Hashtbl.find h start; dest = nodeB; weight = weight} :: edge_list) h
    else if (Hashtbl.mem h dest) then
      let nodeA = {name = start; distance = infinity; prev = None} in
      Hashtbl.add h start nodeA;
      read_edges (num - 1) ({start = nodeA; dest = Hashtbl.find h dest; weight = weight} :: edge_list) h
    else
      let nodeA = {name = start; distance = infinity; prev = None} in
      let nodeB = {name = dest; distance = infinity; prev = None} in
      let edge = {start = nodeA; dest = nodeB; weight = weight} in
      Hashtbl.add h start nodeA;
      Hashtbl.add h dest nodeB;
      read_edges (num-1) (edge::edge_list) h
;;

let rec loop_e  edge_list l h = 
  match l with
  | [] -> edge_list
  | head::tail -> let u = head.start in
                  let v = head.dest in 
                  let tmp = u.distance +. head.weight in
                  if tmp < v.distance then 
                    begin
                      v.distance <- tmp;
                      v.prev <- Some u.name;
                    end;
                  loop_e edge_list tail h
;;

let rec loop_v vnum l h = 
  if vnum == 0 then
    []
  else 
    begin
    let el = loop_e l l h in
    loop_v (vnum-1) el h;
    end
;;

let op_to_str data = 
  match data with
  | None -> ""
  | Some str -> str
;;

let rec find_path dest result h = 
  if dest.prev == None then
    (dest.name :: result)
  else
    find_path (Hashtbl.find h (op_to_str dest.prev)) (dest.name :: result) h
;;

let rec print_list l = 
  match l with
  | [] -> print_string "]"
  | head :: [] -> print_string "'"; print_string head; print_string "']";
  | head :: tail ->  print_string "'"; print_string head; print_string "', "; print_list tail
;;

let edge_num = read_int();;
let h = Hashtbl.create edge_num;;

let edge_list = read_edges edge_num [] h;;
let start = read_line();;
let start_node = Hashtbl.find h start;;
start_node.distance <- 0.0;;
let dest = read_line();;
let end_node = Hashtbl.find h dest;;
let v_num = Hashtbl.length h;;

loop_v v_num edge_list h;;
let result = find_path end_node [] h;;
print_string "[";;
print_list result;;