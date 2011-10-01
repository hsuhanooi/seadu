class SmsController < ApplicationController
  
  def sms
    # http://yoursite.com/tmproc.php?user=\p&req=\0
    
    @user = params[:user]
    @req = params[:req]
    @response = "This Is A Test Response"
    
  end
  
end