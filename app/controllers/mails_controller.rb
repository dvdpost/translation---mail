class MailsController < ApplicationController
  
  before_filter :load_mail, :only => ['edit', 'destroy', 'update','show']
  before_filter :load_page
  layout 'mails' 
  
  def index
    @mails = Mailer.where("deleted = 0").order("id DESC").paginate(:page => @page, :per_page => Mailer.per_page)
    @languages = Language.all
    respond_to do |format|
      format.html
    end
  end
  
  def destroy
    @mail.deleted=true
    @mail.save
    redirect_to(:action=> "index",:page=>@page)
  end
  
  def edit
   @path=mail_path(@mail,:page=>@page)
   @categories = CategoryTicket.all
  end

  def show
    @languages = Language.all
  end
  
  def update
     respond_to do |format|
       if @mail.update_attributes(params[:mail])
         flash[:notice] = 'mail was successfully updated.'
         format.html { redirect_to(:action =>"index",:page=>@page) }
       else
         @path=mail_path(@mail,:page=>@page)
         format.html { render :action => "edit" }
       end
     end
   end
   
   def new
     @mail = Mailer.new
     @path=mails_path()
     @categories = CategoryTicket.all
     respond_to do |format|
       format.html # new.html.erb
     end
   end

   def create
     @mail = Mailer.new(params[:mail])

     respond_to do |format|
       if @mail.save
         flash[:notice] = 'mail was successfully created.'
         format.html { redirect_to(:action =>"index") }
       else
         @path=mails_path(:page=>@page)
         format.html { render :action => "new" }
       end
     end
   end 
   
   def load_mail
     begin
       id = params[:id]
       @mail = Mailer.find(id)
     rescue ActiveRecord::RecordNotFound
       msg = "Attention: Mail with ID:#{id} not found in database"
       logger.error(msg)
       flash[:notice] = msg
       redirect_to mails_path
     end
   end
   def load_page
     @page=params[:page] || 1
   end
end
