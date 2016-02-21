$(document).ready(function(){
  //textareaの動的変更
  $(".item-textarea").height(30);
  $(".item-textarea").css("lineHeight","20px");

  $(".item-textarea").on("input",function(evt){
    if(evt.target.scrollHeight > evt.target.offsetHeight){
        $(evt.target).height(evt.target.scrollHeight);
    }else{
        var lineHeight = Number($(evt.target).css("lineHeight").split("px")[0]);
        while (true){
            $(evt.target).height($(evt.target).height() - lineHeight);
            if(evt.target.scrollHeight > evt.target.offsetHeight){
                $(evt.target).height(evt.target.scrollHeight);
                break;
            }
        }
    }
  });

  $('#item-content').scrollTop($('#item-content')[0].scrollHeight);
  $('.item').hover (
    function () {
      var id = $(this).attr("id");
      $('#'+id+' .item-action').show();
    },
    function () {
      var id = $(this).attr("id");
      $('#'+id+' .item-action').hide();
    }
  );

  // 編集ボタンのクリックイベント
  $('.edit-button').click(function() {
    var id = $(this).attr("id");

    // submitボタンを編集ボタンへ変更する
    $('#'+id+'.item-inner').hide();
    $('#'+id+'.edit-form').show();

    // 現在の文字列をテキストフィールドに入れる
    console.log($('#'+id+'.item-text').text());

    // var text = $('#'+id+'.item-text').text();

    var text = $('#'+id+'.item-text-value').text();

    $('.item-edit').val(text);
  });

  $('.edit-cancel').click(function() {
    console.log("edit");
    var id = $(this).attr("id");

    $('#'+id+'.edit-form').hide();
    $('#'+id+'.item-inner').show();
  });

  $('.edit-submit').click(function() {
      console.log("submit");
      var id = $(this).attr("id");
      var text = $('#'+id+'.item-edit').val();
      console.log(text);

      $('#'+id+'.edit-form').hide();
      $('#'+id+'.item-inner').show();

      // ajax通信の開始
      $.ajax({
        type: "POST",
        url: "edit",
        data: { id: id, text: text },
        success: function(response) {
          console.log(response)
          $('#'+id+'.item-text').text(response.text)
        }
      });
  });

  // 削除ボタンのクリックイベント
  $('.delete-button').click(function() {
    var id = $(this).attr("id");

    // ajax通信
    $.ajax({
      type: "POST",
      url: "delete",
      data: { id: id },
      success: function(response){
        console.log(response)
        $('tr'+'#'+id).remove();
      }
    });
  });

  $("input[type='submit']").click(function(){
    if($(".item-textarea").val() == ""){
      // 空だとボタンにグレースケールかける
      return false;
    }
  });
});
