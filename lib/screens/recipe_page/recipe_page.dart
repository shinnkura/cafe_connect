import 'package:cafe_connect/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:cafe_connect/components/custom_drawer.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: const Text(
          'レシピ一覧',
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
        child: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'この度は、配布時間が1日一回となってしまい、申し訳ございません。\n\n'
                'そこで、\n「なんでもいいから早く飲みたい」\n「息抜きしたい」\n「自分で作ってみたい」\n「時間過ぎちゃったけど、飲みたい」\nという方に向けて、手軽に作れるレシピをご紹介します。\n\n'
                'それぞれのレシピにかかる時間も記載していますので、ぜひ参考にしてください。',
              ),
            ),
            RecipeCard(
              title: 'コーヒー',
              time: '所要時間：4分',
              ingredients: 'お湯85° 200g、豆15g、',
              steps: [
                'ドリーパー上の粉を平らにする。',
                'タイミングとお湯の量は以下の通り。',
                '1回目：0:00 → 35g',
                '2回目：0:30 → 70g',
                '3回目：0:50 → 105g',
                '4回目：1:10 → 160g',
                '5回目：1:30 → 200g',
              ],
              tips: '豆の種類や温度、器具によって味が変わるのも楽しみの一つです。',
            ),
            RecipeCard(
              title: 'カフェオレ',
              time: '所要時間：7分',
              ingredients: 'コーヒー豆、ミルク',
              steps: [
                'コーヒーをドリップする。',
                'ミルクを容器に入れ、電子レンジで2分温める。',
                '温めたミルクをコーヒーに加える。',
              ],
              tips: 'ミルクは、コーヒーメーカーでも作成することができます。',
            ),
            RecipeCard(
              title: 'ふわふわカフェオレ',
              time: '所要時間：7分',
              ingredients: 'コーヒー豆、ミルク、ネスプレッソ',
              steps: [
                'コーヒーをドリップする。',
                'ネスプレッソで「フォームミルク」を作る。',
                'フォームミルクにコーヒーを注ぐ。',
              ],
              tips: '※ ５階流し奥にあるミルクフォーマーは、使い方が特殊なため、使用は避けてください。',
            ),
            RecipeCard(
              title: 'ソイラテ',
              time: '所要時間：8分',
              ingredients: 'コーヒー、豆乳',
              steps: [
                'コーヒーをドリップする。',
                '豆乳を容器に入れ、電子レンジで2分温める。',
                '温めた豆乳をコーヒーに加える。',
              ],
              tips: '※コーヒーメーカーでの豆乳使用は故障の原因になるため避けてください。',
            ),
            RecipeCard(
              title: '緑茶',
              time: '所要時間：1分',
              ingredients: '緑茶パック、お湯',
              steps: [
                '緑茶パックをカップに入れる。',
                'お湯を注ぐ。',
              ],
              tips: '待つ時間、パックを揺らす時間、パックを取り除くタイミングでの味の変化をお楽しみください',
            ),
            RecipeCard(
              title: '抹茶ラテ',
              time: '所要時間：5分',
              ingredients: '抹茶、砂糖、お湯、牛乳',
              steps: [
                '抹茶と砂糖を小さじ1杯ずつ入れる。',
                'お湯を少量ずつ加え、ダマを作らないように混ぜる。',
                '牛乳を容器に入れ、電子レンジで2分温める。',
                '温めた牛乳を抹茶に加える。',
              ],
              tips: '気分によって、抹茶の濃さを変えるのもおすすめです！',
            ),
            RecipeCard(
              title: 'アイスコーヒー（水出し）',
              time: '所要時間：30秒',
              ingredients: '作り置きのアイスコーヒー',
              steps: [
                '作り置きのアイスコーヒーをカップに注ぐ。',
              ],
              tips: '甘くしたい方は、ガムシロップがおすすめです！',
            ),
            RecipeCard(
              title: 'アイスコーヒー（急冷式）',
              time: '所要時間：5分',
              ingredients: 'コーヒー、氷',
              steps: [
                'コーヒーをドリップする。',
                '氷を加える。',
              ],
              tips: '味はあなた次第です！',
            ),
            RecipeCard(
              title: 'アイスカフェオレ',
              time: '所要時間：1分',
              ingredients: '水出しアイスコーヒー、ミルク',
              steps: [
                '水出しアイスコーヒーとミルクを混ぜる。',
              ],
              tips: '甘くしたい方は、ガムシロップがおすすめです！',
            ),
            RecipeCard(
              title: 'アイスソイラテ',
              time: '所要時間：1分',
              ingredients: '豆乳、水出しアイスコーヒー',
              steps: [
                '豆乳と、水出しアイスコーヒーを「7:3」で注いで完成です。',
              ],
              tips: 'ソイラテの味を楽しみたい方は、豆乳を多めにしてみてください！',
            ),
            RecipeCard(
              title: '緑茶（アイス）',
              time: '所要時間：3分',
              ingredients: '緑茶、氷',
              steps: [
                '濃い目に緑茶を抽出し、そこに氷を適量入れて完成です！',
              ],
              tips: '緑茶の味を楽しみたい方は、氷を少なめにしてみてください！',
            ),
            RecipeCard(
              title: 'アイス抹茶ラテ',
              time: '所要時間：4分',
              ingredients: '抹茶、砂糖、お湯、牛乳、氷',
              steps: [
                'まず、抹茶と砂糖をそれぞれ小さじ一杯を入れ、お湯はお好みで追加してください。',
                'お湯は、少しずつ注いでいき、ダマが出ないように混ぜながら、適量を注いでください。',
                'その後、牛乳を注ぎ、最後に、氷を追加すれば完成です！',
              ],
              tips: '抹茶の味を楽しみたい方は、氷を少なめにしてみてください！',
            ),
            RecipeCard(
              title: '裏メニュー（ティーラテ）',
              time: '所要時間：4分',
              ingredients: 'リプトンのティーパック、砂糖、ミルク',
              steps: [
                'リプトンの好みのティーパックを濃い目に抽出。',
                '小さじ1杯のお砂糖を容器に入れる。',
                'その後、ネスプレッソコーヒーメーカーで、「フォームミルク」を抽出。',
                '最後に、フォームミルクを注いで、完成です！',
              ],
              tips: 'ミルクの量を調整することで、濃さを調整することができます！ お砂糖はお好みでどうぞ！',
            ),
            RecipeCard(
              title: '裏メニュー（アイスティーラテ）',
              time: '所要時間：3分',
              ingredients: 'リプトンのティーパック、砂糖、牛乳、氷',
              steps: [
                'リプトンの好みのティーパックを濃い目に抽出。',
                '小さじ1杯のお砂糖を容器に入れる。',
                'その後、牛乳を注ぎ、適度に氷を追加して完成です。',
              ],
              tips: '評判が良かったら、メニューに加えるかもです！',
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String title;
  final String time;
  final String ingredients;
  final List<String> steps;
  final String tips;

  const RecipeCard({
    super.key,
    required this.title,
    required this.time,
    required this.ingredients,
    required this.steps,
    required this.tips,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // タップした時の処理をここに書く
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailPage(title: title, steps: steps),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(time),
              const SizedBox(height: 8),
              Text('材料：$ingredients'),
              const SizedBox(height: 8),
              const Text('作り方：'),
              for (var step in steps) Text('- $step'),
              const SizedBox(height: 8),
              Text('Tips: $tips'),
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeDetailPage extends StatelessWidget {
  final String title;
  final List<String> steps;

  const RecipeDetailPage({super.key, required this.title, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 24.0,
            color: kTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        iconTheme: const IconThemeData(color: kTextColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('作り方：'),
            for (var step in steps) Text('- $step'),
          ],
        ),
      ),
    );
  }
}
