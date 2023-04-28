use std::time::{SystemTime, UNIX_EPOCH};

#[derive(Debug, serde::Deserialize, sqlx::FromRow)]
pub struct BrowserHistory {
    pub visit_id: i64,
    pub url: String,
    pub create_at: i64,
    pub is_deleted: i64,
}

const SECS_IN_ONE_DAY: u64 = 86400;
const PAGE_SIZE: u64 = 20;

impl BrowserHistory {
    // 删除三天前的历史记录
    pub fn delete_history_from_db(days: u64) -> anyhow::Result<()> {
        let rt = tokio::runtime::Runtime::new().unwrap();
        rt.block_on(async {
            let _t = SystemTime::now()
                .duration_since(UNIX_EPOCH)
                .unwrap()
                .as_secs();
            let pool = crate::db::connection::POOL.read().await;
            let _p = pool.get_pool();

            let _ = sqlx::query(r#"DELETE FROM browser_history WHERE create_at<?"#)
                .bind((_t - days * SECS_IN_ONE_DAY) as i64)
                .execute(_p)
                .await?;

            anyhow::Ok(())
        })
    }

    pub fn new(url: String) -> anyhow::Result<()> {
        let rt = tokio::runtime::Runtime::new().unwrap();
        rt.block_on(async {
            let _t = SystemTime::now()
                .duration_since(UNIX_EPOCH)
                .unwrap()
                .as_secs();
            let pool = crate::db::connection::POOL.read().await;
            let _p = pool.get_pool();
            let _ = sqlx::query(r#"INSERT INTO browser_history (url,create_at) values (?,?)"#)
                .bind(url)
                .bind(_t as i64)
                .execute(_p)
                .await?;

            anyhow::Ok(())
        })
    }

    pub fn fetch(page: i64) -> Vec<Self> {
        let rt = tokio::runtime::Runtime::new().unwrap();
        rt.block_on(async {
            let pool = crate::db::connection::POOL.read().await;
            let _p = pool.get_pool();

            let _sql = sqlx::query_as::<sqlx::Sqlite, Self>(
                r#"SELECT * from browser_history where is_deleted = 0 order by  visit_id desc LIMIT ?,? "#,
            )
            .bind(page * PAGE_SIZE as i64)
            .bind(PAGE_SIZE as i64)
            .fetch_all(_p)
            .await;
            match _sql {
                Ok(o) => {
                    return o;
                }
                Err(e) => {
                    println!("[rust-error] : {:?}", e);
                    return Vec::new();
                }
            }
        })
    }
}
