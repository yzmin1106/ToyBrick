require 'crack'
require "mongo"

class UploadController < ApplicationController
  def upload
    tmp_file = params[:upload][:file]    #上传文件已经自动存储在"/var/folders/x/y/z/"下面了
    #puts tmp_file.path
    file = File.open(tmp_file.path, "rb")
    contents = file.read
    file.close

    #contents = "<a><b>123</b></a>"
    xml = Crack::XML.parse(contents)
    json = xml.to_hash

    #参见initializers/mongo.rb
    connection = Mongo::Connection.new("localhost", 27017)
    db = connection.db("todo")
    coll = db.collection("xmls")
    coll.save(json)
    #Mongo shell中的嵌套查询语句 - db.xmls.find({ "breakfast_menu.food.price" : "$4.50" })

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
