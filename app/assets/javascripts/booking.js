$(function() {
  $('#loading_select').change(function() {
    var text = $('#loading_select option:selected').text();
    if (text == "空バンPICK"){
      $('#loading_box_1').css('display', 'inline-block');
      $('#cntr_box').val("");
      $('#loading_box_2').hide();
    } else if (text == "実入りPICK"){
      $('#loading_box_1').hide();
      $('#bkg_box').val("");
      $('#loading_box_2').css('display', 'inline-block');
    } else {
      $('#cntr_box').val("");
      $('#bkg_box').val("");
      $('#loading_box_1').hide();
      $('#loading_box_2').hide();
    }
   });
});