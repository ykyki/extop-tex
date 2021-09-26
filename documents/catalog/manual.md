# ExTop マニュアル

## 全般

- "Counter Examples in Topology" のことを "CEiT" と略する.

---

## 構成

```
extop-tex/
├── README.md
├── build-document.sh // productsフォルダへのビルドを行うシェルコマンド
├── documents
│   ├── bibliography // 参考文献をまとめる
│   │   ├── miscellaneous.bib
│   │   ├── papers-ja.bib
│   │   └── papers.bib
│   ├── config // 設定をまとめる
│   │   ├── colors.sty
│   │   ├── environments.sty
│   │   ├── global-commands.sty
│   │   └── layouts
│   │       ├── develop.sty
│   │       ├── product.sty
│   │       └── review.sty
│   ├── catalog
│   │   ├── chapter-basics.tex
│   │   ├── chapter-compactness.tex
│   │   ├── chapter-connectedness.tex
│   │   ├── chapter-constructions.tex
│   │   ├── chapter-examples.tex
│   │   ├── chapter-separation-axioms.tex
│   │   ├── common-preamble.sty
│   │   ├── examples
│   │   │   ├── 000-empty-template-for-example.tex // テンプレート
│   │   │   ├── Alexandroff-square.tex
│   │   │   ├── Moore-plane.tex
│   │   │   ├── Q-star-infinite.tex
│   │   │   ├── Q-star.tex
│   │   │   ├── ...
│   │   │
│   │   ├── list-commands-table.tex // catalogドキュメントで使用されるグローバルコマンドの説明をまとめる
│   │   ├── list-commands.tex // mainドキュメントの索引に記号一覧をまとめる
│   │   ├── main-root.tex
│   │   ├── manual.md
│   │   ├── preliminary.tex
│   │   └── theories
│   │       ├── 000-empty-template.tex // テンプレート
│   │       ├── Hausdorff-like-properties.tex
│   │       ├── Hausdorff-spaces.tex
│   │       ├── Lindelof-spaces.tex
│   │       ├── T0-spaces.tex
│   │       ├── T1-spaces.tex
│   │       ├── ...
│   │  
│   └── scrap // catalogドキュメントとは別にちょっとした内容をメモしておくための場所
│       ├── 001-Continuity-from-n-delta.tex
│       ├── 002-Format-test.tex
│       └── A01-scrap-preamble.sty
└── products
    └── // 生成物を収める
```

---

## 文章規約

ドキュメント, 特に .tex ファイルを執筆する際のルールについてまとめる.

### 地の文

- 「で・ある」調を用いる.
- 句読点は「、」「。」ではなく「,」「.」を用いる. また, 句読点の後には半角スペースを入れる.
- 読点として感嘆符や疑問符は使用しない. 体言止めも避ける.
- 送り仮名について:
  - 表す (あらわす)
  - 組み合わせ (くみあわせ)
- 平仮名を用いる語:
  - 接続詞: したがって, すなわち
  - ある, ない
- 以下の汎用的な動詞については, 物理的動作を伴うか否かにより漢字と平仮名を使い分ける.
  - 言う, 見る, 行く, 持つ, 取る, 入る, 入れる
  - 例: 「それには反例があると彼に言う」「dogbone space という空間」
  - 例: 「ペンを持つ」「そういう性質をもつ」
  - 例: 「この道に沿って点Bまで行くと」「それが成立することをみていく」
- 漢字を用いる語:
  - 分かる
  - 従う
  - 書く
  - 成り立つ
- TODO: ~~英単語や括弧, コマンドなどの半角の文字を日本語の文章内に入れる際には, その前後に半角スペースを入れる. 文中の数式の前後には空白を入れる必要はない.~~
  - ~~例: `この位相空間$ X $は定理 \ref{thm:hoge} より Hausdorff である.`~~

### ラベル・索引

- ラベル参照をするときには `\cref{}` を用いる
  - 定理: `\cref{thm:hoge}`
  - 命題: `\cref{prop:hoge}`
  - 系: `\cref{cor:hoge}`
  - 性質: `\cref{prop:hoge}`
  - 章: `\cref{chap:hoge}`
  - 節: `\cref{sec:hoge}`
  - 例: `\cref{ex:hoge}`
- TODO: ラベルの命名方法は調整中. ひとまず snake-case かつ空白を入れないこと.

### 参考文献

- TODO

### 数式

- TODO

### ビルド

- TODO

---

## Git 運用

- 新しく feature ブランチを切るときは `feature/006-add-some-test` のように命名する.

---

## ファイル整理

- ファイルは基本的に snake case で命名する