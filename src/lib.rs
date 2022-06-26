use rutie::{Object, Module, RString, VM, class, methods};

class!(SingleThreaded);

methods!(
    SingleThreaded,
    _rtself,

    fn pub_reverse(input: RString) -> RString {
        let ruby_string = input.
            map_err(|e| VM::raise_ex(e) ).
            unwrap();

        RString::new_utf8(
            &ruby_string.
            to_string().
            chars().
            rev().
            collect::<String>()
        )
    }
);

#[allow(non_snake_case)]
#[no_mangle]
pub extern "C" fn Init_data_stores_module() {
    let mut module = Module::from_existing("Prometheus").
        get_nested_module("Client").
        get_nested_module("DataStores").
        get_nested_module("Rust");

    module.define_nested_class("SingleThreaded", None).define(|klass| {
        klass.def_self("reverse", pub_reverse);
    });
}
