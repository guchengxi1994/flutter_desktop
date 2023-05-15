#[test]
fn include_test() {
    let f = include_bytes!(
        r"D:\github_repo\flutter_windows_desktop\build\windows\runner\Debug\cache\txts\11111"
    );
    println!("{:?}", f.len())
}
