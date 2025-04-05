# 技術同人誌テンプレート

このリポジトリは技術同人誌を執筆するための汎用的なテンプレートです。Markdownで原稿を書き、PDFに変換して結合するシンプルなワークフローを提供します。

## フォルダ構成

```
/
├── src/              # 原稿ソースファイル
│   ├── chapters/     # 章ごとのMarkdownファイル
│   └── images/       # 画像ファイル
├── dist/             # ビルド成果物（PDF等）
├── tmp/              # 一時ファイル
├── README.md         # プロジェクト説明
└── build.sh          # ビルドスクリプト
```

## 前提条件

以下のツールがインストールされている必要があります：

- Node.js
- npm または yarn
- qpdf
- md-to-pdf (npmパッケージ)

## セットアップ

1. このリポジトリをクローンまたはテンプレートとして使用して新しいプロジェクトを作成します
2. 必要なツールをインストールします：

```bash
# md-to-pdfのインストール
npm install -g md-to-pdf

# macOSの場合、qpdfのインストール
brew install qpdf

# Ubuntuの場合、qpdfのインストール
# sudo apt-get install qpdf
```

## 使用方法

1. `src/chapters/` に章ごとのMarkdownファイルを作成します
   - ファイル名は `01_introduction.md`, `02_chapter1.md` のように、ソートされた時の順序が章の順序になるようにします
   - 各Markdownファイルは独立した章として扱われます

2. `src/images/` に必要な画像を配置し、Markdownから相対パスで参照します
   - 例：`![説明](../images/figure1.png)`

3. ビルドスクリプトを実行してPDFを生成します：

```bash
# 実行権限の付与
chmod +x build.sh

# ビルドの実行
./build.sh

# バージョン番号を指定してビルド
VERSION=1.1 ./build.sh
```

4. 生成されたPDFは `dist/` フォルダに出力されます

## 表紙画像について

テンプレートにはサンプルの表紙画像（`./src/images/hyoshi.png`）があらかじめ配置されています。この画像はA4サイズ（595x842ポイント）の画像です。

実際に作業する際は、このサンプル画像を適切な表紙画像に置き換えてください。表紙画像はPNG形式で、同じファイルパス（`./src/images/hyoshi.png`）に配置する必要があります。

表紙画像が配置されていない場合、ビルドスクリプトは表紙のPDF変換をスキップします.

## カスタマイズ

- `build.sh` の `BOOK_TITLE` 変数を変更して、出力するPDFファイル名を変更できます
- md-to-pdfの詳細なオプションは[公式ドキュメント](https://github.com/simonhaenisch/md-to-pdf)を参照してください

## ライセンス

MITライセンス
