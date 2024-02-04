use std::path::Path;

use lazy_static::lazy_static;

pub fn path_exists(p: String) -> bool {
    Path::new(&p).exists()
}

lazy_static! {
    pub static ref CHANGELOG: &'static [u8] = {
        if path_exists(r"D:\github_repo\flutter_windows_desktop\README.md".to_string()) {
            return include_bytes!(r"D:\github_repo\flutter_desktop\README.md");
        }
        return b"Error Path\n";
    };
}
