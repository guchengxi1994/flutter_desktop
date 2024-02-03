use lazy_static::lazy_static;
use sqlx::{Pool, Sqlite, SqlitePool};
use std::sync::Arc;
use tokio::sync::RwLock;
pub struct MyPool(Option<Pool<Sqlite>>);

impl MyPool {
    /// 创建连接池
    pub async fn new(uri: &str) -> Self {
        let pool = SqlitePool::connect(uri).await.unwrap();
        MyPool(Some(pool))
    }

    /// 获取连接池
    pub fn get_pool(&self) -> &Pool<Sqlite> {
        self.0.as_ref().unwrap()
    }
}

/// 实现 Default trait
impl Default for MyPool {
    fn default() -> Self {
        MyPool(None)
    }
}

// 声明创建静态连接池
lazy_static! {
    pub static ref POOL: Arc<RwLock<MyPool>> = Arc::new(RwLock::new(Default::default()));
}
