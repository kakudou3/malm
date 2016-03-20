class Item < ActiveRecord::Base

  # fileのアクセッサ
  attr_accessor :file

  # 保存、削除の前に処理を挟む
  # before_create :store_file
  # before_destroy :destroy_file
  before_save :store_file

  # upload file save前にファイルをアップロード
  def store_file
    # content_idがfileであればアップロード処理を挟む
    if self.content_id == 1
      self.file_path = '/attachments/' + self.file.original_filename
      File.open(full_path, "wb") do |f|
        f.write self.file.read
      end
    end
  end

  # delete file
  def destroy_file
    begin
      File.unlink full_path
    rescue
      nil
    end
  end

  # file pathの取得
  def full_path
    return Rails.root.join('public').to_s + self.file_path
  end
end
