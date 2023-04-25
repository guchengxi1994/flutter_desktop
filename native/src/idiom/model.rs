use lazy_static::lazy_static;
use rand::seq::SliceRandom;
use rand::thread_rng;
use std::sync::Mutex;

#[derive(Debug, serde::Deserialize, Clone)]
pub struct Idiom {
    pub idiom: String,
    pub pinyin: String,
    pub pinyin_tone: String,
    pub meaning: String,
}

lazy_static! {
    pub static ref IDIOM_PATH: Mutex<String> = Mutex::new(String::new());
    static ref IDIOMS: Vec<Idiom> = {
        let r = Idiom::from_reader(IDIOM_PATH.lock().unwrap().to_string());
        match r {
            Ok(ro) => {
                return ro;
            }
            Err(e) => {
                println!("[rust-idiom-loading-error] : {:?}", e);
                return Vec::new();
            }
        }
    };
}

impl Idiom {
    pub fn from_reader(s: String) -> anyhow::Result<Vec<Idiom>> {
        let mut f = std::fs::File::open(s)?;
        let mut reader: Vec<u8> = Vec::new();
        std::io::Read::read_to_end(&mut f, &mut reader)?;
        let (cow, _, had_errors) = encoding_rs::GB18030.decode(&reader);
        let mut idioms: Vec<Idiom> = Vec::new();
        if had_errors {
            return anyhow::Ok(idioms);
        }

        let mut rdr = csv::Reader::from_reader(cow.as_bytes());
        for result in rdr.deserialize() {
            let mut idiom: Idiom = result?;
            idiom.idiom = idiom.idiom.trim().to_owned();
            idioms.push(idiom);
        }
        anyhow::Ok(idioms)
    }

    pub fn sample(i: Option<u64>) -> Vec<Idiom> {
        let count: u64;
        match i {
            Some(io) => {
                if io > 100 {
                    count = 100;
                } else {
                    count = io;
                }
            }
            None => {
                count = 100;
            }
        }

        if IDIOMS.len() < count.try_into().unwrap() {
            return Vec::new();
        } else {
            let mut v = IDIOMS.clone();
            v.shuffle(&mut thread_rng());
            return v[0..count.try_into().unwrap()].to_vec();
        }
    }
}
