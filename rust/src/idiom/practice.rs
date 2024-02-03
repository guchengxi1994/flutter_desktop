use std::time::{SystemTime, UNIX_EPOCH};

#[derive(Debug, serde::Deserialize, sqlx::FromRow)]
pub struct PracticeStatus {
    pub hit: i64,
    pub current: i64,
    pub practice_id: i64,
    pub create_at: i64,
}

impl PracticeStatus {
    pub fn save_practice_status(hit: i64, index: i64, row_id: i64) -> anyhow::Result<()> {
        let rt = tokio::runtime::Runtime::new().unwrap();
        rt.block_on(async {
            let pool = crate::db::connection::POOL.read().await;
            let _p = pool.get_pool();
            let _ = sqlx::query(r#"UPDATE practice SET hit=?,current=? where practice_id=?"#)
                .bind(hit)
                .bind(index)
                .bind(row_id)
                .execute(_p)
                .await?;
            anyhow::Ok(())
        })
    }

    pub fn get_last() -> Option<Self> {
        let rt = tokio::runtime::Runtime::new().unwrap();
        rt.block_on(async {
            let pool = crate::db::connection::POOL.read().await;
            let _p = pool.get_pool();
            let s = sqlx::query_as::<sqlx::Sqlite, PracticeStatus>(
                r#"SELECT * FROM practice order by practice_id desc limit 0,1"#,
            )
            .fetch_one(_p)
            .await;

            match s {
                Ok(o) => {
                    return Some(o);
                }
                Err(e) => {
                    println!("{:?}", e);
                    return None;
                }
            }
        })
    }

    pub fn new_log() -> anyhow::Result<i64> {
        let rt = tokio::runtime::Runtime::new().unwrap();
        let _t = SystemTime::now()
            .duration_since(UNIX_EPOCH)
            .unwrap()
            .as_secs();

        rt.block_on(async {
            let pool = crate::db::connection::POOL.read().await;
            let _p = pool.get_pool();
            let _sql =
                sqlx::query(r#"INSERT INTO practice (hit,current,create_at) VALUES (?,?,?)"#)
                    .bind(0)
                    .bind(0)
                    .bind(_t as i64)
                    .execute(_p)
                    .await?;

            anyhow::Ok(_sql.last_insert_rowid())
        })
    }
}
