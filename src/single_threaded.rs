use rutie::{
    class, methods, wrappable_struct, AnyObject, Class, Float, Hash, Module, Object, RString,
    Symbol,
};
use std::collections::{BTreeSet, HashMap};
use std::sync::RwLock;

use lazy_static::lazy_static;

lazy_static! {
    static ref METRIC_STORE_CLASS: RwLock<Option<Class>> = RwLock::new(None);
}

#[derive(Debug, Default)]
pub struct RustMetricStore {
    internal_store: HashMap<BTreeSet<(String, String)>, f64>,
}

impl RustMetricStore {
    pub fn get(&self, key: BTreeSet<(String, String)>) -> f64 {
        *self.internal_store.get(&key).unwrap_or(&0.0)
    }
}

wrappable_struct!(
    RustMetricStore,
    RustMetricStoreWrapper,
    METRIC_STORE_WRAPPER
);

class!(MetricStore);

methods!(
    MetricStore,
    _rtself,
    fn pub_new() -> AnyObject {
        let store = RustMetricStore::default();

        METRIC_STORE_CLASS
            .read()
            .unwrap()
            .as_ref()
            .unwrap()
            .wrap_data(store, &*METRIC_STORE_WRAPPER)
    },
    fn pub_get(labels: Hash) -> Float {
        let store = _rtself.get_data(&*METRIC_STORE_WRAPPER);

        // TODO: raise a Ruby exception if we're passed something other than a Hash
        let key = hash_to_btreeset(labels.unwrap());

        Float::new(store.get(key))
    }
);

fn hash_to_btreeset(h: Hash) -> BTreeSet<(String, String)> {
    let mut set = BTreeSet::new();

    h.each(|k, v| {
        if let Ok(k) = k.try_convert_to::<Symbol>() {
            if let Ok(v) = v.try_convert_to::<RString>() {
                let k = k.to_string();
                let v = v.to_string();

                set.insert((k, v));
            }
        }
    });

    set
}

pub fn init(module: Module) {
    let mut class = module
        .get_nested_class("SingleThreaded")
        .get_nested_class("MetricStore");

    class.def_self("new", pub_new);
    class.def("get", pub_get);

    *METRIC_STORE_CLASS.write().unwrap() = Some(class);
}
