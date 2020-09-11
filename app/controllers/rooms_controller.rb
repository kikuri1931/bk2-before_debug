class RoomsController < ApplicationController
	before_action :authenticate_user!
	def create
        @room = Room.create
        @joinCurrentUser = UserRoom.create(user_id: current_user.id, room_id: @room.id)
        @joinUser = UserRoom.create(params.require(:user_room).permit(:user_id, :room_id).merge(room_id: @room.id))
        redirect_to chat_path(@room.id)
    end
end
