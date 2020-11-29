# 課題７
コンパイラの授業の課題７の内容です。

## Makefileの変更点
Makefileはオブジェクトファイルとヘッダファイルを扱いやすくするために少し編集しています。

## 使用の変更点
+ コメントの有効化
+ コンパイルエラー時にエラーが起こった行の表示（syntax errorは除く）
+ yaccファイルをステップ１に対応ができるように編集
+ ファイルでの入力の受付
`cmm $(file_name)`で実行ができます。

## test_filesについて
test_filesにテストケースを入れています。`make test`ですべてのテストケース（授業資料のステップに表記されているコード）を検証できます。

**`make test` はtest.shを実行するようにできており、pl0iのPATHを通す必要があります。**

## 参考文献
http://slis.tsukuba.ac.jp/~nakai.hisashi.gt/2005/ip2/ulisonly/no4.pdf
