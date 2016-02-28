module ApplicationHelper

  # マークダウンへの対応
  @@markdown = Redcarpet::Markdown.new Redcarpet::Render::HTML,
    autolink: true,
    space_after_headers: true,
    no_intra_emphasis: true,
    fenced_code_blocks: true,
    tables: true,
    hard_wrap: true,
    xhtml: true,
    lax_html_blocks: true,
    strikethrough: true

  def markdown(text)
    @@markdown.render(text).html_safe
  end

  # テキスト中に含まれるurlをリンクに変換するメソッド
  def text_url_to_link text
      URI.extract(text, ['http']).uniq.each do |url|
        sub_text = ""
        sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
        text.gsub!(url, sub_text)
      end
    return text
  end

  # 改行コードから改行タグを作成する
  def linebreak_to_br(text)
    return text.gsub(/\r\n|\r|\n/, "<br />")
  end

  # 対象リンク先のOGP取得メソッド
  def getOgp(url)
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, charset)
    result_hash = {}
    site_name = nil
    image_url = nil

    # titleの取得
    if doc.css('//meta[property="og:site_name"]/@content').empty?
      site_name = ""
    else
      site_name = doc.css('//meta[property="og:site_name"]/@content').to_s
    end

    # アイキャッチ画像の取得
    if doc.css('//meta[property="og:image"]/@content').empty?
      image_url = ""
    else
      image_url = doc.css('//meta[property="og:image"]/@content').to_s
    end

    result_hash["site_name"] = site_name
    result_hash["image_url"] = image_url

    return result_hash
  end

end
