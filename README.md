## 概要

- Next.js 学習で作成したカンバンボードの api
- Ruby on Rails7
- 学習のため column と task を MongoDB、board を MySQL で作成

### 課題
- クライアントと WebSocket 通信
- Rspec 未実装
- Rubocop 未設定
- Mongoid のトランザクション（~~ スタンドアローンモードではトランザクション不可なため~~ シングルレプリカに切り替えて実装予定）
- lock_versionを使った楽観ロック
- ユーザー認証、認可
