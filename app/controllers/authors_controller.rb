require 'nokogiri'

class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  def json_response(object, status = :ok)
    render json: object, status: status
  end
  
  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.all
    
    # Apply XSLT
    document = Nokogiri::XML(@authors.as_json.to_xml)
    template = Nokogiri::XSLT(File.read('app/assets/author.xsl'));
    transformed_document = template.transform(document)    
    
    # dumps the transformed document to the console so you can see the effects
    puts "---\nBefore"
    puts document
    puts "---\nAfter"    
    puts transformed_document  
    
    respond_to do |format|
      format.html {render :index}
      format.json {render :index, status: :ok}
      format.xml {render xml: @authors.as_json}
      #format.xml {render xml: transformed_document}
    end    
  end

  # GET /authors/1
  # GET /authors/1.json
  def show
  end

  # GET /authors/new
  def new
    @author = Author.new
  end

  # GET /authors/1/edit
  def edit
  end

  # POST /authors
  # POST /authors.json
  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        format.html { redirect_to @author, notice: 'Author was successfully created.' }
        format.json { render :show, status: :created, location: @author }
      else
        format.html { render :new }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /authors/1
  # PATCH/PUT /authors/1.json
  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to @author, notice: 'Author was successfully updated.' }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author.destroy
    respond_to do |format|
      format.html { redirect_to authors_url, notice: 'Author was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_author
      @author = Author.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def author_params
      params.require(:author).permit(:fname, :lname, :email, :thumbnail)
    end
end
