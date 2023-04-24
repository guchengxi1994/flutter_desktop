use lazy_static::lazy_static;
use std::{fs::File, path::Path, sync::Mutex};
use tokio::runtime::Runtime;

use super::connection::{MyPool, POOL};

lazy_static! {
    pub static ref DB_PATH: Mutex<String> = Mutex::new(String::new());
}

pub fn path_exists(p: String) -> bool {
    Path::new(&p).exists()
}

const CREATE_OPERATION_DB: &str = "CREATE TABLE IF NOT EXISTS operations (
    operation_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    operation_content TEXT,
    operation_result TEXT,
    create_at integer
)";

const CREATE_FILE_DB: &str = "CREATE TABLE IF NOT EXISTS files (
    file_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    virtual_path TEXT,
    real_path TEXT,
    file_type TEXT,
    icon TEXT,
    open_with TEXT,
    is_deleted integer DEFAULT 0,
    create_at integer
)";

const CREATE_FOLDER_DB: &str = "CREATE TABLE IF NOT EXISTS folders (
    folder_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    folder_name TEXT,
    create_at integer,
    is_deleted integer DEFAULT 0
)";

pub fn init_when_first_time_start() -> anyhow::Result<()> {
    let rt = Runtime::new().unwrap();
    rt.block_on(async {
        let db_path = (*DB_PATH.lock().unwrap()).clone();
        // let url = format!("sqlite:{:?}",db_path.as_str());
        let url = String::from("sqlite:") + &db_path;
        println!("{:?}", url);

        if path_exists(db_path.clone()) {
            let pool = POOL.clone();
            let mut pool = pool.write().await;
            *pool = MyPool::new(&url).await;
            return anyhow::Ok(());
        }
        let _ = File::create(db_path)?;
        let pool = POOL.clone();
        let mut pool = pool.write().await;
        *pool = MyPool::new(&url).await;
        let _ = sqlx::query(CREATE_OPERATION_DB)
            .execute(pool.get_pool())
            .await?;

        let _ = sqlx::query(CREATE_FILE_DB).execute(pool.get_pool()).await?;
        let _ = sqlx::query(CREATE_FOLDER_DB).execute(pool.get_pool()).await?;
        anyhow::Ok(())
    })
}
