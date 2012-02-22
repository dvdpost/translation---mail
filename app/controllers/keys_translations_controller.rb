class KeysTranslationsController < ApplicationController
  
  
  before_filter :load_translation, :only => [ 'edit','destroy','show']
  before_filter :load_page
  
  layout 'keys'
  def index
    
  end

  def edit
    @index =0
    @reference_id=params['reference_id']
    key_translation=KeysTranslation.find(params[:id])
    @language_id = key_translation.language_id
    @path=reference_keys_translation_path :pagination=>@pagination
  end
  
  def update
    id = params[:id]
    @key_translation=KeysTranslation.find(id)
    respond_to do |format|
      if @key_translation.update_attributes(params[:keys_translation])
        flash[:notice] = 'Value was successfully updated.'
        format.html { redirect_to keys_path( :pagination=>@pagination, :search => @search)}
        
      else
        @index=0
        @reference_id=@key_translation.reference.id
        @path=reference_keys_translation_path :pagination=>@pagination, :search => @search
        
        format.html { render :action => "edit" }
      end
    end
  end
   
  def destroy
    @key_translation.destroy
    redirect_to(keys_path :pagination=>@pagination, :search => @search)
  end

  def new
    @index =0
    @path=reference_keys_translations_path :pagination=>@pagination, :search => @search
    @key_translation = KeysTranslation.new
    @language_id=params['language_id']
    @language=Language.find(@language_id)
    reference_id = params[:reference_id]
    @reference = Reference.find(reference_id)
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
      @key_translation = KeysTranslation.new(params[:keys_translation])
      ref = Reference.find(params[:reference_id])
      @key_translation.reference=ref
      
      respond_to do |format|
        if @key_translation.save
          flash[:notice] = 'Value was successfully created.'
          format.html { redirect_to(keys_path( :pagination=>@pagination, :search => @search)) }
        else
          @index =0
          @path=reference_keys_translations_path :pagination=>@pagination, :search => @search
          @language=@key_translation.language
          format.html { render :action => "new" }
        end
      end
    end
   
    def load_translation
       begin
         id = params[:id]
         reference_id = params[:reference_id]
         @reference = Reference.find(reference_id)
         @key_translation=KeysTranslation.find(id)
         
         rescue ActiveRecord::RecordNotFound
         msg = "Attention: translation with ID:#{id} not found in database"
         flash[:notice] = msg
         redirect_to keys_path :pagination=>@pagination, :search => @search
       end
   end
     
   def load_page
     @page=params[:page]
     @pagination=params[:pagination]
     @search=params[:search]
     
   end

end
