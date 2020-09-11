class ChatsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_room, only: [:create]
	def show
		@room = Room.find(params[:id])
		@currentUserUserRooms = current_user.user_rooms
		myRoomIds = []
		@currentUserUserRooms.each do |user_room|
			myRoomIds << user_room.room.id
		end
		@anotherUserRooms = UserRoom.where(room_id: myRoomIds).where('user_id != ?',current_user.id)
        if UserRoom.where(user_id: current_user.id, room_id: @room.id).present?
            @chats = @room.chats.includes(:user).order("created_at asc")
            @chat = Chat.new
        else
            redirect_back(fallback_location: users_path)
        end
	end

	def create
		if UserRoom.where(user_id: current_user.id, room_id:  @room.id)
            @chat = Chat.create(chat_params)
                if @chat.save
                    @chat = Chat.new
                    gets_entries_all_messages
                end
        else
            flash[:alert] = "メッセージの送信に失敗しました"
        end
         redirect_back(fallback_location: users_path)
	end

	private

	def set_room
        @room = Room.find(params[:chat][:room_id])
    end

	def gets_entries_all_messages
        @chats = @room.chats.includes(:user).order("created_at asc")
    end

	def chat_params
        params.require(:chat).permit(:user_id, :chat, :room_id).merge(user_id: current_user.id)
    end
end
