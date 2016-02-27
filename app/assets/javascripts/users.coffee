# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.main-text').textillate ->
  # ループのオンオフ、falseの場合、outは発動しない
  loop: true,

  # テキストが置き換えられるまでの表示時間
  minDisplayTime: 2000,

  # 遅延時間
  initialDelay: 0,

  # アニメーションが自動的にスタートするかどうか
  autoStart: true,

  # フェードインのエフェクトの詳細設定
  in: {
    # エフェクトの名前（animate.cssをご参照下さい）
    effect: 'fadeInLeftBig',

    # 遅延時間の指数
    delayScale: 1.5,

    # 文字ごとの遅延時間
    delay: 50,

    # trueにすることでアニメーションをすべての文字に同時に適用される
    sync: false,

    # trueにすることで文字を順番にではなく、ランダムに入ってくるようにする
    # (注：syncがtrueの場合は無効になる)
    shuffle: false
  },

  # フェードアウトのエフェクトの詳細設定(同上)
  out: {
    effect: 'hinge',
    delayScale: 1.5,
    delay: 50,
    sync: false,
    shuffle: false,
  }
