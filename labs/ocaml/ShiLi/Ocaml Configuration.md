# OCaml Configuration Guide

## Part 1. OCaml

1. Install OCaml
```bash
sudo apt-get install ocaml
```
2. Install OPAM (package manager for OCaml)
```bash
sudo apt-get install opam
```
3. Initialize OPAM
```bash
opam init
```
4. Update the current shell environment
```bash
eval $(opam env)
```
5. (Optional) Install Merlin, which offers some useful functions such as auto-completion in IDEs
```bash
opam install merlin
```
6. (Optional) Install ocp-indent and ocamlformat, which automatically set the indents of OCaml code
```bash
opam install ocp-indent
```

## Part 2. Visual Studio Code

> Note: There are also plugins for other IDEs, such as Eclipse, Atom, IntelliJ IDEA, etc.

1. Install the plugin [OCaml and Reason IDE
](https://marketplace.visualstudio.com/items?itemName=freebroccolo.reasonml)

2. In `settings.json`, add
```
"reason.path.ocamlmerlin": "/Users/yourname/.opam/default/bin/ocamlmerlin",
"reason.path.ocamlfind": "/Users/yourname/.opam/default/bin/ocamlfind",
"reason.path.ocpindent": "/Users/yourname/.opam/default/bin/ocp-indent",
"reason.diagnostics.tools": [
    "merlin"
],
```

> Note: The default path may differ on your computer. You can use `which` command to find the correct path. Use absolute path here.

3. (Optional) If you want to auto-format your code when saving, add
```
"editor.formatOnSave": true,
"reason.codelens.enabled": true,
```