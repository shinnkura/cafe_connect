import 'package:cafe_connect/components/custom_drawer.dart';
import 'package:cafe_connect/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:cafe_connect/screens/coffee_maker_description/components/build_aside.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// void main() {
//   runApp(const CoffeeMakerDescription());
// }

class CoffeeMakerDescription extends StatelessWidget {
  const CoffeeMakerDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: kBackgroundColor,
          title: const Text(
            'コーヒーメーカーの使い方',
            style: TextStyle(
              fontSize: 24.0,
              color: kTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.0,
          iconTheme: const IconThemeData(color: kTextColor),
        ),
        drawer: const CustomDrawer(),
        body: Container(
          color: kBackgroundColor,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 400, // ここで最大高さを設定
                    ),
                    child: Image.network(
                        'https://m.media-amazon.com/images/I/61w+J6HdSkL._AC_SL1500_.jpg'),
                  ),
                  const SizedBox(height: 16),
                  // const Text(
                  //   '■ 動画で簡単理解！',
                  //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  // ),
                  // const SizedBox(height: 8),
                  // // const Text('https://www.youtube.com/watch?v=ksbu-IEiR24'),
                  // YoutubePlayer(
                  //   controller: YoutubePlayerController(
                  //     initialVideoId: YoutubePlayer.convertUrlToId(
                  //       'https://www.youtube.com/watch?v=ksbu-IEiR24',
                  //     )!,
                  //     flags: const YoutubePlayerFlags(
                  //       autoPlay: true,
                  //       mute: true,
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 16),
                  const Text(
                    '■ 抽出方法',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  // 湯通しの説明
                  buildAside(
                    iconPath: '/icons/bookmark-outline_orange.svg',
                    title: '湯通し：6ステップ',
                    content: '''※「湯通し」とは？
        最初に使う前に行うプロセスで、中の不純物を取り除くために行われます。

1. 電源を「ON」にする
2. タンクに水をいれる
3. 適当な容器をセットする
4. 「ルンゴ」ボタンを押す
5. 容器に溜まったお湯を捨てる
6. 開閉レバーをあげ、抽出口に残ったお湯を出し切る''',
                  ),
                  // 使い方の説明
                  buildAside(
                    iconPath: '/icons/bookmark-outline_orange.svg',
                    title: '使い方：７ステップ',
                    content: '''1. 電源を「ON」にする
2. タンクに水をいれる
3. （ミルクメニューの場合）ミルクタンクをセットする
4. カプセルをセットする
5. カップを置く
6. メニューを選択する
7. （抽出の終了後）開閉レバーをあげてカプセルを捨てる''',
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '■ お手入れ方法',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  // お手入れ方法の説明
                  buildAside(
                      iconPath: '/icons/bookmark-outline_orange.svg',
                      title: '毎日のお手入れ：３ステップ',
                      content: '''1. 残ったタンクの水を捨てる
2. 排水受け皿を取り、カプセルを捨て、水洗い
3. ミルクを使用した場合は、ミルクタンクを分解し、各部品を洗浄する'''),
                  const SizedBox(height: 16),
                  const Text(
                    '■ ボタンのメニュー詳細',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  // ボタンの種類の説明
                  buildAside(
                    iconPath: '/icons/bookmark-outline_orange.svg',
                    title: 'コーヒー系',
                    content: '''
1. リストレット (25ml):
    * 小さな量の濃縮されたエスプレッソ。力強く濃厚。

2. エスプレッソ (40ml):
    * 濃縮されたコーヒー。濃厚で風味豊か。

3. ルンゴ (110ml):
    * エスプレッソよりも多めのお湯で抽出されたコーヒー。やや軽くてバランスの取れた味。''',
                  ),
                  buildAside(
                    iconPath: '/icons/bookmark-outline_orange.svg',
                    title: 'ラテ系',
                    content: '''
1. フラットホワイト(コーヒー：30~40ml,  ミルク：80~100ml):
    * エスプレッソに少しの蒸し牛乳を加えた濃厚でまろやかなコーヒー。

2. ラテマキアート (コーヒー：30~40ml,  ミルク：100~120ml , フォームミルク：100~120ml):
    * エスプレッソに少しのミルクを加えたシンプルなコーヒー。

3. カプチーノ (コーヒー：30~40ml,  フォームミルク：80~100ml):
    * エスプレッソと泡立てたミルクがバランスよく組み合わさったコーヒー。

4. カフェラテ (コーヒー：90~110ml,  ミルク：110~140ml , フォームミルク：50~60ml):
    * エスプレッソにスチームミルクを加え、まろやかな味わいに仕上げたコーヒー。''',
                  ),
                  buildAside(
                    iconPath: '/icons/bookmark-outline_orange.svg',
                    title: 'ミルク',
                    content: '''
1. ホットミルク (120~150ml):
    * 温められたミルク。シンプルで暖かく、穏やかな味。

2. ホットフォーム (180~200ml):
    * ふわふわの泡立てたミルク。コーヒーのトッピングや飾りに利用。''',
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '■ FAQ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  buildAside(
                    iconPath: '/icons/bookmark-outline_orange.svg',
                    title: 'Q：カップはどうすればいいですか？',
                    content:
                        '''A：マイカップをお持ちの方は、マイカップをご使用ください。お持ちでない方は、５階の流し、頭上の棚にあるカップをご使用ください。見つけられない方は、中岡に声をかけてください。
                    ''',
                  ),
                  buildAside(
                    iconPath: '/icons/bookmark-outline_orange.svg',
                    title: 'Q：おすすめは？',
                    content: '''A：ラテマキアートがおすすめです！
                    ''',
                  ),
                  buildAside(
                    iconPath: '/icons/bookmark-outline_orange.svg',
                    title: 'Q：牛乳はどうすればいいですか？',
                    content: '''A：５階の流しの奥にある牛乳をご使用ください。
                    ''',
                  ),
                  buildAside(
                    iconPath: '/icons/bookmark-outline_orange.svg',
                    title: 'Q：ミルクタンクのミルクが余ったら？',
                    content: '''A：ミルクタンクのレバーを「clean」にして、ミルクタンクごと冷蔵庫で保管してください。
                    ''',
                  ),
                  buildAside(
                    iconPath: '/icons/bookmark-outline_orange.svg',
                    title: 'Q：毎回洗うのめんどいです！',
                    content:
                        '''A：17時のカフェのタイミングで、中岡が洗います。ミルクだけは、冷蔵庫で保管するようにしてください！''',
                  ),
                  buildAside(
                    iconPath: '/icons/bookmark-outline_orange.svg',
                    title: 'Q：はじめて使うのが不安です！',
                    content: '''A：中岡か、そこら辺にいるエンジニアを捕まえていただければ、お手伝い致します。
                    ''',
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    '■ 参考文献',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () async {
                      String url =
                          'https://www.youtube.com/watch?v=ksbu-IEiR24'; // YouTubeのURL
                      // ignore: deprecated_member_use
                      if (await canLaunch(url)) {
                        // ignore: deprecated_member_use
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: const Text(
                      '動画で簡単理解！',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      String url =
                          'https://kaden-log.com/nespresso-granlattissima/'; // 製品レビューのURL
                      // ignore: deprecated_member_use
                      if (await canLaunch(url)) {
                        // ignore: deprecated_member_use
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: const Text(
                      'ブログ記事で簡単理解！',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      String url =
                          'https://www.nespresso.com/jp/ja/order/machines/original/gran-lattissima-fv'; // 製品ページのURL
                      // ignore: deprecated_member_use
                      if (await canLaunch(url)) {
                        // ignore: deprecated_member_use
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: const Text(
                      '製品ページ',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      String url =
                          'https://www.nespresso.com/shared_res/mos/docs/jp/GranLattissima_UM.pdf'; // 説明書のURL
                      // ignore: deprecated_member_use
                      if (await canLaunch(url)) {
                        // ignore: deprecated_member_use                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: const Text(
                      '説明書',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
