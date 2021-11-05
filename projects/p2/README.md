# VE477 Project2

## 1. Tonelli-Shanks Algorithm

In the zip file, there exists an `OCaml` source file named `problem_52.ml`, in which I implemented the Tonelli-Shanks algorithm.

Since I used the Z-module to handle large numbers, you can follow the instructions at 

[Zarith](https://github.com/ocaml/Zarith) to install the library first in Linux environment, and then run the code following the command below:

`ocamlopt -I +zarith zarith.cmxa -o tonelli problem_52.ml`

After that, you can type in the command `./tonelli` to run the code. It will first ask you to input two numbers, $n$ and $p$, with space separated. Then, it will automatically find the next prime $p^\prime$ of $p$ and calculate the square root of $n\ mod\ p^\prime$.

Finally, if the solution exists, it will show the two roots $r$ and $p-r$ in the terminal. If it doesn't exists, it will tell you that no solution exists.

### Sample Input and Output

```ocaml
Please input the remainder n and a number p to find the next prime, with space seperated: 
7163487168 12371903851039

n = 7163487168
p = 12371903851081
root1 = 1045550428608
root2 = 11326353422473


Please input the remainder n and a number p to find the next prime, with space seperated: 
1284197987 3821098401321

n = 1284197987
p = 3821098401437
No solution exists
```



## 2. Lempel Ziv Welch

There also exists another `python` source file named `problem_135.py`, in which the LZW algorithm is implemented.

To run the code, you can simply type the command `python problem_135.py`, and it will ask you to input a string to be compressed and then decompressed to the original string. In the output, it will show the list of codes after compression and the string after decompression. If the string after decompression is the same as the original one, a line of `Success!` will show up at the end.

### Sample Input and Output

```python
Please input a string to be compressed:sfahlsdjdh24ur09ufadc
The compressed codes are: 
[115, 102, 97, 104, 108, 115, 100, 106, 100, 104, 50, 52, 117, 114, 48, 57, 117, 257, 100, 99]
The decompressed string is: sfahlsdjdh24ur09ufadc
Success!


Please input a string to be compressed:aixcjlk14reodufj3059rtueoudo
The compressed codes are: 
[97, 105, 120, 99, 106, 108, 107, 49, 52, 114, 101, 111, 100, 117, 102, 106, 51, 48, 53, 57, 114, 116, 117, 266, 117, 100, 111]
The decompressed string is: aixcjlk14reodufj3059rtueoudo
Success!
```

