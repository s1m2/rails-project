class ConversationsController < ApplicationController
  
  before_action :confirmed_logged_in
  
  layout :determine_layout

  def index
    @users = User.all
    @conversations = Conversation.order('created_at DESC')
    
  end
  
  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
  end
 
  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
 
  def interlocutor(conversation)
    current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end

  

end
