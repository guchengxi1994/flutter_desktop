use std::time::{SystemTime, UNIX_EPOCH};

use rs_filemanager::model::folder::Folder;
use sqlx::{Pool, Sqlite};

use super::{
    file_structure::{FOLDER_STATE, GLOBAL_FOLDER_ID, JSON_PATH},
    vitrual_file::VirtualFile,
};

#[derive(Clone, Debug, sqlx::FromRow)]
pub struct VirtualFolder {
    pub folder_id: i64,
    pub create_at: i64,
    pub is_deleted: i64,
    pub folder_name: String,
}

pub enum FileOrFolder {
    File(VirtualFile),
    Folder(VirtualFolder),
}

impl VirtualFolder {
    pub async fn from_folder(folder: Folder, pool: &Pool<Sqlite>) -> Option<VirtualFolder> {
        // let pool = crate::db::connection::POOL.read().await;
        let _sql = sqlx::query_as::<sqlx::Sqlite, VirtualFolder>(
            r#"SELECT * from folders where is_deleted = 0 and folder_id = ?"#,
        )
        .bind(folder.folder_id)
        .fetch_one(pool)
        .await;

        match _sql {
            Ok(s) => {
                // println!("{:?}",s.Gallery_id);
                return Some(s);
            }
            Err(e) => {
                println!("[rust-error-gallery]:{:?}", e);
                return None;
            }
        }
    }

    #[tokio::main]
    pub async fn new_folder(name: String, parent_id: Option<i64>) -> i64 {
        let pool = crate::db::connection::POOL.write().await;
        let _t = SystemTime::now()
            .duration_since(UNIX_EPOCH)
            .unwrap()
            .as_secs();
        let _sql = sqlx::query(r#"INSERT INTO folders (folder_name,create_at) VALUES (?,?)"#)
            .bind(name.clone())
            .bind(_t as i64)
            .execute(pool.get_pool())
            .await;
        match _sql {
            Ok(s) => {
                let current_folder_id: i64;
                match parent_id {
                    Some(i) => {
                        current_folder_id = i;
                    }
                    None => {
                        current_folder_id = *GLOBAL_FOLDER_ID.lock().unwrap();
                    }
                }

                // Folder::add_a_folder_to_current_folder();
                FOLDER_STATE.lock().unwrap().add_a_folder_to_current_folder(
                    current_folder_id,
                    Folder {
                        children: vec![],
                        folder_id: s.last_insert_rowid(),
                        name,
                        parent_id: Some(current_folder_id),
                    },
                );
                FOLDER_STATE
                    .lock()
                    .unwrap()
                    .to_file(JSON_PATH.lock().unwrap().to_string());
                return s.last_insert_rowid();
            }
            Err(e) => {
                println!("[rust-new-folder-err] : {:?}", e);
                return 0;
            }
        }
    }

    pub fn get_children(parent_id: Option<i64>) -> Vec<FileOrFolder> {
        let rt = tokio::runtime::Runtime::new().unwrap();
        let folder_id: i64;
        match parent_id {
            Some(i) => {
                folder_id = i;
            }
            None => {
                folder_id = *GLOBAL_FOLDER_ID.lock().unwrap();
            }
        }

        rt.block_on(async {
            let folder = FOLDER_STATE.lock().unwrap();
            let folder_or_files = folder.get_children(folder_id);
            println!("[rust-vec-length] : {:?}", folder_or_files.len());
            let mut res: Vec<FileOrFolder> = Vec::new();

            let pool = crate::db::connection::POOL.read().await;
            let _p = pool.get_pool();

            for i in folder_or_files {
                match i {
                    rs_filemanager::model::folder::FileOrFolder::File(file) => {
                        match VirtualFile::from_file(file, _p).await {
                            Some(w) => {
                                res.push(FileOrFolder::File(w));
                            }
                            None => {}
                        }
                    }
                    rs_filemanager::model::folder::FileOrFolder::Folder(folder) => {
                        match VirtualFolder::from_folder(folder, _p).await {
                            Some(w) => {
                                res.push(FileOrFolder::Folder(w));
                            }
                            None => {}
                        }
                    }
                }
            }
            res
        })
    }
}
