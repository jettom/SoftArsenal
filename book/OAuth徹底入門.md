# OAuth徹底入門
[seshop](https://www.seshop.com/product/detail/22242)
[github](http://github.com/oauthinaction/oauth-in-action-code)
[https://github.com/oauthinaction/oauth-in-action-code](https://github.com/oauthinaction/oauth-in-action-code)

第1部　はじめの一歩
Chapter 1　OAuth 2.0とは何か？そして、なぜ気にかけるべきなのか？
　1.1　OAuth 2.0とは何か？
　1.2　古き悪しき手法～クレデンシャルの共有～
　1.3　アクセス権の委譲
　1.4　OAuth 2.0～良い点と悪い点、そして醜い点～
　1.5　OAuth 2.0ではないものは何か？
　1.6　まとめ

Chapter 2　OAuthダンス～OAuthの構成要素間の相互作用～
　2.1　OAuth 2.0プロトコルの概要～トークンの取得と使用～
　2.2　OAuth 2.0における認可付与の詳細
　2.3　クライアント、認可サーバー、リソース所有者、保護対象リソース
　2.4　トークン、スコープ、認可付与
　2.5　OAuthの構成要素間のやり取り
　2.6　まとめ

第2部　OAuth 2.0環境の構築
Chapter 3　シンプルなOAuthクライアントの構築
　3.1　認可サーバーへのOAuthクライアントの登録
　3.2　認可コードによる付与方式を使ったトークンの取得
　3.3　保護対象リソースへのトークンの使用
　3.4　アクセス・トークンのリフレッシュ
　3.5　まとめ

Chapter 4　シンプルなOAuthの保護対象リソースの構築
　4.1　HTTPリクエストからのOAuthトークンの解析
　4.2　データストアにあるトークンとの比較
　4.3　トークンの情報をもとにしたリソースの提供
　4.4　まとめ

Chapter 5　シンプルなOAuthの認可サーバーの構築
　5.1　OAuthクライアントの登録管理
　5.2　クライアントの認可
　5.3　トークンの発行
　5.4　リフレッシュ・トークンのサポートの追加
　5.5　スコープのサポートの追加
　5.6　まとめ

Chapter 6　実際の環境におけるOAuth 2.0
　6.1　認可における付与方式
　6.2　クライアントの種類
　6.3　まとめ

第3部　OAuth 2.0の実装と脆弱性
Chapter 7　よく狙われるクライアントの脆弱性
　7.1　一般的なクライアントのセキュリティ
　7.2　クライアントに対するCSRF攻撃
　7.3　クライアント・クレデンシャルの不当な取得
　7.4　リダイレクトURIの登録
　7.5　認可コードの不正な取得
　7.6　トークンの不正な取得
　7.7　ネイティブ・アプリケーションでのベスト・プラクティス
　7.8　まとめ

Chapter 8　よく狙われる保護対象リソースの脆弱性
　8.1　保護対象リソースの脆弱性とはどのようなものなのか？
　8.2　保護対象リソースのエンドポイントの設計
　8.3　トークンのリプレイ攻撃
　8.4　まとめ

Chapter 9　よく狙われる認可サーバーの脆弱性
　9.1　一般的なセキュリティ
　9.2　セッションの乗っ取り
　9.3　リダイレクトURIの不正操作
　9.4　クライアントのなりすまし
　9.5　オープン・リダイレクトによる脆弱性
　9.6　まとめ

Chapter 10　よく狙われるOAuthトークンの脆弱性
　10.1　Bearerトークンとは何か
　10.2　Bearerトークンの使用に関するリスクと考慮点
　10.3　どのようにBearerトークンを保護するのか？
　10.4　認可コード
　10.5　まとめ

第4部　さらなるOAuthの活用
Chapter 11　OAuthトークン
　11.1　OAuthにおけるトークンとは何か？
　11.2　JWT（JSON Web Token）
　11.3　JOSE（JSON Object Signing and Encryption）
　11.4　トークン・イントロスペクション（Token Introspection）
　11.5　トークン取り消し（Token Revocation）
　11.6　OAuthトークンのライフサイクル
　11.7　まとめ

Chapter 12　動的クライアント登録
　12.1　どのようにサーバーがクライアントのことを知るのか？
　12.2　実行時におけるクライアント登録
　12.3　クライアント・メタデータ
　12.4　動的な登録が行われたクライアントの管理
　12.5　まとめ

Chapter 13　OAuth 2.0を使ったユーザー認証
　13.1　なぜ、OAuth 2.0は認証プロトコルではないのか？
　13.2　OAuthと認証プロトコルとの関連付け
　13.3　OAuth 2.0ではどのように認証を使うのか？
　13.4　認証にOAuth 2.0を使用する際に陥りやすい落とし穴
　13.5　OpenID Connect
　13.6　シンプルなOpenID Connectシステムの構築
　13.7　まとめ

Chapter 14　OAuth 2.0を使うプロトコルとプロファイル
　14.1　UMA（User Managed Access）
　14.2　HEART（HEAlth Relationship Trust）
　14.3　iGov（international Government assurance）
　14.4　まとめ

Chapter 15　Bearerトークンの次にくるもの
　15.1　なぜBearerトークン以上のものが必要なのか？
　15.2　所有証明（Proof of Possession：PoP）トークン
　15.3　所有証明（PoP）トークンのサポートに関する実装
　15.4　TLSトークン・バインディング
　15.5　まとめ

Chapter 16　まとめと結論
　16.1　正しいツール
　16.2　重要な決定を行うこと
　16.3　さらに広がるエコシステム
　16.4　コミュニティ
　16.5　OAuthの未来
　16.6　まとめ

付録
　付録A　本書で使っているフレームワークについて
　付録B　演習で使うソースコード集

