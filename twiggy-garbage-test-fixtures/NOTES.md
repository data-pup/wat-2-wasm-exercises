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
