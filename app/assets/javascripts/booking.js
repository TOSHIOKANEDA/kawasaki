$(function() {
  $('#loading_select').change(function() {
    var text = $('#loading_select option:selected').text();
    if (text == "空バンPICK"){
      $('#loading_box_1').css('display', 'inline-block');
      $('#exp_cntr_box').val("");
      $('#loading_box_2').hide();
    } else if (text == "実入りPICK"){
      $('#loading_box_1').hide();
      $('#exp_bkg_box').val("");
      $('#loading_box_2').css('display', 'inline-block');
    } else {
      $('#exp_cntr_box').val("");
      $('#exp_bkg_box').val("");
      $('#loading_box_1').hide();
      $('#loading_box_2').hide();
    }
   });
});

$(function() {
  $('#discharging_select').change(function() {
    var text = $('#discharging_select option:selected').text();
    if (text == "空バン返却"){
      $('#discharging_box_2').css('display', 'inline-block');
      $('#exp_laden_box').val("");
      $('#discharging_box_1').hide();
      console.log(text)

    } else if (text == "実入り搬入"){
      $('#discharging_box_1').hide();
      $('#imp_return_box').val("");
      $('#discharging_box_2').css('display', 'inline-block');
      console.log(text)

    } else {
      $('#imp_return_box').val("");
      $('#exp_laden_box').val("");
      $('#discharging_box_1').hide();
      $('#discharging_box_2').hide();
      console.log(text)
    }
   });
});