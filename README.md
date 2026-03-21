# post-2603

「単眼カメラを用いたVR向け仮想トラッカーの制作」というポスターの Typst 原稿です。

## Files

- `main.typ`: ポスター本体
- `assets/`: 画像アセット
- `main.pdf`: ビルド成果物

## Build

```bash
nix run .#build
```

`main.pdf` がリポジトリ直下に生成されます。

監視しながら編集する場合:

```bash
nix run .#watch
```

開発シェル:

```bash
nix develop
```

CI 相当の確認:

```bash
nix flake check
```
