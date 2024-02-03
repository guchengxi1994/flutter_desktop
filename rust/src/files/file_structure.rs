use futures::executor::block_on;
use lazy_static::lazy_static;
use rs_filemanager::model::folder::Folder;
use std::sync::Mutex;

lazy_static! {
    pub static ref JSON_PATH: Mutex<String> = Mutex::new(String::new());
    pub static ref CACHE_PATH:Mutex<String> = Mutex::new(String::new());
    pub static ref FOLDER_STATE: Mutex<Folder> = {
        let folder = Folder::default_with_save_path(
            block_on(async { JSON_PATH.lock().unwrap() }).to_string(),
        );
        Mutex::new(folder)
    };
    pub static ref GLOBAL_FOLDER_ID: Mutex<i64> = {
        let folder_id = 0;
        Mutex::new(folder_id)
    };
}


