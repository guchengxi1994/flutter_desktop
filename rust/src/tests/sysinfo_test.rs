
#[test]
fn get_sysinfo() {
    let s = <sysinfo::System as sysinfo::SystemExt>::new();
    if let Some(process) = sysinfo::SystemExt::process(&s, sysinfo::Pid::from(5280)) {
        println!("{} bytes", sysinfo::ProcessExt::memory(process));
    } else {
        println!("None pid");
    }
}

#[test]
fn get_sysinfo_2() {
    let sys = <sysinfo::System as sysinfo::SystemExt>::new_all();
    for (pid, process) in sysinfo::SystemExt::processes(&sys) {
        println!(
            "[{}] {} {:?} {:?}",
            pid,
            sysinfo::ProcessExt::name(process),
            sysinfo::ProcessExt::disk_usage(process),
            sysinfo::ProcessExt::memory(process)
        );
    }
}
