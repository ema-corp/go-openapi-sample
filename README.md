# go-openapi-sample
OpenAPI 形式で記述した yml ファイルから、Go サーバを生成する

## 前提作業
以下のコマンドで、 openapi-generator をインストールする。

- brew
```
$ brew install openapi-generator
```

- npm
```
$ npm install openapi-generator-cli
```

## 動かし方
以下のように `make gen` コマンドを実行すると、リポジトリトップの src 配下に、 API サーバを動作させるための Go プロジェクトが生成される。
（*実行毎にプロジェクトが再生成されるので、不用意に `make gen` を実行してしまわないように注意すること。）

```
$ cd build/openapi
$ make gen
```

Go サーバは、以下のコマンドで起動する。

```
$ go run main.go
```

## エラーが出る場合の対処（2/12（金）時点）
エラーが発生する可能性があるので、その場合は以下の対処をする。

- src/go/routers.go -> `import` に `"mime/multipart"` を追加する。

- src/go/api_default.go -> `import` の `"encoding/json"` の部分を `_ "encoding/json"` に変える。