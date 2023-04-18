use lazy_static::lazy_static;
use std::time::{SystemTime, UNIX_EPOCH};
#[derive(Clone, Debug, sqlx::FromRow)]
pub struct Files {
    pub file_id: i64,
    pub virtual_path: String,
    pub real_path: String,
    pub file_type: String,
    pub icon: String,
    pub create_at: i64,
}

lazy_static! {
    static ref AUDIO_TYPES: Vec<String> = {
        let mut v: Vec<String> = Vec::new();
        v.push(String::from("mp3"));
        v
    };
}

#[allow(dead_code)]
impl Files {
    fn is_audio(ext: String) -> bool {
        AUDIO_TYPES.contains(&ext)
    }

    pub fn get_icon(ext: String) -> String {
        if Self::is_audio(ext) {
            return String::from("assets/images/appicons/audio.png");
        }

        String::from("assets/images/appicons/unknow.png")
    }

    pub fn infer_type(s: String) -> String {
        let ext = String::from(s.split(".").last().unwrap_or("unknow"));
        let kind = infer::get_from_path(s);
        match kind {
            Ok(k) => match k {
                Some(_k) => {
                    if _k.mime_type() == "application/zip" && _k.extension() == "zip" {
                        return ext;
                    }

                    if _k.mime_type() == "application/x-ole-storage" && _k.extension() == "msi" {
                        return ext;
                    }

                    println!("{:?}", _k.mime_type());
                    return String::from(_k.extension());
                }
                None => String::from("unknow"),
            },
            Err(_) => {
                return String::from("err");
            }
        }
    }

    pub fn new_file(virtual_path: String, real_path: String) -> anyhow::Result<i64> {
        let ext = Self::infer_type(real_path.clone());
        let icon = Self::get_icon(ext.clone());

        let rt = tokio::runtime::Runtime::new().unwrap();
        rt.block_on(async {
            let _t = SystemTime::now()
                .duration_since(UNIX_EPOCH)
                .unwrap()
                .as_secs();
            let pool = crate::db::connection::POOL.read().await;
            let _p = pool.get_pool();
            let _sql = sqlx::query(
                r#"INSERT INTO files (virtual_path,real_path,file_type,icon,create_at) VALUES (?,?,?,?,?)"#,
            )
            .bind(virtual_path)
            .bind(real_path)
            .bind(ext).bind(icon)
            .bind(_t as i64)
            .execute(_p)
            .await?;

            anyhow::Ok(_sql.last_insert_rowid())
        })
    }
}
