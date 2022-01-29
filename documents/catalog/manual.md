# ExTopTeX (仮称) 開発進行マニュアル

## ExTopTeX (仮称) とは

- 位相空間具体例愛好会 (仮称) が開発＆執筆を進めているプロジェクト

### 目標

- 位相空間に関する知識をまとめたドキュメントを制作する
- ひとつの PDF ファイルをメイン成果物とする
- ドキュメントを随時更新できるようにしておく

### 経緯

- 位相空間具体例愛好会 (仮称) でセミナーをしていたときに, 定理や具体例を参照することが多く, 文献へのアクセス時間が障害となっていた
- そこで知識の収集＆整理のために、ドキュメント開発が始まった

## 用語

- ExTopTeX (仮称): このプロジェクトの名前 (仮)
- CEiT: "Counter Examples in Topology" の略称

## 構成

```
./README.md
リポジトリの説明

./documents
ドキュメントを構成する tex ファイルを収める

./documents/bibliography
./documents/bibliography/miscellaneous.bib
./documents/bibliography/papers-ja.bib
./documents/bibliography/papers.bib
参考文献の情報をまとめる

./documents/catalog
メインのドキュメント. 名前を暫定的に catalog とする

./documents/catalog/root.tex
catalog のルートファイル. これをビルドすることでドキュメント全体 PDF ファイルを生成する

./documents/catalog/prefaces.tex
まえがき

./documents/catalog/chapter-basics.tex
./documents/catalog/chapter-compactness.tex
./documents/catalog/chapter-connectedness.tex
./documents/catalog/chapter-constructions.tex
./documents/catalog/chapter-preliminaries.tex
./documents/catalog/chapter-separation-axioms.tex
./documents/catalog/chapter-examples.tex
./documents/catalog/chapter-countability.tex
セクションをまとめてチャプターを構成する

./documents/catalog/examples
具体例セクションを収める

./documents/catalog/theories
理論セクションを収める

./documents/catalog/list-commands-table.tex
./documents/catalog/list-commands.tex
グローバルコマンドの定義や一覧

./documents/config
設定ファイルを収める

./documents/scrap
catalog とは別に, 細々とした文書を記録しておく

./products
成果物を収める

./temp
一時的なファイルを出力するためのディレクトリ. ビルドツールで生成されたファイルはここに収められる

./tools
./tools/build-by-path.sh
./tools/build-latexdiff.sh
./tools/extopy
ビルドツール
```

## 文章規約

ドキュメント, 特に `.tex` ファイルを執筆する際のルールについてまとめる.

### フォーマット

- インデントにはタブを使う. スペースを使わない.
- ファイル内の 1 行を短く収める. そのため句読点の直後で適宜改行する

### 地の文

- 1 文をなるべく短くする.
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
  - 例: 「この道に沿って点 B まで行くと」「それが成立することをみていく」
- 漢字を用いる語:
  - 分かる
  - 従う
  - 書く
  - 成り立つ
- TODO: ~~英単語や括弧, コマンドなどの半角の文字を日本語の文章内に入れる際には, その前後に半角スペースを入れる. 文中の数式の前後には空白を入れる必要はない.~~
  - ~~例: `この位相空間$ X $は定理 \ref{thm:hoge} より Hausdorff である.`~~

### ラベル・索引

- ラベル参照をするときには `\cref{}` を用いる.
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

### その他 (未整理メモ)

- `\WIP`の書き方. // TODO
- `\indexjj`の書き方. // TODO
- 定義文の書き方: 「〇〇であるとは, □□ ことをいう.」ではなく「〇〇であるとは, □□ ことである.」. 言い回しの自然さを損なわない範囲で前者の方に合わせる.
- 「第 1 可算」ではなく「第一可算」.
- 「第 2 可算」ではなく「第二可算」.
- 未定義の用語は使わない. 使う場合には定義を書くか, あるいは後続タスクを作成する.

## ビルド手順

- TODO

## Git 運用

- 新しく feature ブランチを切るときは `feature/006-add-some-test` のように命名する.

## ファイル整理

- ファイルは基本的に snake case で命名する
