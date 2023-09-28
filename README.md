# コーヒーオーダーアプリ

<div style="display: flex;">
    <img src="images/Simulator Screenshot - iPhone 14 - 2023-06-12 at 03.30.45.png" alt="ホーム画面" style="width: 30%;">
    <img src="images/Simulator Screenshot - iPhone 14 - 2023-06-12 at 03.30.49.png" alt="ホーム画面" style="width: 30%;">
    <img src="images/Simulator Screenshot - iPhone 14 - 2023-06-12 at 03.31.13.png" alt="ホーム画面" style="width: 30%;">
    <img src="images/Simulator Screenshot - iPhone 14 - 2023-06-12 at 03.31.23.png" alt="ホーム画面" style="width: 30%;">
    <img src="images/Simulator Screenshot - iPhone 14 - 2023-06-12 at 03.31.51.png" alt="ホーム画面" style="width: 30%;">
</div>

## 概要

これは、コーヒーの注文を管理するためのシンプルな Flutter アプリケーションです。ユーザーは注文を行ったり、既存の注文を変更したり、注文をキャンセルしたりすることができます。アプリケーションは Firebase Firestore をバックエンドとして使用し、注文データを保存および取得します。

## 機能

- 新しいコーヒーの注文
- 既存のコーヒー注文の編集
- 既存のコーヒー注文のキャンセル
- 注文、編集、またはキャンセル後の感謝ページの表示

## インストール

このプロジェクトを実行するには、Flutter と Dart がマシンにインストールされている必要があります。まだこれらをインストールしていない場合は、こちらの指示に従ってインストールできます。

Flutter と Dart をインストールし設定したら、このリポジトリをローカルマシンにクローンできます。

```zsh
git clone https://github.com/yourusername/coffee_order_app.git
```

プロジェクトディレクトリに移動し、依存関係をインストールします。

```zsh
cd coffee_order_app
flutter pub get
```

これで、接続されたデバイス（エミュレータまたは物理デバイス）でアプリを実行できます。

```zsh
flutter run
```

## 構造

プロジェクトは、Flutter プロジェクトの組織化のベストプラクティスに従って構造化されています。lib ディレクトリには、アプリケーションのメイン Dart コードが含まれています。このディレクトリはさらに screens と components ディレクトリに分けられています。screens ディレクトリにはアプリケーションのさまざまな画面が含まれ、components ディレクトリにはさまざまな画面で使用される再利用可能なウィジェットが含まれています。

## 依存関係

- Flutter SDK: アプリケーションの開発には Flutter SDK を使用しています。
- Dart: アプリケーションコードを書くためのプログラミング言語として Dart を使用しています。
- Firebase Firestore: Firebase Firestore は、注文データを保存および取得するためのバックエンドとして使用されています。
- Material Design: UI には Material Design のコンポポーネントを使用しています。

## UI

このアプリケーションは、ユーザーフレンドリーで直感的な UI を提供します。注文の作成、編集、キャンセルはすべてシンプルで直感的な操作で行うことができます。また、注文の状態に応じて表示される感謝のページも含まれています。

## ライセンス

このプロジェクトは MIT ライセンスの下で公開されています。

##　貢献
このプロジェクトはオープンソースであり、あらゆる種類の貢献を歓迎しています。バグの報告、新機能の提案、プルリクエストなど、どんな形でも貢献していただけると幸いです。

## 連絡先

何か問題や質問がある場合は、GitHub の Issue を通じてお問い合わせください。
