let create_hash hash n = 
  for i = 0 to n - 1 do
    Hashtbl.add hash i []
  done
;;

let init hash e = 
  for i = 0 to e - 1 do
    let (node_from, node_to) = Scanf.scanf " %d %d" (fun a b -> (a, b)) in
    let x = Hashtbl.find hash node_from in
    Hashtbl.remove hash node_from;
    if List.mem node_to x then Hashtbl.add hash node_from x
    else Hashtbl.add hash node_from (node_to :: x)
  done
;;

let dfs graph visited start = 
  let rec explore path visited node = 
    if List.mem node visited then visited
    else     
      let new_path = node :: path in 
      let edges = List.assoc node graph in
      let visited = List.fold_left (explore new_path) visited edges in
      node :: visited
  in explore [] visited start
;;

let toposort graph = 
  List.fold_left (fun visited (node,_) -> dfs graph visited node) [] graph
;;

let rec print l = 
  match l with
  | [] -> print_string ""
  | head :: [] -> print_int head
  | head :: tail -> print_int head; print_string " "; print tail
;;
let n = read_int();;
let h = Hashtbl.create n;;
let e = read_int();;

create_hash h n;;
init h e;;
let l = Hashtbl.fold (fun x y z -> (x, y) :: z) h [];;
let result = toposort l;;
print result;;