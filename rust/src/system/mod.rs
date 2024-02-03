use lazy_static::lazy_static;

lazy_static! {
    pub static ref CHANGELOG: &'static [u8] = {
        if crate::db::init::path_exists(
            r"D:\github_repo\flutter_windows_desktop\README.md".to_string(),
        ) {
            return include_bytes!(r"D:\github_repo\flutter_windows_desktop\README.md");
        }
        return b"Error Path\n";
    };
}
