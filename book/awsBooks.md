# サーバーレスシングルページアプリケーション
Serverless Single Page Apps
www.oreilly.co.jp/books/9784873118062
https://pragprog.com/titles/brapps/serverless-single-page-apps/
https://github.com/benrady/learnjs

```
目次
本書への推薦の言葉
監訳者まえがき
はじめに
目次

1章　シンプルにはじめる
    1.1　サーバーレスWebアプリケーション
        1.1.1　サーバーレスデザインの利点
        1.1.2　サーバーレスデザインの制限
    1.2　ワークスペースを使う
        1.2.1　ローカルで実行する
        1.2.2　ランディングページを作る
    1.3　Amazon S3にデプロイする
        1.3.1　AWS CLIをセットアップする
        1.3.2　S3バケットを作成する
    1.4　はじめてのデプロイ
        1.4.1　次のステップ

2章　ハッシュイベントによるビューのルーティング
    2.1　テストしやすいルータを設計する
        2.1.1　Jasmineテストを実行する
        2.1.2　最初のテストを書く
    2.2　ルータ関数
        2.2.1　名前空間を作成する
        2.2.2　ルータ関数を追加する
        2.2.3　ビューコンテナを作る
    2.3　ルートを追加する
    2.4　ビューパラメータを追加する
        2.4.1　スパイを使って相互作用をテストする
        2.4.2　ビュー関数でパラメータを処理する
    2.5　アプリケーションをロードする
        2.5.1　イベントに反応する
        2.5.2　ハッシュイベントに反応する
    2.6　再びデプロイする
        2.6.1　次のステップ

3章　シングルページアプリケーションに必要なもの
    3.1　ビューを作成する
    3.2　データモデルを定義する
        3.2.1　データバインディング
        3.2.2　データモデルを成長させる
    3.3　ユーザー入力を処理する
        3.3.1　視覚的フィードバックを効果的に活用する
        3.3.2　ナビゲーションをコントロールする
    3.4　アプリケーションシェルを作成する
        3.4.1　ランディングページを抽出する
        3.4.2　ツールバーを追加する
    3.5　カスタムイベントを使う
    3.6　再びデプロイする
        3.6.1　次のステップ

4章　Amazon CognitoによるIdentity as a Service 
    4.1　外部のアイデンティティプロバイダに接続する
    4.2　アイデンティティプールを作成する
        4.2.1　アイデンティティプールの設定
        4.2.2　IAMロールとポリシー
    4.3　Googleアイデンティティを取得する
    4.4　AWS認証情報をリクエストする
        4.4.1　トークンを更新する
        4.4.2　DeferredオブジェクトとPromiseを使ったアイデンティティリクエスト
        4.4.3　アイデンティティDeferredを作成する
    4.5　プロファイルビューを作成する
    4.6　再びデプロイする
        4.6.1　次のステップ

5章　DynamoDBにデータを格納する
    5.1　DynamoDBと連携する
        5.1.1　DynamoDBのキーとハッシュを理解する
        5.1.2　ドキュメントデータベースとしてのDynamoDB 
        5.1.3　強い整合性と結果整合性
    5.2　テーブルを作成する
        5.2.1　属性とキー
        5.2.2　プロビジョニングされたスループット
        5.2.3　セカンダリキーとクエリとスキャン
    5.3　DynamoDBへのアクセス許可
    5.4　ドキュメントを保存する
        5.4.1　フェイルセーフのデータアクセス関数
        5.4.2　アイテムを作成して保存する
    5.5　ドキュメントを取得する
    5.6　データアクセスと検証
    5.7　再びデプロイする
        5.7.1　次のステップ

6章　Lambdaを使って（マイクロ）サービスを作る
    6.1　AWS Lambdaを理解する
        6.1.1　Lambdaの実行環境
        6.1.2　Lambdaの制限
        6.1.3　メモリ、時間、コスト
    6.2　まずデプロイする
        6.2.1　Lambda関数を設定する
        6.2.2　コードバンドルを作成する
        6.2.3　AWSコンソールから関数をテストする
        6.2.4　新しいLambda設定を作成する
        6.2.5　Lambda実行ロールにポリシーを追加する
    6.3　Lambda関数を書く
        6.3.1　マイクロサービスアーキテクチャの問題を避ける
        6.3.2　サービスに依存関係を追加する
        6.3.3　テストしやすいサービスを作る
        6.3.4　クエリ、グルーピング、ページング
    6.4　Lambda関数を呼び出す
    6.5　Amazon APIGatewayを使う
    6.6　再びデプロイする
        6.6.1　次のステップ

7章　サーバーレスのセキュリティ
    7.1　AWSアカウントをセキュアにする
        7.1.1　すべてのルートアクセスキーを無効にする
        7.1.2　プロファイルを使ってユーザーを管理する
        7.1.3　AWS認証情報をセキュアにする
        7.1.4　多要素認証をセットアップする
    7.2　クエリインジェクション攻撃
    7.3　クロスサイトスクリプティング攻撃
        7.3.1　XSSインジェクション手法
        7.3.2　Webワーカーを使ってJavaScriptをサンドボックス化する
    7.4　クロスサイトリクエストフォージェリ
        7.4.1　JavaScriptなしのXSRF 
        7.4.2　クロスオリジンリクエストと同一オリジンポリシー
    7.5　盗聴とトランスポート層のセキュリティ
        7.5.1　サイドジャッキング攻撃
        7.5.2　HTTPSを効果的に使う
    7.6　サービス拒否（DoS）攻撃
        7.6.1　CloudFrontを使ってS3を保護する
        7.6.2　スケーラブルなサービスとユーザーアイデンティティ
    7.7　再びデプロイする
        7.7.1　次のステップ

8章　スケールアップする
    8.1　Webサービスを監視する
        8.1.1　キャパシティ制限を監視する
        8.1.2　請求アラートを作成する
    8.2　S3Webトラフィックを解析する
        8.2.1　S3リクエストをログに記録する
        8.2.2　S3ログを解析する
    8.3　成長に合わせて最適化する
        8.3.1　キャッシュによってコストとロード時間を削減する
        8.3.2　バージョン管理されたファイル名を使ってキャッシュを無効化する
    8.4　クラウドのコスト
        8.4.1　ローディングコスト
        8.4.2　データコスト
        8.4.3　マイクロサービスコスト
        8.4.4　合計
    8.5　再びデプロイする（何度も、何度も）
        8.5.1　次のステップ

付録A　Node.jsのインストール
    A.1　Node.jsランタイムをインストールする
        A.1.1　Linux 
        A.1.2　OSX
        A.1.3　Windows 
    A.2　複数のNode.jsバージョンを管理する

付録B　ドメイン名を割り当てる

```

https://pragprog.com/titles/apapps/serverless-apps-on-cloudflare/

```
./sspa server
```