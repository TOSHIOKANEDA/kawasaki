<終わったこと>
1. turbokinkを削除した
2. Gitの設定

<確認すること>
1. １日あたりの台数現在の台数を確認する
  コンテナ本数Total：500~600 (AM: PM: 偏りはない。１０時くらいには並びが消える。お昼時間１１時。CY内にはトラックを入れておかない。
  15時頃にトラックが再度増えていく)
  ニトリの輸入６割（Totalでいうと輸入７割）、ユニクロの輸入１割ほど。
  
  おろしどり本数：空バン返却の３割がおろしどり


2. 予約確認場所を確認する
  インゲートで予約確認（屋根あり）。
3. おろしどりをするのに、現状必要な条件や現行の流れを確認する
  突然来ておろしどりをさせる。
4. 事前に知りたい情報を、最低限欲しい情報と出来れば欲しい情報とで確認する
  どのコンテナをいつ取りに来るかを知りたい。お客さん（ドレイ会社さん）の利用率。
5. おろしどりをする種別、おろしどりの作業手順
  全種類。
6. おろしどり以外に必要な機能やあったら嬉しい機能
  （１）特別搬出
  （２）船社負担の回送
7. User登録は、書面での誓約書を郵送 or Fax or 持ち込み
  OK
8. インゲートのOnline環境
  バーコードリーダーで確認
9. おろしどりマッチング機能についてどうか？
10. 実入り搬入の空バンPICKのパターンなら、〇〇台まで、空バン返却の実入りPICKなら〇〇台まで、みたいな制限はあるか
  制限なし
11. Userさんへの登録呼びかけは、秘密保持関係があるので１から集めていくがOKか

12. Webアプリケーションの開発・保守以外にも運営拡大についても、コンサルタントしていくような契約でいいか
  OK
13. 予約完成仮ゲート：2022年のくらい秋には  
14. 作業員さんの事前予約に対する反応
  協力的に作業ができる。

＝＝ここからは１月９日に聞きそびれた内容＝＝

15. インゲート処理時に、通常インゲートオペレーターが確認する内容
16. 実入り搬入時のコンテナ番号以外に、返却するコンテナやPICKや搬入したいB/L番号は必要か？
17. もし実入りPICKだけなら、輸入返却＆PICKのおろしどりしかシステム導入は不要？
18. もし輸出のおろしどりをするのであれば、輸出もシステム登録させて事前に把握することでのターミナル側でのメリットは何か？
19. 二個積み時の対応方法

DataBase設計

User
Slot
Booking
MyDriver

利用者の流れ（トラック業者編）
（１）User登録
（２）Booking登録（時間帯、日にち、種別登録）
（３）各種別登録（MtyReturn, MtyPick, LadenIn, LadenOut）
（４）登録完了したら、予約番号発券
（５）PSカード上のドライバー名をUpdate
（６）スマホのスクショかプリントアウトしたコピーを持参（ゆくゆくは、QRコードで確認したい）、画面に表示されているコンテナ番号、B/L番号をインゲートの人員が処理する。

利用者の流れ（ターミナルユーザー編）
1. ユーザー登録
（１）ユーザーをactivateする
（２）Activateした旨を通知する
2. 予約枠の登録
（１）おろしどり予約の実施２日ほど前に枠を設定する
（２）予約受付時間開始時に、予約開始のスイッチをオンにする
（３）予約受付終了後、TOS用データをダウンロードしTOSに読ませる
3. 予約日の対応
（１）予約実施中は特に何もしない
（２）予約が終わったら、枠の削除


<Deploy方法など>
＜完璧＞
https://qiita.com/gyu_outputs/items/b123ef229842d857ff39

＜下は参考程度＞

https://bagelee.com/programming/ruby-on-rails/capistrano/

Unicornやnginx
https://qiita.com/Tatsu88/items/7030fd72d0ba714917fe

Capistranoの設定
https://qiita.com/Tatsu88/items/ab5d4927bbfade959c1c