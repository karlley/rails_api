# rails api

RailsのAPIモードを学ぶ為に下記ページを参照してアプリ作成した。

[Railsで超簡単API \- Qiita](https://qiita.com/k-penguin-sato/items/adba7a1a1ecc3582a9c9)

## ルーティングについて

- ルートに表示されていた`api` や`v1` は名前空間
  - `v1` は「バージョン1」の意味
  - 名前空間を使ってバージョン管理する方法はセマンティックバージョニングと呼ぶ
    - [セマンティック バージョニング 2\.0\.0 \| Semantic Versioning](https://semver.org/lang/ja/)
    - `scope` よりも`namespace` を使った方が良いらしい
      - [Railsのroutingにおけるscope / namespace / module の違い \- Qiita](https://qiita.com/ryosuketter/items/9240d8c2561b5989f049)

## コントローラー

- レスポンスは`render json` でJSON形式になっている
- 名前空間を使ってルーティングしている場合はコントローラーのディレクトリ構成も合わせる
- レスポンスはDBから取得したインスタンスを`data: @post` のように渡して返す

```ruby
# routes.rb
Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :posts
    end
  end
end

# posts_controller.rb
module Api
  module V1
    class PostsController < ApplicationController
    ...
    end
  end
end
```

## APIモードのポイント

- viewファイル無し
- DBのカラムは`schema.rb`で確認する
- controllerは`namespace` で区切られていることが多い

## APIのレスポンスの確認方法

下記の方法でAPIのレスポンスを確認できる

- Chrome DevTools > Network > Respose
- curlコマンド
  - [RailsのAPIのレスポンスをcurlコマンドで確認する \- karlley](https://scrapbox.io/karlley/Rails%E3%81%AEAPI%E3%81%AE%E3%83%AC%E3%82%B9%E3%83%9D%E3%83%B3%E3%82%B9%E3%82%92curl%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%81%A7%E7%A2%BA%E8%AA%8D%E3%81%99%E3%82%8B)
- postman
  - [【Postman】基本的な使い方を解説します \| たいらのエンジニアノート](https://www.tairaengineer-note.com/postman-how-to-use/)

## Railsのドキュメントでの情報

Rails4のAPIモードのアプリだったのでRails5を参照した

https://railsguides.jp/v5.0/api_app.html

### APIモードの特徴

* RailsのAPIアプリとはRailsのDBとのやり取りをする機能として使用すること

* RailsをAPIとして使用することでバックエンドを高速で構築できる
* RailsのミドルウェアをJSON生成専用に使う
* ルーターもRailsのものを使用する
  * リダイレクト、ヘッダレスポンスも使える
    * ヘッダレスポンスはUI表示に必要のない情報を省いたレスポンス

### APIモードでのRailsアプリの特徴

* APIモードではUI表示に関するミドルウェアを省いて構築される
* APIモードでは`ApplicationController` の継承が`ActionController::Base` では無く`ActionController::API` に変更される
  * UI表示に関するモジュールも除外される
* `rails g` でビューに関連するものを生成しなくなる

* `ActionDispatch::Request`
  * クライアント側からパラメータをJSONで受け取りコントローラーで`params` でアクセスできるようにする
  * クライアントからJSONを送信し、`Content-Type` に`application/json` を指定する
  * 受け取るパラメータは`{ :person => { :firstName => "Yehuda", :lastName => "Katz" } }` のような形式

* フロントエンドは`forntend` というルートディレクトリを作ることが多い？
* `package.json` にフロントのファイル読み込みの設定があるっぽい
