(module
    ;; ------------------------------------------------------------------------
    ;; This is a WebAssembly text file that can be compiled in a wasm module to
    ;; test the `twiggy paths` command. This intends to provide a non-trivial
    ;; structure of call paths for testing purposes.
    ;;
    ;;     [howl]     [awoo]            [growl]
    ;;                  |                 |||
    ;;                  v                 |||
    ;;     [woof]     [bark]              |||
    ;;       |         | |                |||
    ;;       |  -------- |                |||
    ;;       |  |        |                |||
    ;;       v  v        v                vvv
    ;; 'calledOnce' 'calledTwice' 'calledThriceByOneParent'
    ;; ------------------------------------------------------------------------

    ;; This function is called once, by 'woof'.
    (func $calledOnce (result i32)
        i32.const 1)

    ;; This function is called twice, by 'bark' and 'woof'.
    (func $calledTwice (result i32)
        i32.const 2)

    ;; This function is called three times by a single function, 'growl'.
    (func $calledThriceByOneParent (result i32)
        i32.const 3)

    (func $bark (result i32)
        call $calledTwice)

    (func $woof (result i32)
        call $calledOnce
        call $calledTwice
        i32.add)

    (func $awoo (result i32)
        call $bark)

    (func $growl (result i32)
        call $calledThriceByOneParent
        call $calledThriceByOneParent
        call $calledThriceByOneParent
        i32.add
        i32.add)

    (func $howl (result i32)
        i32.const 0)

    (export "bark" (func $bark))
    (export "woof" (func $woof))
    (export "awoo" (func $awoo))
    (export "growl" (func $growl))
    (export "howl" (func $howl))
)
