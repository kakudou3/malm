# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  # textareaの動的変更
  $(".item-textarea").height(30)
  $(".item-textarea").css("lineHeight","20px")

  $(".item-textarea").on "input", (evt) ->
    if evt.target.scrollHeight > evt.target.offsetHeight
      $(evt.target).height(evt.target.scrollHeight)
    else
      lineHeight = Number($(evt.target).css("lineHeight").split("px")[0])
      while true
        $(evt.target).height $(evt.target).height() - lineHeight
        if evt.target.scrollHeight > evt.target.offsetHeight
          $(evt.target).height(evt.target.scrollHeight)
          break

  $('#item-content').scrollTop($('#item-content')[0].scrollHeight)

  $('.item').hover ->
    id = $(@).attr("id")
    $('#'+id+' .item-action').show()
  ,
  ->
    id = $(@).attr("id")
    $('#'+id+' .item-action').hide()

  # 編集ボタンのクリックイベント
  $('.edit-button').click ->
    id = $(this).attr("id")

    # submitボタンを編集ボタンへ変更する
    $('#'+id+'.item-inner').hide()
    $('#'+id+'.edit-form').show()

    # 現在の文字列をテキストフィールドに入れる
    console.log($('#'+id+'.item-text').text())

    # var text = $('#'+id+'.item-text').text()

    text = $('#'+id+'.item-text-value').text()

    $('.item-edit').val(text)

  $('.edit-cancel').click ->
    console.log("edit")
    id = $(this).attr("id")

    $('#'+id+'.edit-form').hide()
    $('#'+id+'.item-inner').show()

  $('.edit-submit').click ->
    id = $(this).attr("id")
    text = $('#'+id+'.item-edit').val()
    $('#'+id+'.edit-form').hide()
    $('#'+id+'.item-inner').show()

    # ajax通信の開始
    $.ajax({
      type: "POST",
      url: "/items/edit",
      data: { id: id, text: text },
      success: (response) ->
        console.log(response)
        $('#'+id+'.item-text').text(response.text)
    })

  # 削除ボタンのクリックイベント
  $('.delete-button').click ->
    id = $(this).attr("id")

    # ajax通信
    $.ajax({
      type: "POST",
      url: "/items/delete",
      data: { id: id },
      success: (response) ->
        console.log(response)
        $('tr'+'#'+id).remove()
    })

  $("input[type='submit']").click ->
    if $(".item-textarea").val() == ""
      # 空だとボタンにグレースケールかける
      return false

  $(".file-upload-link").click ->
    $(".item-file").click()
    return false # デフォルトのリンク挙動をキャンセルさせる

  # ファイルのアップロード
  $('.item-file').change ->
    console.log "changed"
    id = $(this).attr("id")
    content_id = 1
    fd = new FormData()
    fd.append("data_file", $(".item-file").prop("files")[0])
    fd.append("id", id)
    fd.append("content_id", content_id)

    # ajax通信
    $.ajax({
      type: "POST",
      url: "/items/create_file", # ここindexに投げるようにする controllerにcontent typeを渡して分岐させるようにする
      data : fd,
      processData : false,
      contentType : false,
      success: (response) ->
        $('#table-item').append('<tr id="'+response.id+'">
          <td class="item" id="'+response.id+'" style="">
            <div class="row-fluid" style="padding-top: 5px; padding-bottom: 5px;">
              <div class="item-inner" id="'+response.id+'">
                <h6 class="colmd-1" style="color: gray;">'+response.created_at+'</h6>
                  <img src="'+response.file_path+'" width="200" height="200">
                <div class="col-md-3 item-action" style="display: none;">
                  <button type="button" class="btn btn-warning delete-button" id="'+response.id+'">Delete</button>
                </div>
              </div>
            </div>
          </td>
        </tr>')

        # 動的に追加した要素に対してjquery動かしたい場合にやむおえず...
        $('#item-content').scrollTop($('#item-content')[0].scrollHeight)
        $('.item').hover ->
          id = $(@).attr("id")
          $('#'+id+' .item-action').show()
        ,
        ->
          id = $(@).attr("id")
          $('#'+id+' .item-action').hide()
        # console.log(response)
        # 画像添付セルをappend
    })


  # shift + enterで送信できるようにする
  $(document).on "keypress", ".item-textarea", (e) ->
    if e.keyCode == 13
      if e.shiftKey
        if $(".item-textarea").val() == ""
          return false
        else
          $('.item-submit').trigger('submit')
          return false
      else
        # return false


$(document).ready(ready)
$(document).on('page:load', ready)
