fn main() -> Result<(), Box<dyn std::error::Error>> {
    tonic_build::configure()
        .build_server(true)
        .compile(
            &["../contracts/proto/ai.proto"],
            &["../contracts/proto"],
        )?;
    Ok(())
}
