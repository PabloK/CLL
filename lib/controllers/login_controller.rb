#encoding: utf-8
class LoginController < Sinatra::Base

  before do
    @consultant_track = nil
    @message = flash[:message]
  end

  post '/' do
    user = User.first(:email => params[:email].downcase)
    if user and user.password == params[:password] 
      if user.new_lookup!
        session[:user]=user.id
        session[:lookup]=user.lookup
        redirect '/'
      end
    end

    modal({:heading => "Inloggning misslyckades" ,:body => "Användaren kunde inte hittas i våra system, eller så angavs ett felaktigt lösenord."})
    redirect '/login'
  end
  
  get '/' do
    haml :login
  end

end

# Currently incative code
# class RecoverController < Sinatra::Base
#   post '/' do
#     @user = User.first(:email => params[:email])
# 
#     if @user
#       if @user.generate_recover_key!
#         options = {
#           :to => @user.email,
#           :subject => 'AsciiSoccer - Password Reset',
#           :body => 'Plain',
#           :html_body => (haml :recover),
#           :via => :smtp 
#         }
#         Pony.mail(options)
# 
#         popup("A recovery email was sent to \"#{@user.email}\".")
#       end
#       popup("No recovery key could be generated for user \"#{@user.email}\".")
#     end
#     popup("Your email \"#{params[:email]}\" could not be found in our systems.")
#   end
# 
#   get '/:id/:recover_key' do
#      flash[:message] = haml :reset, :layout => false
#      redirect '/'   
#   end
# 
#   post '/:id/:recover_key' do
#     user = User.get(params[:id]) 
#     if user.recover_key == params[:recover_key] and not user.recover_key.nil? and not user.recover_key.empty?
#       user.password = params[:password]
#       user.recover_key = ""
#       if user.save!
#         login(user)
#         popup("Your password was successfully reset.")
#       end
#     end
#     popup("Your password could not be reset try again from the start.")
#   end
# end
