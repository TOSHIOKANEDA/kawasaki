# DataBase Construction

## 1.Bookings
| Column               | Type        | Option             |
|:--------------------:|:-----------:|:------------------:|
| user_id              | bigint      | foreign_key: true  |
| slot_id              | bigint      | foreign_key: true  |
| booking_code         | string      | null:false         |
| on_imp_laden_pick    | string      | null:true          |
| on_exp_booking_num   | string      | null:true          |
| off_exp_laden_in     | string      | null:true          |
| off_imp_empty_return | string      | null:true          |
| off_action           | integer     | null:false         |
| on_action            | integer     | null:false         |
| created_at           | datetime    | null:false         |
| updated_at           | datetime    | null:false         |

### Association
- belongs_to :slot
- belongs_to :user


## 2.Slots
| Column               | Type        | Option             |
|:--------------------:|:-----------:|:------------------:|
| max_num              | integer     | null:false         |
| date                 | date        | null:false         |
| access_level         | integer     | defalut: 0         |
| power_switch         | integer     | default: 0         |
| full_status          | integer     | default: 0         |
| start_time           | string      | null:false         |
| end_time             | string      | null:false         |
| created_at           | datetime    | null:false         |
| updated_at           | datetime    | null:false         |

### Association
- has_many :bookings


## 3.Users
| Column                 | Type        | Option                   |
|:----------------------:|:-----------:|:------------------------:|
| email                  | string      | null:false, unique: true |
| encrypted_password     | string      | null:false               |
| reset_password_token   | string      | unique: true             |
| reset_password_sent_at | datetime    |                          |
| remember_created_at    | datetime    |                          |
| confirmation_token     | string      | unique: true             |
| confirmed_at           | datetime    |                          |
| confirmation_sent_at   | datetime    |                          |
| unconfirmed_email      | string      |                          |
| name                   | string      | null:false               |
| company                | string      | null:false               |
| phone                  | string      | null:false               |
| authority              | integer     | default:0                |
| certificate            | string      | default: "0"             |
| order_num              | integer     | default: 0               |
| created_at             | datetime    | null:false               |
| updated_at             | datetime    | null:false               |

### Association
- has_many :bookings


# Enum Construction

## 1.Bookings
<dl>
  <dt>off_action:</dt>
  <dd>"空バン返却":0</dd>
  <dd>"実入り搬入":1</dd>
  <dt>on_action:</dt>
  <dd>"実入りPICK":0</dd>
  <dd>"空バンPICK":1</dd>
</dl> 
`off_actionともon_actionとも、そのままbefore_type_castすることなくviewに出すことが多いのでenumにはstringを入れている`

## 2.Slots
<dl>
  <dt>access_level:</dt>
  <dd>general_access:0,</dd>
  <dd>vip_access:1</dd>
  <dd>dr_access:2</dd>
</dl>
<dl>
  <dt>power_switch:</dt>
  <dd>power_on:0,</dd>
  <dd>power_off:1</dd>
</dl>
<dl>
  <dt>time_list:</dt>
  <dd>"08:00":0</dd>
  <dd>"16:30":17</dd>
</dl>
`access_levelは分岐で使用できるようstringはやめて英文字で指定した。power_switchはpower_switch.power_offでpresent?できるのでhelperとgemを入れて英文で管理。日本語化はja.yml`


 
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

<mysql>
https://qiita.com/riekure/items/d667c707e8ca496f88e6
https://qiita.com/ksugawara61/items/336ffab798e05cae4afc

＜下は参考程度＞

https://bagelee.com/programming/ruby-on-rails/capistrano/

Unicornやnginx
https://qiita.com/Tatsu88/items/7030fd72d0ba714917fe

Capistranoの設定
https://qiita.com/Tatsu88/items/ab5d4927bbfade959c1c

===

開発メモ
1=問題あり、0=問題なし
full_status: 0:余裕あり, 1:余裕なし、
power_switch: 0:電源on, 1:電源off
access_level(MODEL: Booking): 0:一般権限, 1:VIP権限, 2:ラウンド権限
authority(MODEL: User): 0:一般, 1:特別, 2:ラウンド, 9:管理者

ロック
1. Slotは9番以外サインインへ誘導(authorizer)&&サインインのみ
2. User#index は9番以外サインインへ誘導(authorizer)&&サインインのみ
3. User/Slotはbefore_action :authenticate_user!


本番環境