class UploadController < ApplicationController
  def upload
    require 'fileutils'
    tmp = params[:mytest][:myfile]
    file = File.join("public", tmp.original_filename)
    FileUtils.cp tmp.path, file

    #redirect_to index
    respond_to do |format|
      format.html {redirect_to upload_url}
    end
  end

  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end
end
