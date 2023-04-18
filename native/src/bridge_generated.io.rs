use super::*;
// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_rust_bridge_say_hello(port_: i64) {
    wire_rust_bridge_say_hello_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_set_db_path(port_: i64, s: *mut wire_uint_8_list) {
    wire_set_db_path_impl(port_, s)
}

#[no_mangle]
pub extern "C" fn wire_init_db(port_: i64) {
    wire_init_db_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_new_log(
    port_: i64,
    content: *mut wire_uint_8_list,
    result: *mut wire_uint_8_list,
) {
    wire_new_log_impl(port_, content, result)
}

#[no_mangle]
pub extern "C" fn wire_new_file(
    port_: i64,
    virtual_path: *mut wire_uint_8_list,
    real_path: *mut wire_uint_8_list,
) {
    wire_new_file_impl(port_, virtual_path, real_path)
}

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_uint_8_list_0(len: i32) -> *mut wire_uint_8_list {
    let ans = wire_uint_8_list {
        ptr: support::new_leak_vec_ptr(Default::default(), len),
        len,
    };
    support::new_leak_box_ptr(ans)
}

// Section: related functions

// Section: impl Wire2Api

impl Wire2Api<String> for *mut wire_uint_8_list {
    fn wire2api(self) -> String {
        let vec: Vec<u8> = self.wire2api();
        String::from_utf8_lossy(&vec).into_owned()
    }
}

impl Wire2Api<Vec<u8>> for *mut wire_uint_8_list {
    fn wire2api(self) -> Vec<u8> {
        unsafe {
            let wrap = support::box_from_leak_ptr(self);
            support::vec_from_leak_ptr(wrap.ptr, wrap.len)
        }
    }
}
// Section: wire structs

#[repr(C)]
#[derive(Clone)]
pub struct wire_uint_8_list {
    ptr: *mut u8,
    len: i32,
}

// Section: impl NewWithNullPtr

pub trait NewWithNullPtr {
    fn new_with_null_ptr() -> Self;
}

impl<T> NewWithNullPtr for *mut T {
    fn new_with_null_ptr() -> Self {
        std::ptr::null_mut()
    }
}

// Section: sync execution mode utility

#[no_mangle]
pub extern "C" fn free_WireSyncReturn(ptr: support::WireSyncReturn) {
    unsafe {
        let _ = support::box_from_leak_ptr(ptr);
    };
}
