# yujiorama/docker-pytermextract

[専門用語（キーワード）自動抽出Pythonモジュールtermextract](http://gensen.dl.itc.u-tokyo.ac.jp/pytermextract/) の Docker コンテナです。

## build

```bsah
cat Dockerfile | docker build -t yujiorama/docker-pytermextract .
```

## run

```bash
docker run yujiorama/docker-pytermextract [command] [files] [<file]
```

標準入力で渡したテキストデータを解析する。

```bash
docker run -i yujiorama/docker-pytermextract janome < file

or

cat file | docker run -i yujiorama/docker-pytermextract pp
```

マウントしたボリュームのテキストファイルを解析する。

```bash
docker run -v /path/to/dir:/txt yujiorama/docker-pytermextract janome-lr /txt/file

or

docker run -v /path/to/dir:/txt yujiorama/docker-pytermextract [tfidf|lr] /txt/file1 /txt/file2 /txt/file3
```

### [command]

処理内容は[専門用語（キーワード）自動抽出Pythonモジュールtermextract](http://gensen.dl.itc.u-tokyo.ac.jp/pytermextract/)を参照してください。

* `janome | janome-lr | janome_lr`: `janome（日本語形態素解析器）の和文解析結果をもとに、専門用語を抽出する` を実行します
* `mecab`: `和布蕪（日本語形態素解析器）の和文解析結果をもとに、専門用語を抽出する` を実行します
* `eng`: `英文POS Tagger(Pythonのnltkモジュールのword_tokenize)の英文解析結果をもとに、専門用語を抽出する` を実行します
* `engplain | eng_plain`: `英文を指定のストップワードで分割することで、専門用語を抽出する` を実行します
* `jpn | jpn-plain | jpn_plain | plain`: `和文を「ひらがな」及び「記号」で分割することで、専門用語を抽出する` を実行します
* `tfidf`: `TF・IDFを重要度とした専門用語を抽出する例（janomeの和文解析を使用）` を実行します
    * 複数の入力ファイルを指定する必要があります
* `lr`: `LR(単名詞の左右の連接情報)を蓄積し、それをLFの値として用いる例（janomeの和文解析を使用）` を実行します
    * 複数の入力ファイルを指定する必要があります
* `janomepp | janome_pp | pp`: `パープレキシティによる需要度を用いる例（janomeの和文解析を使用）` を実行します
* `nlpir`:

## LICENSE

[MIT](./LICENSE)
