mod single_threaded;

use rutie::Module;

#[allow(non_snake_case)]
#[no_mangle]
pub extern "C" fn Init_data_stores_module() {
    let module = Module::from_existing("Prometheus")
        .get_nested_module("Client")
        .get_nested_module("DataStores")
        .get_nested_module("Rust");

    single_threaded::init(module);
}
