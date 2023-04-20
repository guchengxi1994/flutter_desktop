use super::*;
// Section: wire functions

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
impl Wire2Api<Option<String>> for JsValue {
    fn wire2api(self) -> Option<String> {
        (!self.is_undefined() && !self.is_null()).then(|| self.wire2api())
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
