use crate::{db::init::DB_PATH, operation::model::Operation, files::model::Files};

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
pub fn new_log(content: String, result: Option<String>){
    let _ = Operation::new(content,result);
}

/// files
pub fn new_file(virtual_path: String, real_path: String)->i64{
    let r = Files::new_file(virtual_path, real_path);
    match r {
        Ok(r) => r,
        Err(e) => {
            println!("[rust-error] {:?}",e);
            return -1;
        },
    }
}
