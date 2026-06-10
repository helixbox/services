# cow-contracts

Alloy-based Rust contract bindings for the CoW Protocol ecosystem.

Each smart contract gets its own crate for parallel compilation. The `contracts` facade crate re-exports everything under a single API.

## Usage

Add to your `Cargo.toml`:

```toml
contracts = { git = "https://github.com/cowprotocol/cow-contracts" }
```

Then use:

```rust
use contracts::{GPv2Settlement, ERC20, WETH9};
```

## Adding a new contract

1. Add the ABI artifact JSON to `artifacts/` (manually or via `cargo run -p contracts-generate -- vendor`)
2. Add the contract definition to `contracts/src/main.rs`
3. Run `cargo run -p contracts-generate`
4. Run `cargo check -p contracts` to verify
5. Commit and open a PR

## Commands

From the repository root, use `just`:

```bash
just setup                # Vendor artifacts, generate bindings, and format everything
just generate-contracts   # Generate bindings from artifacts only
```

Or use the `contracts-generate` binary directly:

```bash
cargo run -p contracts-generate              # Generate bindings from artifacts
cargo run -p contracts-generate -- vendor    # Download/update ABI artifacts
cargo run -p contracts-generate -- all       # Vendor artifacts then generate bindings
```

The `generate` command regenerates all per-contract crates in `generated/` and updates the facade module at `generated/contracts-facade/src/lib.rs`.

## Compiling Solidity contracts

Custom support/test contracts live in `solidity/`. To recompile:

```bash
cd solidity && make artifacts
```

Requires Docker with the `ethereum/solc:0.8.30` image.

## License

Licensed under either of [Apache License, Version 2.0](LICENSE-APACHE) or [MIT license](LICENSE-MIT) at your option.
