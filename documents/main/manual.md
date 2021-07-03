# 全般

- "Counter Examples in Topology" のことを "CEiT" と略する.

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
- ~~英単語や括弧, コマンドなどの半角の文字を日本語の文章内に入れる際には, その前後に半角スペースを入れる. 文中の数式の前後には空白を入れる必要はない.~~
  - ~~例: `この位相空間$ X $は定理 \ref{thm:hoge} より Hausdorff である.`~~

### ラベル・索引

- ~~`\label{}` を使うときは, `\label{prop:Cpt+T2>T4}` や `\label{prop:Contiuous maps preserve connectedness}` のように略記あるいは英文で記入する.~~
  - `\label{}` を置く場所は, `\section{}` や `\begin{}` の直後にする.
    - 定理: `\ref{thm:hoge}`
    - 命題: `\ref{prop:hoge}`
    - 系: `\ref{cor:hoge}`
    - 性質: `\ref{property:hoge}`
    - 章: `\ref{chapter:hoge}`
    - 節: `\ref{section:hoge}`
    - 例: `\ref{ex:hoge}`
  - 細かな形式は後で調整するので現段階(20/01/23)では適当に
- ~~略記を使うときは, example list を書くときに使った記法を基準にする.~~
  - ~~性質を導く関係を書くときは `\label{prop:hogeA + hogeB > hogeC}` のように書く.~~
  - ~~hogeA と hogeB が同値: `\label{prop:hogeA <> hogeB}`~~
- `\ref{}` を使うときは, `定理 \ref{thm:hoge}` や `命題 \ref{prop:hoge}`, `第 \ref{section:hoge} 節` のように書く.

### 参考文献

- bibtex を用いる.
- citation key の定義の方法など [WIP].

### 数式

- 部分集合族を表す記号は一般的には `\mathscr{}` を用いる. ただし, 開集合続・開基・近傍族・近傍系などの基本的な概念についてはコマンドを用意しており, そちらを使う.

### プリアンプルの説明

- `\loclabel{}`, `\locref{}`
  - 1つのセクション内でのローカルなラベルとリファレンスを可能にする. 原理が単純なので定義を見れば使用方がわかると思われる.

### ビルド

最終的にどのビルド方法を用いるのかは未決定であるが, ひとまず私が使っている方法を共有しておく. Latexmk を用いている.

```json
    {
        "name": "latexmk",
        "command": "latexmk",
        "args": [
            "-e",
            "$latex=q/uplatex %O -kanji=utf8 -no-guess-input-enc -synctex=1 -interaction=nonstopmode -file-line-error %S/",
            "-e",
            "$bibtex=q/upbibtex %O %B/",
            "-e",
            "$biber=q/biber %O --bblencoding=utf8 -u -U --output_safechars %B/",
            "-e",
            "$makeindex=q/upmendex %O -o %D %S/",
            "-e",
            "$dvipdf=q/dvipdfmx -g 1.5pt %O -o %D %S/",
            "-norc",
            "-gg",
            "-pdfdvi",
            "%DOCFILE%"
        ]
    },
    {
        "name": "lite latexmk",
        "command": "latexmk",
        "args": [
            "-e",
            "$latex=q/uplatex %O -kanji=utf8 -no-guess-input-enc -synctex=1 -interaction=nonstopmode -file-line-error %S/",
            "-e",
            "$dvipdf=q/dvipdfmx -g 1.5pt %O -o %D %S/",
            "-norc",
            "-gg",
            "-pdfdvi",
            "%DOCFILE%"
        ]
    },
```

---

## Git 運用

- 新しく feature ブランチを切るときは, 「006-Brunching_Test」のように命名する.
  - (数字)-(Description_of_the_Branch)

### プルリクエストする前にチェックすべき項目集

- サブファイルのプリアンブルには何も記入しない
  - main をビルドするときに, 競合する恐れがあるため

---

## ファイル整理

### ファイルの命名規則

- 具体例ファイルは snake_case で命名する
- ファイル名とその具体例のラベル (\label{}) は同じにする
  - ただし, 複数の具体例を含むファイルについてはその限りではない
