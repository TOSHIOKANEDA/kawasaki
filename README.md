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
| start_time           | integer     | null:false         |
| end_time             | integer     | null:false         |
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
* off_actionともon_actionとも、そのままbefore_type_castすることなくviewに出すことが多いのでenumにはstringを入れている


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
  <dt>start_time:, end_time:</dt>
  <dd>"08:00":0,</dd>
  <dd>"16:30":17</dd>
</dl>

* access_levelは分岐で使用できるようstringはやめて英文字で指定した。
* power_switchはpower_switch.power_offでpresent?できるのでhelperとgemを入れて英文で管理。
* 日本語化はja.yml

## 3.User
<dl>
  <dt>authority:</dt>
  <dd>"一般":0,,</dd>
  <dd>"特別":1</dd>
  <dd>"ラウンド":2</dd>
  <dd>"管理者":9</dd>
</dl>
<dl>
* stringで直接呼び出すことが多いので、この方式にした
* authority_before_type_cast == 9で、controller内で分岐し、管理者権限とその他ユーザー権限とで分けている

 
# Proccess of usage
## User登録
- registration controllerで登録
- Emailの登録間違いが一定数いた経験から、confirmableとする
- gmailでとばす
- サインインとアウトの挙動は、application_controllerで記述
- ガードを高めるため、なるべくview側で分岐をさせずコントローラーで分岐をかけるようにした

## Slot登録
- 全てのメソッドにおいて、before_action :authorizerで管理者権限以外はnew_user_pathにredirectさせた
- 選択可能なSlotをauthorityのレベルの違いによってwhereでsortし、Bookingから予約を入れる流れ
```booking.helper.rb
  def normal
    Slot.where(full_status: 0).where(power_switch: 0).where(access_level: 0).order(date: "ASC", start_time: "ASC").map{|o| [[o.date.strftime("%Y年%m月%d日")+"の", o.start_time+"から", o.end_time+"まで"].join(""), o.id]}
  end
```
- 簡単に削除できてしまう。削除前にmessageを入れるべき？（お客さんと要確認）
- slot has_many bookingsなので、誤って消してしまうと全てのbookingsが削除される

## Booking登録
- Userのauthorityによって選択できるSlotが異なる
- 卸し時と積み時の両方とも、２つ選択肢があるのjsでdisplay: noneかinline_blockで隠すかでしている
- 予約削除と予約変更のタイミングについては特に何も設定せず（お客さんと確認）


# Guard & Validation

## Controller Guard

### Booking
- 下記の通り３つ
```
  before_action :authenticate_user!
  before_action :authorizer, only: [:admin, :booking_down_load]
  before_action :identifier, only: [:edit, :update, :destroy, :show]

  private
  def authorizer
    authorized_user(current_user.authority_before_type_cast)
  end

  def identifier
    find_params
    identical_user(@booking.user_id) unless current_user.authority_before_type_cast == 9
  end
  
  ---以下 application_controller.rb---

  def authorized_user(user_authority)
    redirect_to new_user_session_path unless user_authority == 9
  end

```

### User
- Booing同様３つ
```
  before_action :authenticate_user!
  before_action :authorizer, only: [:index, :destroy]
  before_action :identifier, only: [:show, :edit, :update]
```

### Slot
- ここは２つ。Slotは管理者のみが入れる物としてしているため
```
  before_action :authenticate_user!
  before_action :authorizer
```

## Validation Guard

### User
- Validationではないが、phoneを半角数字としハイフンは消すように、user.rbに記載

### Slot
- 時間についてを11:00から08:00までみたいな設定を防ぐため、enumのintegerで管理しvalidation下記の通り追加
```
  def start_ealier_than_end
    errors.add(:start_time, "は終了時間よりも早く設定してください")if end_time <= start_time
  end
```

### Booking
- コンテナ番号についての制限を入れている
- 全てのカラム内で同じコンテナ番号が存在していたら登録できないようにした
- 積み時及び卸し時とも、どちらかのカラムがないとエラーとさせた
```
  def cntr_booking
    off_exp_laden_in.presence or off_imp_empty_return.presence
    on_imp_laden_pick.presence or on_exp_booking_num.presence
  end
```


# Remarks

## 1.Deploy方法
- 完璧
https://qiita.com/gyu_outputs/items/b123ef229842d857ff39

- mysql
https://qiita.com/riekure/items/d667c707e8ca496f88e6
https://qiita.com/ksugawara61/items/336ffab798e05cae4afc

- 下は参考程度

https://bagelee.com/programming/ruby-on-rails/capistrano/

Unicornやnginx
https://qiita.com/Tatsu88/items/7030fd72d0ba714917fe

Capistranoの設定
https://qiita.com/Tatsu88/items/ab5d4927bbfade959c1c

===

## 2.開発メモ
- 1=問題あり、0=問題なし

* Slot
  (1) full_status: 0:余裕あり, 1:余裕なし、
  (2) power_switch: 0:電源on, 1:電源off
  (3) access_level: 0:一般権限, 1:VIP権限, 2:ラウンド権限
* Booking
  (1) off_action: "空バン返却":0, "実入り搬入":1
  (2) on_action: "実入りPICK":0, "空バンPICK":1
* User
  (1) authority(MODEL: User): 0:一般, 1:特別, 2:ラウンド, 9:管理者