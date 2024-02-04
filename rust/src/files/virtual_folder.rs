use super::vitrual_file::VirtualFile;

#[derive(Clone, Debug)]
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
    pub async fn from_folder() -> Option<VirtualFolder> {
        None
    }

    #[tokio::main]
    pub async fn new_folder(_name: String, _parent_id: Option<i64>) -> i64 {
        0
    }

    pub fn get_children(_parent_id: Option<i64>) -> Vec<FileOrFolder> {
        let rt = tokio::runtime::Runtime::new().unwrap();
        rt.block_on(async { vec![] })
    }
}
