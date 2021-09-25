let rec printList list =
  let rec printListHelper = function 
    | [e] -> print_int e
    | e::l -> print_int e; print_string "; " ; printListHelper l 
    | [] -> ()
  in
  print_string "[";
  printListHelper list;
  print_string "]\n"

let rec readList list =
  let x = read_int () in
  if x == 0 then
    list
  else
    readList (x::list)

let () =
  readList []
  |> List.rev
  |> printList