class TranslationsController < ApplicationController
  
  before_filter :load_page
  before_filter :get_mail_info, :execpt => [:destroy]
  before_filter :get_translation_info, :only => [:edit, :destroy,:update]
  layout 'mails'
  def new
    @translation = Translation.new
    @variables = MailVariable.all
    begin
    id = params[:language_id]
    @translation.mailer = @mail
    @translation.language = Language.find(id)
    rescue
       msg = "Attention: language with ID:#{id} not found in database"
       logger.error(msg)
       flash[:notice] = msg
     redirect_to mail_translations_path(@mail,:page=>@page)
    end
  end
  
  def create
     @translation = Translation.new(params[:translation])
     @translation.mailer = @mail
     respond_to do |format|
       if @translation.save
         flash[:notice] = 'translation was successfully created.'
         format.html { redirect_to mail_translations_path(@translation.mailer,:page=>@page) }
       else
         format.html { render :action => "new" }
       end
     end
  end
   
  def index
    @translations = @mail.translations
    @languages = Language.all
    @options = 
    {
      "\\$\\$\\$site_link\\$\\$\\$" => "http://www.dvdpost.be",
      "\\$\\$\\$logo_dvdpost\\$\\$\\$" => "<img src='http://www.dvdpost.be/images/www3/logo.jpg' />"
    }
  end
  
  def edit
    @variables = MailVariable.all
  end
  
  def destroy
    @translation.destroy
    redirect_to(mail_translations_path(@translation.mailer,:page=>@page))
  end
  
  def update
     respond_to do |format|
       if @translation.update_attributes(params[:translation])
         flash[:notice] = 'translation was successfully updated.'
         format.html { redirect_to mail_translations_path(@mail,:page=>@page)}
         
       else
         format.html { render :action => "edit" }
       end
     end
   end
   
  def load_page
    @page=params[:page] || 1
  end
  
  def get_mail_info
    begin
      id=params[:mail_id]
      @mail = Mailer.find(id)
      
    rescue ActiveRecord::RecordNotFound
       msg = "Attention: Mail with ID:#{id} not found in database"
       logger.error(msg)
       flash[:notice] = msg
       redirect_to mails_path
     end
  end
  def get_translation_info
    begin
      id=params[:id]
      
      @translation = Translation.find(id)
    rescue ActiveRecord::RecordNotFound
       msg = "Attention: translation with ID:#{id} not found in database"
       logger.error(msg)
       flash[:notice] = msg
       redirect_to mails_path
     end
  end
   
end