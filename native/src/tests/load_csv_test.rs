#[test]
fn load_csv_test() -> anyhow::Result<()> {
    let p = r"D:\github_repo\flutter_windows_desktop\build\windows\runner\Debug\data\flutter_assets\assets\idiom\practice.csv";

    let mut f = std::fs::File::open(p)?;
    let mut reader: Vec<u8> = Vec::new();
    std::io::Read::read_to_end(&mut f, &mut reader)?;
    // let _ = encoding::Encoding::decode_to(
    //     encoding::all::GB18030,
    //     &mut reader,
    //     encoding::DecoderTrap::Ignore,
    //     &mut chars,
    // );
    let (cow, _, had_errors) = encoding_rs::GB18030.decode(&reader);
    if had_errors {
        return anyhow::Ok(());
    }

    let mut rdr = csv::Reader::from_reader(cow.as_bytes());
    for result in rdr.deserialize() {
        // println!("{:?}", result);
        match result {
            Ok(r) => {
                let idiom: crate::idiom::model::Idiom = r;
                // idioms.push(idiom);
                println!("{:?}", idiom);
            }
            Err(_) => {
                // println!("{:?}", e);
            }
        }
    }

    anyhow::Ok(())
}

#[test]
fn csv_test() -> anyhow::Result<()> {
    let csv = "year,make,model,description
        1948,张三,356,Luxury sports car
        1967,王五,Mustang fastback 1967,American car";

    let mut reader = csv::Reader::from_reader(csv.as_bytes());
    for record in reader.records() {
        let record = record?;
        println!(
            "In {}, {} built the {} model. It is a {}.",
            &record[0], &record[1], &record[2], &record[3]
        );
    }

    Ok(())
}

#[test]
fn load_csv_test_2() -> anyhow::Result<()> {
    let mut rdr = csv::Reader::from_path(
        r"D:\github_repo\flutter_windows_desktop\build\windows\runner\Debug\data\flutter_assets\assets\idiom\practice2.csv",
    )?;
    for result in rdr.records() {
        // println!("{:?}", result);
        match result {
            Ok(r) => {
                // idioms.push(idiom);
                println!("{:?}", r);
            }
            Err(_) => {
                // println!("{:?}", e);
            }
        }
    }

    anyhow::Ok(())
}
