use crate::frb_generated::StreamSink;

use crate::{
    browser::history::BrowserHistory,
    db::init::DB_PATH,
    files::{
        file_structure::{CACHE_PATH, JSON_PATH},
        virtual_folder::{FileOrFolder, VirtualFolder},
        vitrual_file::VirtualFile,
    },
    idiom::{
        model::{Idiom, IDIOM_PATH},
        practice::PracticeStatus,
    },
    native_sysinfo::{NativeSysInfo, SEND_TO_DART_NATIVESYSINFO_SINK},
    operation::model::Operation,
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



pub fn get_changelogs() -> String {
    return String::from_utf8_lossy(&crate::system::CHANGELOG).to_string();
}

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

// get one
pub fn get_one_idiom(index: usize) -> Option<Idiom> {
    Idiom::get_idiom_by_id(index)
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
pub fn get_children_by_id(i: Option<i64>) -> Vec<FileOrFolder> {
    VirtualFolder::get_children(i)
}

// 创建新的 practice row
pub fn new_practice() -> i64 {
    let r = PracticeStatus::new_log();
    match r {
        Ok(r0) => {
            return r0;
        }
        Err(e) => {
            println!("[rust-practice-error] :{:?}", e);
            return -1;
        }
    }
}

pub fn update_practice(hit: i64, index: i64, row_id: i64) {
    let r = PracticeStatus::save_practice_status(hit, index, row_id);
    match r {
        Ok(_) => {}
        Err(e) => {
            println!("[rust-practice-error] :{:?}", e);
        }
    }
}

// 获取最新的practice
pub fn get_last_practice() -> Option<PracticeStatus> {
    PracticeStatus::get_last()
}

// 删除三天前的记录
pub fn delete_3_days_ago_history() {
    let r = BrowserHistory::delete_history_from_db(3);
    match r {
        Ok(_) => {}
        Err(e) => {
            println!("[rust-error] {:?}", e);
        }
    }
}
// 新加一个浏览记录
pub fn new_browser_history(s: String) {
    let r = BrowserHistory::new(s);
    match r {
        Ok(_) => {}
        Err(e) => {
            println!("[rust-error] {:?}", e);
        }
    }
}

// 按页码获取分页历史记录
pub fn fetch_history(page: i64) -> Vec<BrowserHistory> {
    BrowserHistory::fetch(page)
}
