# friYAY（花金の過ごし方提案アプリ）

![イメージ画像](/img/git_image_png) 

## ■ サービス概要
せっかくの金曜日の夜を無駄にしない、充実した時間を過ごすための予定を提案してくれるアプリです。  

金曜日とは？  
「1980年代から週休二日制を採用する企業が増加すると、翌日が休日となる金曜日の価値が急上昇し、金曜日は俗に「花金」と呼ばれるようになった」(Wikipediaより)  

## ■メインのターゲットユーザー
- 毎週同じような華金の過ごし方をしている人
- 充実した華金を過ごしたいが、何をすればいいのか悩む人
- 1週間仕事を頑張ったから、金曜日の夜くらいは楽しい予定を作りたいが、何をすればいいのだろうと悩む人
- 華金を通じて新たな自分に出会いたい人  

## ■ユーザーが抱える課題
- 自分で思いつく過ごし方や予定案に限界がある。
- ブログ記事にまとめられていることもあるが、ありきたりな過ごしかたで面白みがない。  

## ■解決方法
- 華金の過ごし方や予定案を気軽に見ることができる。
- ユーザー同士で個性的・風変わりな過ごし方を提案し合うことができる。  

## ■実装予定の機能
- ログイン機能
- 予定案の提案投稿、いいね機能、ランキング表示
- 予定案の検索機能、ランダム表示  

### ログイン前の機能
- ユーザー新規登録（名前、誕生日、性別、メールアドレス、パスワード）
- ゲストログイン（誕生日、性別）  

### ゲストログイン後の機能
- 予定案のランダム表示
  表示内容：過ごし方内容、準備内容、手軽度
- 予定案検索機能
- 気に入った予定案のをお気に入り登録
- 「気になる」が押された予定案がランキング形式で表示される  

### ユーザー登録後、ログイン後の機能
- 予定の提案
- お気に入り登録した予定案を実行後、コメントと評価(星5つ)をすることができる

### MVP後に実装したい機能
- 世代・性別ごとのランキング
- 予定案のカテゴリー分け
- パスワード再登録機能
- 評価星マークの表示修正
- Twitter公式アカウントを作成し、過ごし方ランキング一位が毎週木曜日に自動ツイートされるようにする  

## ■なぜこのサービスを作りたいのか？
一人暮らしを始めて、ご飯を作ったり、洗濯をしたり、次の日のお弁当を作ったり、帰宅後は忙しく、あまり自分の時間が取れないのですが、金曜日の夜は次の日のことを考える必要がなく、自分の好きなことに没頭できます。自分と向き合い、新しい発見や新しい自分に出会える大切なひとときです。自分の"好き"を増やすことは、自分の世界を広げ、生き方を豊かにしてくれると思っています。金曜日の夜という限られた時間を有意義に使い、新たな自分に出会える手助けができればといいなと思ってこのサービスを作りたいと思いました。

## ■スケジュール
企画〜技術調査：- 8/28  
README〜ER図作成：- 9/11  
メイン機能実装：9/12 -  
β版をRUNTEQ内リリース（MVP）： - 10/31  
本番リリース：11月中旬  

## ■使用技術
バックエンド
- Ruby 3.1.2
- Ruby on Rails 7.0.4

フロントエンド
- HTML/SCSS/JavaScript(jQuery)
- CSS/frame-work
  -Bootstrap

インフラ
- Fly.io

## ■資料
ER図：https://drive.google.com/file/d/1-LvS2FlxxzCDU5y10V_OQVgsjQj1mMsx/view?usp=sharing
