# `twiggy garbage` test fixtures

## Overview

This directory contains wasm code used for creating test fixtures for the
`twiggy garbage` command.

## Expected Results

The `wasm-objdump` tool was used to look into the compiled wasm binary.

### Disassembly

```
✨  ./wasm-objdump -d ./garbage_test.wasm

garbage_test.wasm:      file format wasm 0x1

Code Disassembly:

000034 func[0]:
 000036: 41 01                      | i32.const 1
 000038: 0b                         | end
000039 func[1]:
 00003b: 20 00                      | get_local 0
 00003d: 10 00                      | call 0
 00003f: 6a                         | i32.add
 000040: 0b                         | end
000041 func[2]:
 000043: 20 00                      | get_local 0
 000045: 20 01                      | get_local 1
 000047: 6a                         | i32.add
 000048: 20 02                      | get_local 2
 00004a: 6a                         | i32.add
 00004b: 0b                         | end
00004c <add>:
 00004e: 20 00                      | get_local 0
 000050: 20 01                      | get_local 1
 000052: 6a                         | i32.add
 000053: 0b                         | end
```

__Disassembly Notes__

Unexported functions are not given names, functions and their indices in the
code section are listed below.

```
func[0] - unusedChild
func[1] - unusedAddOne
func[2] - unusedAddThreeNumbers
```

### Sizes

```
Section | Name                  | Start Address | End Address | Size |
0       | unusedChild           | 000034        | 000039      | 5    |
1       | unusedAddOne          | 000039        | 000041      | 8    |
2       | unusedAddThreeNumbers | 000041        | 00004c      | 11   |
```

### `twiggy top` Analysis

This is what is shown by the `top` subcommand. We will try and implement
something similar, but in our case we only want to show unreachable items in
the code section. So, only `code[0]`, `code[1]`, and `code[2]` should appear.

```
 Shallow Bytes │ Shallow % │ Item
───────────────┼───────────┼─────────────
            11 ┊    13.10% ┊ code[2]
             8 ┊     9.52% ┊ code[1]
             8 ┊     9.52% ┊ code[3]
             7 ┊     8.33% ┊ type[2]
             6 ┊     7.14% ┊ type[3]
             6 ┊     7.14% ┊ export "add"
             5 ┊     5.95% ┊ type[1]
             5 ┊     5.95% ┊ code[0]
             4 ┊     4.76% ┊ type[0]
             1 ┊     1.19% ┊ func[0]
             1 ┊     1.19% ┊ func[1]
             1 ┊     1.19% ┊ func[2]
             1 ┊     1.19% ┊ func[3]
```

Here is the information regarding the retained size of these objects.

```
 Retained Bytes │ Retained % │ Item
────────────────┼────────────┼─────────────
             21 ┊     25.00% ┊ export "add"
             15 ┊     17.86% ┊ func[3]
             11 ┊     13.10% ┊ code[2]
              8 ┊      9.52% ┊ code[1]
              8 ┊      9.52% ┊ code[3]
              7 ┊      8.33% ┊ type[2]
              6 ┊      7.14% ┊ type[3]
              5 ┊      5.95% ┊ type[1]
              5 ┊      5.95% ┊ code[0]
              4 ┊      4.76% ┊ type[0]
              1 ┊      1.19% ┊ func[0]
              1 ┊      1.19% ┊ func[1]
              1 ┊      1.19% ┊ func[2]
```

Here is the JSON representation of the same information.

```
[
    {"name":"code[2]","shallow_size":11,"shallow_size_percent":13.095238095238097},
    {"name":"code[1]","shallow_size":8,"shallow_size_percent":9.523809523809524},
    {"name":"code[3]","shallow_size":8,"shallow_size_percent":9.523809523809524},
    {"name":"type[2]","shallow_size":7,"shallow_size_percent":8.333333333333332},
    {"name":"type[3]","shallow_size":6,"shallow_size_percent":7.142857142857142},
    {"name":"export \"add\"","shallow_size":6,"shallow_size_percent":7.142857142857142},
    {"name":"type[1]","shallow_size":5,"shallow_size_percent":5.952380952380952},
    {"name":"code[0]","shallow_size":5,"shallow_size_percent":5.952380952380952},
    {"name":"type[0]","shallow_size":4,"shallow_size_percent":4.761904761904762},
    {"name":"func[0]","shallow_size":1,"shallow_size_percent":1.1904761904761905},
    {"name":"func[1]","shallow_size":1,"shallow_size_percent":1.1904761904761905},
    {"name":"func[2]","shallow_size":1,"shallow_size_percent":1.1904761904761905},
    {"name":"func[3]","shallow_size":1,"shallow_size_percent":1.1904761904761905}
]
```

