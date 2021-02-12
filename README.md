# go-openapi-sample
`main` ブランチのやつをすぐ動かせる状態にしたやつ。

## 前提作業
`main` ブランチ参照

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

## 確認
サーバを起動させたあと、以下のコマンドで実装済みのエンドポイントにアクセスでき、 stub として定義した関数から得られた結果が返却される

```
$ curl http://localhost:8080/pets/1
```

## stub 
### 場所
- src/go/api_stub_service.go

### 簡単な解説っぽいもの
- ルーティング的なもの
```
[src/main.go]

DefaultMockService := openapi.NewDefaultMockService()
DefaultApiController := openapi.NewDefaultApiController(DefaultMockService) ★ コントローラ初期化

router := openapi.NewRouter(DefaultApiController) ★ router にコントローラ登録
```

```
[src/go/api_default.go]

// Routes returns all of the api route for the DefaultApiController
func (c *DefaultApiController) Routes() Routes {
	return Routes{ 
		{
			"PetsIdGet",
			strings.ToUpper("Get"),
			"/pets/{id}",
			c.PetsIdGet,
		},
	}
}
```

- ハンドラ的なもの（コントローラと言うっぽい）
```
[src/go/api_default.go]

// PetsIdGet - 
func (c *DefaultApiController) PetsIdGet(w http.ResponseWriter, r *http.Request) { 
	params := mux.Vars(r)
	id, err := parseInt64Parameter(params["id"])
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		return
	}
	result, err := c.service.PetsIdGet(r.Context(), id) ★ ここで DB 的な存在のバックエンドサービスを利用している
	//If an error occured, encode the error with the status code
	if err != nil {
		EncodeJSONResponse(err.Error(), &result.Code, w)
		return
	}
	//If no error, encode the body and the result code
	EncodeJSONResponse(result.Body, &result.Code, w)
	
}
```