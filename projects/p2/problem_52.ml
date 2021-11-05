let tonelli_shanks n p =
  let open Z in
    let two = (of_int 2) in
      let pp = pred p in    (*pp = p - 1*)
        let ph = pred p / two in    (*ph = (p-1)/2*)
          let legendre a = powm a ph p in   (*legendre calculates the legendre symbol of a and p*)
 
  if legendre n <> one then None
  else
    let s = trailing_zeros pp in    (*p = q*2^s*)
    if s = 1 then
      let r = powm n (succ p / (of_int 4)) p in   (*the case when p = 3 mod 4*)
      Some (r, p - r)
    else
      let q = pp asr s in   (*q = pp >> s*)
      let z =
        let rec find_z z =    (*find the first non square root z*)
          if legendre z = pp then z 
          else find_z (succ z)
        in
        find_z two
      in
      let rec loop m c t r =    (*the final loop*)
        if t = one then (r, p - r)    (*if t = 1, no change should be done to t and r*)
        else
          let mm = pred m in    (*mm = m - 1*)
          let rec find_i n i =    (*find the first i which satisfies t^{2^i} = 1*)
            if n = one || i >= mm then i 
            else find_i (n * n mod p) (succ i)
          in
          let rec calc_b b e =    (*To calculate b = c^{2^{mm - i}}*)
            if e <= zero then b 
            else calc_b (b * b mod p) (pred e)
          in
          let i = find_i t zero in
            let b = calc_b c (mm - i) in
              let c = powm b (of_int 2) p in
                loop i c (t * c mod p) (r * b mod p)
      in
      Some
        (loop (of_int s) (powm z q p) (powm n q p) (powm n (succ q / two) p))
 
let () =
  let open Z in
    print_endline "Please input the remainder n and a number p to find the next prime, with space seperated: \n";
    let n, p = Scanf.scanf " %s %s" (fun a b -> (a, b)) in
      let nn = of_string n in
        let pp = nextprime (of_string p) in
          Printf.printf "n = %s\np = %s\n" (to_string nn) (to_string pp);
          match tonelli_shanks nn pp with
          | Some (r1, r2) ->
            Printf.printf "root1 = %s\nroot2 = %s\n\n" (to_string r1) (to_string r2)
          | None -> print_endline "No solution exists\n"