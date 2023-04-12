use lib_flutter_rust_bridge_codegen::*;

const RUST_INPUT: &str = "src/api.rs";
const DART_OUTPUT: &str = "../lib/src/native/bridge_generated.dart";

fn main() {
    // Only rerun when the API file changes.
    println!("cargo:rerun-if-changed={}", RUST_INPUT);
    let configs = config_parse(RawOpts {
        rust_input: vec![RUST_INPUT.to_string()],
        dart_output: vec![DART_OUTPUT.to_string()],
        wasm: true,
        dart_decl_output: Some("../lib/src/native/bridge_definitions.dart".into()),
        c_output: Some(vec![
            // "../ios/Runner/bridge_generated.native.h".into(),
            // "../macos/Runner/bridge_generated.native.h".into(),
            "../windows/Runner/bridge_generated.native.h".into(),
        ]),
        ..Default::default()
    });
    if let Ok(symbols) = get_symbols_if_no_duplicates(&configs) {
        for config in &configs {
            frb_codegen(config, &symbols).unwrap();
        }
    }
}