class MessagesController < ApplicationController
  layout :determine_layout
  before_action :confirmed_logged_in
  
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  before_action do
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.last
    if @message.present?
      if @message.user_id != current_user.id
         @message.update_attributes(:read=>'1',:created_at=>Time.now)
      end
    end
    
  end
  def index
    @messages = @conversation.messages.order('created_at DESC')
  end

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id
    @message.save!
 
    redirect_to(:controller=>'messages/index',:conversation_id => @conversation.id)
  end
 
  private
 
  def message_params
    params.require(:message).permit(:body)
  end
end
