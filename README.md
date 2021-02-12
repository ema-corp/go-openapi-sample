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
リポジトリトップで以下のコマンドを実行すると、 src 配下に、 API サーバを動作させるための Go プロジェクトが生成される。

```
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