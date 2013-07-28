require 'crack'
require "mongo"

class UploadController < ApplicationController
  def upload
    #require 'fileutils'
    tmp = params[:mytest][:myfile]
    #print tmp.class
    #file = File.join("public", tmp.original_filename)
    #FileUtils.cp tmp.path, file

    file = File.open(tmp.path, "rb")
    contents = file.read
    file.close
    print contents

    #contents = "<a><b>123</b></a>"
    myXML = Crack::XML.parse(contents)
    myJSON = myXML.to_hash
    print myJSON

    connection = Mongo::Connection.new("localhost", 27017)
    db = connection.db("todo")
    coll = db.collection("xmls")
    coll.save(myJSON)
    #Mongo shell中的嵌套查询语句 - db.xmls.find({ "breakfast_menu.food.price" : "$4.50" })

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
