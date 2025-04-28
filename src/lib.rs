use anyhow::Result;
use spin_sdk::http::{Request, Response};
use spin_sdk::http_component;

#[http_component]
fn handle_hello(_req: Request) -> Result<Response> {
    Ok(http::Response::builder()
        .status(200)
        .body(Some("👋 Hello from Cargo + Spin SDK!".into()))?)
}
