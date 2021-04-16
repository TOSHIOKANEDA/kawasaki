$(function() {
  $('#loading_select').change(function() {
    var text = $('#loading_select option:selected').text();
    var html_cntr = `<input value="" class="new_box" type="text" name="booking[exp_cntr_num]">`
    var html_booking = `<input value="" class="new_box" type="text" name="booking[exp_booking_num]">`
    $('#js_field_new').append(html_cntr);
    // $('#js_field_new').remove(html_booking);
    console.log( text );
   });
});

// 次やること
// 分岐：textによってhtml_cntrかhtml_bookingのどちらかを表示させる
// 数値で分岐：textはstringのままなので、数値に置き換える
// html_cntrが選択されたらhtml_bookingを消す
// renderで切り出しているが、newとeditは別にすべきか検討



