use flutter_rust_bridge::StreamSink;

use crate::{
    db::init::DB_PATH,
    files::{
        file_structure::{CACHE_PATH, JSON_PATH},
        virtual_folder::{FileOrFolder, VirtualFolder},
        vitrual_file::VirtualFile,
    },
    idiom::model::{Idiom, IDIOM_PATH},
    native_sysinfo::{NativeSysInfo, SEND_TO_DART_NATIVESYSINFO_SINK},
    operation::model::Operation,
};

pub fn rust_bridge_say_hello() -> String {
    String::from("hello from rust")
}

// 设置 db 路径
pub fn set_db_path(s: String) {
    let mut _s = DB_PATH.lock().unwrap();
    *_s = s;
}

pub fn init_db() {
    let m = crate::db::init::init_when_first_time_start();
    match m {
        Ok(_) => {
            println!("初始化数据库成功")
        }
        Err(e) => {
            println!("[rust-init-db-err] : {:?}", e);
            println!("初始化数据库失败")
        }
    }
}

/// operation-logger
pub fn new_log(content: String, result: Option<String>) {
    let _ = Operation::new(content, result);
}

/// files
pub fn new_file(virtual_path: String, real_path: String) -> i64 {
    let r = VirtualFile::new_file(virtual_path, real_path, String::new());
    match r {
        Ok(r) => r,
        Err(e) => {
            println!("[rust-error] {:?}", e);
            return -1;
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

// 设置 json 路径
pub fn set_json_path(s: String) {
    if !crate::db::init::path_exists(s.clone()) {
        let _ = std::fs::File::create(s.clone());
    }
    let mut _s = JSON_PATH.lock().unwrap();
    *_s = s;
}

// 设置 cache 路径
pub fn set_cache_path(s: String) {
    if !crate::db::init::path_exists(s.clone()) {
        let _ = std::fs::create_dir(s.clone());
    }
    let mut _s = CACHE_PATH.lock().unwrap();
    *_s = s;
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

// init path
pub fn init_folder(s: String) {
    if !crate::db::init::path_exists(s.clone()) {
        let _ = std::fs::create_dir(s.clone());
    }
}

// 创建新的文本文件
pub fn create_new_txt(filename: String, open_with: String, folder_id: Option<i64>) {
    let r = VirtualFile::create_new_txt_file(filename, open_with, folder_id);
    match r {
        Ok(_) => {}
        Err(e) => {
            println!("[rust-error] : {:?}", e)
        }
    }
}

// 获取所有文件/夹
pub fn get_children_by_id(i: Option<i64>) -> Vec<FileOrFolder> {
    VirtualFolder::get_children(i)
}
