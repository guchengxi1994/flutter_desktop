use super::*;
// Section: wire functions

#[wasm_bindgen]
pub fn wire_get_changelogs(port_: MessagePort) {
    wire_get_changelogs_impl(port_)
}

#[wasm_bindgen]
pub fn wire_rust_bridge_say_hello(port_: MessagePort) {
    wire_rust_bridge_say_hello_impl(port_)
}

#[wasm_bindgen]
pub fn wire_set_db_path(port_: MessagePort, s: String) {
    wire_set_db_path_impl(port_, s)
}

#[wasm_bindgen]
pub fn wire_init_db(port_: MessagePort) {
    wire_init_db_impl(port_)
}

#[wasm_bindgen]
pub fn wire_new_log(port_: MessagePort, content: String, result: Option<String>) {
    wire_new_log_impl(port_, content, result)
}

#[wasm_bindgen]
pub fn wire_new_file(port_: MessagePort, virtual_path: String, real_path: String) {
    wire_new_file_impl(port_, virtual_path, real_path)
}

#[wasm_bindgen]
pub fn wire_sys_info_stream(port_: MessagePort) {
    wire_sys_info_stream_impl(port_)
}

#[wasm_bindgen]
pub fn wire_listen_sysinfo(port_: MessagePort, name: Option<String>) {
    wire_listen_sysinfo_impl(port_, name)
}

#[wasm_bindgen]
pub fn wire_set_json_path(port_: MessagePort, s: String) {
    wire_set_json_path_impl(port_, s)
}

#[wasm_bindgen]
pub fn wire_set_cache_path(port_: MessagePort, s: String) {
    wire_set_cache_path_impl(port_, s)
}

#[wasm_bindgen]
pub fn wire_set_idiom_path(port_: MessagePort, s: String) {
    wire_set_idiom_path_impl(port_, s)
}

#[wasm_bindgen]
pub fn wire_get_idioms(port_: MessagePort, count: JsValue) {
    wire_get_idioms_impl(port_, count)
}

#[wasm_bindgen]
pub fn wire_get_one_idiom(port_: MessagePort, index: usize) {
    wire_get_one_idiom_impl(port_, index)
}

#[wasm_bindgen]
pub fn wire_init_folder(port_: MessagePort, s: String) {
    wire_init_folder_impl(port_, s)
}

#[wasm_bindgen]
pub fn wire_create_new_txt(
    port_: MessagePort,
    filename: String,
    open_with: String,
    folder_id: JsValue,
) {
    wire_create_new_txt_impl(port_, filename, open_with, folder_id)
}

#[wasm_bindgen]
pub fn wire_get_children_by_id(port_: MessagePort, i: JsValue) {
    wire_get_children_by_id_impl(port_, i)
}

#[wasm_bindgen]
pub fn wire_new_practice(port_: MessagePort) {
    wire_new_practice_impl(port_)
}

#[wasm_bindgen]
pub fn wire_update_practice(port_: MessagePort, hit: i64, index: i64, row_id: i64) {
    wire_update_practice_impl(port_, hit, index, row_id)
}

#[wasm_bindgen]
pub fn wire_get_last_practice(port_: MessagePort) {
    wire_get_last_practice_impl(port_)
}

#[wasm_bindgen]
pub fn wire_delete_3_days_ago_history(port_: MessagePort) {
    wire_delete_3_days_ago_history_impl(port_)
}

#[wasm_bindgen]
pub fn wire_new_browser_history(port_: MessagePort, s: String) {
    wire_new_browser_history_impl(port_, s)
}

#[wasm_bindgen]
pub fn wire_fetch_history(port_: MessagePort, page: i64) {
    wire_fetch_history_impl(port_, page)
}

// Section: allocate functions

// Section: related functions

// Section: impl Wire2Api

impl Wire2Api<String> for String {
    fn wire2api(self) -> String {
        self
    }
}

impl Wire2Api<Option<String>> for Option<String> {
    fn wire2api(self) -> Option<String> {
        self.map(Wire2Api::wire2api)
    }
}

impl Wire2Api<Vec<u8>> for Box<[u8]> {
    fn wire2api(self) -> Vec<u8> {
        self.into_vec()
    }
}

// Section: impl Wire2Api for JsValue

impl Wire2Api<String> for JsValue {
    fn wire2api(self) -> String {
        self.as_string().expect("non-UTF-8 string, or not a string")
    }
}
impl Wire2Api<i64> for JsValue {
    fn wire2api(self) -> i64 {
        ::std::convert::TryInto::try_into(self.dyn_into::<js_sys::BigInt>().unwrap()).unwrap()
    }
}
impl Wire2Api<Option<String>> for JsValue {
    fn wire2api(self) -> Option<String> {
        (!self.is_undefined() && !self.is_null()).then(|| self.wire2api())
    }
}
impl Wire2Api<Option<i64>> for JsValue {
    fn wire2api(self) -> Option<i64> {
        (!self.is_undefined() && !self.is_null()).then(|| self.wire2api())
    }
}
impl Wire2Api<Option<u64>> for JsValue {
    fn wire2api(self) -> Option<u64> {
        (!self.is_undefined() && !self.is_null()).then(|| self.wire2api())
    }
}
impl Wire2Api<u64> for JsValue {
    fn wire2api(self) -> u64 {
        ::std::convert::TryInto::try_into(self.dyn_into::<js_sys::BigInt>().unwrap()).unwrap()
    }
}
impl Wire2Api<u8> for JsValue {
    fn wire2api(self) -> u8 {
        self.unchecked_into_f64() as _
    }
}
impl Wire2Api<Vec<u8>> for JsValue {
    fn wire2api(self) -> Vec<u8> {
        self.unchecked_into::<js_sys::Uint8Array>().to_vec().into()
    }
}
impl Wire2Api<usize> for JsValue {
    fn wire2api(self) -> usize {
        self.unchecked_into_f64() as _
    }
}
