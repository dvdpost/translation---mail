class ReferencesController < ApplicationController
  layout 'keys'
  
  before_filter :load_page
  
  def index
    @reference=Reference.find_by_key_id(params[:key_id])
    @page=params[:page]
  end 
  
  def destroy
    Reference.find(params[:id]).destroy
    redirect_to(keys_path :pagination => @pagination, :search => @search)
  end
  
  def create
    
    reference = Reference.new(params[:reference], :search => @search)
    respond_to do |format|
      if reference.save
        flash[:notice] = 'key was successfully created.'
        format.html { redirect_to(keys_path(:page=>params[:page],:pagination => @pagination)) }
      else
        flash[:notice] = 'country reference already exist'
        format.html { redirect_to(keys_path(:page=>params[:page],:pagination => @pagination)) }
      end
    end
    
  end
  
  def load_page
    @page=params['page']
    @pagination=params[:pagination]
    @search = params[:search]
  end
end
