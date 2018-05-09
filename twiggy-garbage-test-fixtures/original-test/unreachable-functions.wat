(module
  (func $pushOne (result i32)
    i32.const 1
  )

  (func $unusedAddOne (param $val i32) (result i32)
    get_local $val
    call $pushOne
    i32.add)

  (func $addOne (param $val i32) (result i32)
    get_local $val
    call $pushOne
    i32.add)

  (func $double (param $val i32) (result i32)
    get_local $val
    get_local $val
    i32.add)

  (export "addOne" (func $addOne))
  (export "double" (func $double))
)
