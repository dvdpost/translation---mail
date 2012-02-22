class KeysController < ApplicationController
  
  
  before_filter :load_key, :only => [ 'edit','destroy', 'update','show']
  before_filter :load_page
  
  

  layout 'keys'
  def index
    @search=params[:search]
    if(@search.nil? || @search.empty?)
      @keys = Key.by_page(@page).ordered.paginate(:page => @pagination, :per_page => Key.per_page)
    else  
      @keys = Key.where("page = ? and (value like '%#{@search}%' or name like '%#{@search}%%')", @page).group("name").joins(:references => :keys_translations).paginate(:page => params[:pagination], :per_page => Key.per_page)
   end
    @languages = Language.all
    @countries=Country.all
    @reference=Reference.new
    
    respond_to do |format|
          format.html
       
    end
  end

  def auto_complete_for_page_search
    Rails.logger.debug { "ici" }
      searched = params[:page][:search]
      @pages = Key.where("page LIKE '%#{searched}%'").group('page').limit(6)
      render(:inline =>%{
          <ul>
              <% @pages.each do |page| -%>
                  <li><%= h page.page -%></li>
              <% end -%>
          </ul>})
  end


  def edit
     @index =0
     @path=key_path :pagination => @pagination
     @countries=Country.all
  end
  
  def show
    @reference=Reference.new
    @countries=Country.all
    @languages = Language.all
  end 
  
  def update
    respond_to do |format|
      if @key.update_attributes(params[:key])
        flash[:notice] = 'key was successfully updated.'
        format.html { redirect_to(:action =>"index",:pagination=>@pagination, :search => @search) }
      else
         @index =0
         @path=key_path :pagination => @pagination
         @countries=Country.all
        format.html { render :action => "edit" }
      end
    end
  end
   
  def destroy
    @key.destroy
    redirect_to(:action=> "index",:pagination=>@pagination, :search => @search)
  end
 
  def new
      @index =0
      @path=keys_path :pagination => @pagination, :search => @search
      @key = Key.new
      @countries=Country.all

      respond_to do |format|
        format.html # new.html.erb
      end
    end

    def create
      Rails.logger.debug { "@@@#{params.inspect}" }
      @key = Key.new(params[:key])
      countries=Country.find(params[:country][:id])
      
      @key.countries<< countries
      respond_to do |format|
        if @key.save
          flash[:notice] = 'key was successfully created.'
          format.html { redirect_to(:action =>"index",:page=>@key.page,:pagination=>@pagination, :search => @search) }
        else
          @index =0
          @path=keys_path :pagination => @pagination, :search => @search
          @countries=Country.all
          format.html { render(:action =>"new",:page=>@key.page) }
        end
      end
    end
   
    def load_key
       begin
         id = params[:id]
         @key = Key.find(id)
         @translation=@key.keys_translations
         rescue ActiveRecord::RecordNotFound
         msg = "Attention: key with ID:#{id} not found in database"
         logger.error(msg)
         flash[:notice] = msg
         redirect_to keys_path :pagination=>@pagination
       end
   end
     
   def load_page
     @page=params['page']
     @pagination=params[:pagination]
     @search = params[:search]
   end 
end
