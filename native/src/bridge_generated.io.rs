use super::*;
// Section: wire functions

#[no_mangle]
pub extern "C" fn wire_get_changelogs(port_: i64) {
    wire_get_changelogs_impl(port_)
}

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

#[no_mangle]
pub extern "C" fn wire_sys_info_stream(port_: i64) {
    wire_sys_info_stream_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_listen_sysinfo(port_: i64, name: *mut wire_uint_8_list) {
    wire_listen_sysinfo_impl(port_, name)
}

#[no_mangle]
pub extern "C" fn wire_set_json_path(port_: i64, s: *mut wire_uint_8_list) {
    wire_set_json_path_impl(port_, s)
}

#[no_mangle]
pub extern "C" fn wire_set_cache_path(port_: i64, s: *mut wire_uint_8_list) {
    wire_set_cache_path_impl(port_, s)
}

#[no_mangle]
pub extern "C" fn wire_set_idiom_path(port_: i64, s: *mut wire_uint_8_list) {
    wire_set_idiom_path_impl(port_, s)
}

#[no_mangle]
pub extern "C" fn wire_get_idioms(port_: i64, count: *mut u64) {
    wire_get_idioms_impl(port_, count)
}

#[no_mangle]
pub extern "C" fn wire_get_one_idiom(port_: i64, index: usize) {
    wire_get_one_idiom_impl(port_, index)
}

#[no_mangle]
pub extern "C" fn wire_init_folder(port_: i64, s: *mut wire_uint_8_list) {
    wire_init_folder_impl(port_, s)
}

#[no_mangle]
pub extern "C" fn wire_create_new_txt(
    port_: i64,
    filename: *mut wire_uint_8_list,
    open_with: *mut wire_uint_8_list,
    folder_id: *mut i64,
) {
    wire_create_new_txt_impl(port_, filename, open_with, folder_id)
}

#[no_mangle]
pub extern "C" fn wire_delete_file(port_: i64, id: i64) {
    wire_delete_file_impl(port_, id)
}

#[no_mangle]
pub extern "C" fn wire_restore_file(port_: i64, id: i64) {
    wire_restore_file_impl(port_, id)
}

#[no_mangle]
pub extern "C" fn wire_get_children_by_id(port_: i64, i: *mut i64) {
    wire_get_children_by_id_impl(port_, i)
}

#[no_mangle]
pub extern "C" fn wire_new_practice(port_: i64) {
    wire_new_practice_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_update_practice(port_: i64, hit: i64, index: i64, row_id: i64) {
    wire_update_practice_impl(port_, hit, index, row_id)
}

#[no_mangle]
pub extern "C" fn wire_get_last_practice(port_: i64) {
    wire_get_last_practice_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_delete_3_days_ago_history(port_: i64) {
    wire_delete_3_days_ago_history_impl(port_)
}

#[no_mangle]
pub extern "C" fn wire_new_browser_history(port_: i64, s: *mut wire_uint_8_list) {
    wire_new_browser_history_impl(port_, s)
}

#[no_mangle]
pub extern "C" fn wire_fetch_history(port_: i64, page: i64) {
    wire_fetch_history_impl(port_, page)
}

// Section: allocate functions

#[no_mangle]
pub extern "C" fn new_box_autoadd_i64_0(value: i64) -> *mut i64 {
    support::new_leak_box_ptr(value)
}

#[no_mangle]
pub extern "C" fn new_box_autoadd_u64_0(value: u64) -> *mut u64 {
    support::new_leak_box_ptr(value)
}

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
impl Wire2Api<i64> for *mut i64 {
    fn wire2api(self) -> i64 {
        unsafe { *support::box_from_leak_ptr(self) }
    }
}
impl Wire2Api<u64> for *mut u64 {
    fn wire2api(self) -> u64 {
        unsafe { *support::box_from_leak_ptr(self) }
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
