class ToolController < ApplicationController
  def upload
    @tool = Tool.new
  end

  def zip
    @tool = Tool.new(params[:tool])

    respond_to do |format|
      if @tool.valid?
        zipped_path = @tool.save_zip_as_zip

        format.html { redirect_to :action => 'download', :tool => params[:tool], :zipped_path => zipped_path}
        format.json { render :upload, status: :created, location: @tool }
      else
        format.html { render :upload }
        format.json { render json: @tool.errors, status: :unprocessable_entity }
      end
    end
  end

  def download
    send_file(params[:zipped_path])
  end

  def create

  end
end
