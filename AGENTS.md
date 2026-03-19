# Repository Guidelines

## Project Structure & Module Organization
This repository builds a single Typst poster from `main.typ`. Keep poster content, layout helpers, and imports there unless a clear split becomes necessary. Store images in `assets/`; use descriptive filenames and keep source graphics committed. `flake.nix` defines the development shell, build apps, and formatting checks. `index.html` is the GitHub Pages redirect page, and `.github/workflows/deploy-pages.yml` publishes `main.pdf`.

## Build, Test, and Development Commands
Use Nix for all local workflows:

- `nix develop` enters the shell with Typst, fonts, `lefthook`, and formatters.
- `nix run .#watch` rebuilds the poster on file changes during editing.
- `nix run .#build` generates `main.pdf` in the repository root.
- `nix flake check` runs the build and formatting checks used by CI.
- `nix fmt` formats Nix files with Alejandra; Typst formatting is provided through `treefmt`.

## Coding Style & Naming Conventions
Prefer small reusable Typst helpers for repeated layout patterns. Match the existing style in `main.typ`: two-space indentation, concise helper definitions near the top, and readable section blocks below. Keep visual constants centralized (`border`, `light`, text settings) instead of scattering literal values. When adding assets, favor lowercase names and preserve an existing series if files already follow a pattern such as `inference_center_n500_overlay_elapsed_avg.png`.

## Testing Guidelines
There is no separate unit test suite in this repository. Validation is build-focused: run `nix flake check` before opening a PR, and confirm the generated `main.pdf` renders correctly. For visual changes, inspect spacing, overflow, image scaling, and QR output in the built PDF, not only in source diff.

## Commit & Pull Request Guidelines
Recent history uses short imperative subjects such as `Update layout`, `Add inference elapsed graph`, and occasional scoped prefixes like `fix: keep original poster design`. Follow that pattern: one-line, present-tense summaries focused on the visible change. Pull requests should include a brief description, note any asset replacements, link related issues when applicable, and attach screenshots or the updated PDF when layout or visual content changes.
