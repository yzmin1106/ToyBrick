require 'crack'
require "mongo"

class UploadController < ApplicationController
  def upload
    require 'fileutils'
    tmp_file = params[:upload][:file]    #上传文件已经自动存储在"/var/folders/x/y/z/"下面了
    file = File.join("public", tmp_file.original_filename)
    FileUtils.cp tmp_file.path, file

    #redirect_to index
    respond_to do |format|
      format.html {redirect_to upload_url}
    end
  end

  def index
    respond_to do |format|
      format.html
    end
  end
end
