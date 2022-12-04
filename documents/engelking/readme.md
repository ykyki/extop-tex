# Engelking 演習問題セミナー

## 目的
- Engelkingの演習問題を解く.

## ブランチの命名方法
- feature/engelking/{日付}/add-1-1-A
- feature/engelking/{日付}/prove1-1-A
- ex: feature/engelking/220803/add-1-1-A

## ファイルの命名方法
- {問題番号}-problem.tex, {問題番号}-proof.tex
- ex: 1-1-A-problem.tex
- 証明が複数ある場合は, 2つ目以降について{問題番号}-proof{番号}.texのように書く.
- ex: 2つ目の証明の場合は 1-1-A-proof2.tex のように書く

## 1つのブランチに含む内容
- 問題文の記述に関しては複数を1つのブランチ内でまとめて記述しても良い.
- 証明の記述は1つのブランチにつき原則1つとする.

## Projectsの利用方法
- extop-engelking-manegement, extop-engelking の2つがある.
- Engelking 演習問題セミナーのタスク全般は extop-engelking-manegement で管理する.
- extop-engelking は各問題の進捗状況一覧としてのみ使用.

## 使用する用語の定義
- catalogの定義に合わせる.
- 問題の主張は変えずにcatalogの定義に基づいて記述する.
- ex: 原文が"Every compact space is a T4-space."となっている場合, "コンパクトT2空間はT4空間である."とする.

## catalogのファイルからの引用方法
- Engelkingの問題を証明する際にcatalog内の命題を引用したい場合がある.
- catalog/hoge.tex 内の命題(\label{a00001})を引用する場合は"命題 catalog-a00001 より"のように書く.
- 当面はこの方法で対処するが最終的には解決の方法を考える.
