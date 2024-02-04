use crate::frb_generated::StreamSink;

use crate::idiom::model::IDIOM_PATH;
use crate::{
    files::{
        virtual_folder::{FileOrFolder, VirtualFolder},
        vitrual_file::VirtualFile,
    },
    idiom::model::Idiom,
    native_sysinfo::{NativeSysInfo, SEND_TO_DART_NATIVESYSINFO_SINK},
};

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}!")
}

#[flutter_rust_bridge::frb(init)]
pub fn init_app() {
    // Default utilities - feel free to customize
    flutter_rust_bridge::setup_default_user_utils();
}

pub fn init_system(s: Vec<String>) {
    for i in s {
        let _ = std::fs::create_dir_all(i.clone());
    }
}

pub fn get_changelogs() -> String {
    return String::from_utf8_lossy(&crate::system::CHANGELOG).to_string();
}

pub fn rust_bridge_say_hello() -> String {
    String::from("hello from rust")
}

/// files
#[deprecated]
pub fn new_file(virtual_path: String, real_path: String) -> i64 {
    let r = VirtualFile::new_file(virtual_path, real_path, String::new());
    match r {
        Ok(r) => r,
        Err(e) => {
            println!("[rust-error] {:?}", e);
            -1
        }
    }
}

// native sysinfo stream
pub fn sys_info_stream(s: StreamSink<NativeSysInfo>) -> anyhow::Result<()> {
    let mut stream = SEND_TO_DART_NATIVESYSINFO_SINK.write().unwrap();
    *stream = Some(s);
    anyhow::Ok(())
}

pub fn listen_sysinfo(name: Option<String>) {
    crate::native_sysinfo::start_listen(name)
}

// 设置字典位置
pub fn set_idiom_path(s: String) {
    let mut _s = IDIOM_PATH.lock().unwrap();
    *_s = s;
}

// sample
pub fn get_idioms(count: Option<u64>) -> Vec<Idiom> {
    Idiom::sample(count)
}

// get one
pub fn get_one_idiom(index: usize) -> Option<Idiom> {
    Idiom::get_idiom_by_id(index)
}

// 创建新的文本文件
#[deprecated]
pub fn create_new_txt(filename: String, open_with: String, folder_id: Option<i64>) {
    let r = VirtualFile::create_new_txt_file(filename, open_with, folder_id);
    match r {
        Ok(_) => {}
        Err(e) => {
            println!("[rust-error] : {:?}", e)
        }
    }
}

pub fn delete_file(id: i64) {
    let r = VirtualFile::delete_file(id);
    match r {
        Ok(_) => {}
        Err(e) => {
            println!("[rust-error] : {:?}", e)
        }
    }
}

pub fn restore_file(id: i64) {
    let r = VirtualFile::restore_file(id);
    match r {
        Ok(_) => {}
        Err(e) => {
            println!("[rust-error] : {:?}", e)
        }
    }
}

// 获取所有文件/夹
#[deprecated]
pub fn get_children_by_id(i: Option<i64>) -> Vec<FileOrFolder> {
    VirtualFolder::get_children(i)
}
