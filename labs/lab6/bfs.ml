type vertex = {
  index: int;
  mutable dist: int;
  mutable prev: vertex option;
  mutable adj: vertex list
};;

let rec read_edges num l h = 
  if num == 0 then
    List.rev l
  else
    let s = read_line() in
    let vertices = List.map int_of_string (Str.split (Str.regexp " ") s) in 
    let idx_u = List.nth vertices 0 in 
    let idx_v = List.nth vertices 1 in 
    if (Hashtbl.mem h idx_u) && (Hashtbl.mem h idx_v) then
      let u = Hashtbl.find h idx_u in
      let v = Hashtbl.find h idx_v in 
      u.adj <- u.adj @ [v];
      v.adj <- v.adj @ [u];
      read_edges (num-1) l h
    else if (Hashtbl.mem h idx_u) then
      let u = Hashtbl.find h idx_u in 
      let v = {index = idx_v; dist = max_int; prev = None; adj = [u]} in 
      Hashtbl.add h idx_v v;
      u.adj <- u.adj @ [v];
      read_edges (num-1) (v::l) h
    else if (Hashtbl.mem h idx_v) then
      let v = Hashtbl.find h idx_v in 
      let u = {index = idx_u; dist = max_int; prev = None; adj = [v]} in 
      Hashtbl.add h idx_u u;
      v.adj <- v.adj @ [u];
      read_edges (num-1) (u::l) h
    else
      let u = {index = idx_u; dist = max_int; prev = None; adj = []} in 
      let v = {index = idx_v; dist = max_int; prev = None; adj = []} in
      Hashtbl.add h idx_u u;
      Hashtbl.add h idx_v v;
      u.adj <- v::u.adj;
      v.adj <- u::v.adj;
      read_edges (num - 1) ([v; u] @ l) h
;;


let bfs h start = 
  let q = Queue.create () in
  Queue.push start q;
  let rec queue_operate l =
    if Queue.is_empty q then
      List.rev l
    else
      let u = Queue.pop q in 
      List.iter (fun x -> if x.dist == max_int then begin x.dist <- u.dist + 1; x.prev <- Some u; Queue.push x q end) u.adj;
      queue_operate (u::l)
  in 
  queue_operate []
;;

let rec print_list l = 
  match l with 
  | [] -> print_string ""
  | head :: [] -> print_int head.index
  | head :: tail -> print_int head.index; print_string " "; print_list tail
;;

let num_edges = read_int();;

let hash = Hashtbl.create num_edges;;

let v_list = read_edges num_edges [] hash;;
let start = Hashtbl.find hash 0;;
start.dist <- 0;;
let l = bfs hash start;;
print_list l;;