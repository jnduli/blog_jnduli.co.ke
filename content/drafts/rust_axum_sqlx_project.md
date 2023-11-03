Plan

1. Create a simple api project that'll provide a couple of endpoints
2. Ensure it uses actix and sqlx and provides context on what to do
3. Explore idea of having a projects folder for all the projects I'm working on
4. Clean up the project and see how it'll pan out
5. Perhaps add docker-compose for the project???

Project set up:

```
cargo new rust_actix_sqlx
cargo add axum
cargo add sqlx --features runtime-tokio-rustls,sqlite
cargo add serde --features derive
```

Here's my `Cargo.toml` after the above:

```
[package]
name = "rust_actix_sqlx"
version = "0.1.0"
edition = "2021"

# See more keys and their definitions at https://doc.rust-lang.org/cargo/reference/manifest.html

[dependencies]
actix-cors = "0.6.4"
actix-web = "4.4.0"
serde = { version = "1.0.188", features = ["derive"] }
sqlx = { version = "0.7.1", features = ["runtime-tokio-rustls", "sqlite"] }
```

TODO: test the waters, write a simple web page that uses a db and api call, then
I'll refactor things out
