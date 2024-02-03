use std::{
    sync::RwLock,
    time::{Duration, SystemTime, UNIX_EPOCH},
};

use flutter_rust_bridge::StreamSink;
use sysinfo::{ProcessExt, System, SystemExt};

#[deprecated = "perf"]
#[allow(dead_code)]
fn get_memory(process_name: Option<String>) -> u64 {
    let name: String;
    match process_name {
        Some(n) => {
            name = n;
        }
        None => {
            name = String::from("flutter_windows_desktop");
        }
    }

    let sys = System::new_all();
    for (_pid, process) in sysinfo::SystemExt::processes(&sys) {
        if process.name().contains(&name) {
            return process.memory();
        }
    }
    return 0;
}

#[deprecated = "perf"]
#[allow(dead_code)]
fn get_cpu(process_name: Option<String>) -> f32 {
    let name: String;
    match process_name {
        Some(n) => {
            name = n;
        }
        None => {
            name = String::from("flutter_windows_desktop");
        }
    }

    let sys = System::new_all();
    for (_pid, process) in sysinfo::SystemExt::processes(&sys) {
        if process.name().contains(&name) {
            return process.cpu_usage();
        }
    }
    return 0.0;
}

pub struct NativeSysInfo {
    pub cpu: f32,
    pub memory: u64,
    pub t: u64,
}

#[allow(dead_code)]
impl NativeSysInfo {
    pub fn default() -> Self {
        let _t = SystemTime::now()
            .duration_since(UNIX_EPOCH)
            .unwrap()
            .as_secs();
        NativeSysInfo {
            cpu: 0.0,
            memory: 0,
            t: _t,
        }
    }
}

pub static SEND_TO_DART_NATIVESYSINFO_SINK: RwLock<Option<StreamSink<NativeSysInfo>>> =
    RwLock::new(None);

fn send_sys_info(info: NativeSysInfo) {
    match SEND_TO_DART_NATIVESYSINFO_SINK.try_read() {
        Ok(s) => match s.as_ref() {
            Some(s0) => {
                s0.add(info);
            }
            None => {
                println!("[rust-error] Stream is None");
            }
        },
        Err(_) => {
            println!("[rust-error] Stream read error");
        }
    }
}

pub fn start_listen(process_name: Option<String>) {
    let name: String;
    match process_name {
        Some(n) => {
            name = n;
        }
        None => {
            name = String::from("flutter_windows_desktop");
        }
    }
    let mut cpu: f32 = 0.0;
    let mut memory: u64 = 0;
    let mut _t: u64;

    loop {
        _t = SystemTime::now()
            .duration_since(UNIX_EPOCH)
            .unwrap()
            .as_secs();
        let sys = System::new_all();
        for (_pid, process) in sysinfo::SystemExt::processes(&sys) {
            if process.name().contains(&name) {
                cpu = process.cpu_usage();
                memory = process.memory();
            }
        }
        // let memory = get_memory(process_name.clone());
        // let cpu = get_cpu(process_name.clone());
        send_sys_info(NativeSysInfo { cpu, memory, t: _t });
        std::thread::sleep(Duration::from_secs(2));
    }
}
