use std::time::{SystemTime, UNIX_EPOCH};

#[derive(Clone, Debug, sqlx::FromRow)]
pub struct Operation {
    pub operation_id: i64,
    pub operation_content: String,
    pub operation_result: String,
    pub create_at: i64,
}

impl Operation {
    pub fn new(content: String, result: Option<String>) -> anyhow::Result<()> {
        let rt = tokio::runtime::Runtime::new().unwrap();
        rt.block_on(async {
            let _t = SystemTime::now()
                .duration_since(UNIX_EPOCH)
                .unwrap()
                .as_secs();
            let pool = crate::db::connection::POOL.read().await;
            let _p = pool.get_pool();
            let _result = match result {
                Some(r) => r,
                None => String::new(),
            };

            let _sql = sqlx::query(
                r#"INSERT INTO operations (operation_content,operation_result,create_at) VALUES (?,?,?)"#,
            )
            .bind(content.clone())
            .bind(_result)
            .bind(_t as i64)
            .execute(_p)
            .await?;
            anyhow::Ok(())
        })
    }
}
