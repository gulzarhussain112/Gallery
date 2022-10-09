class AlbumsController < ApplicationController
    before_action :authenticate_user!, only: [:edit,:update,:delete,:destroy]
    before_action :correct_user, only: [:edit,:update,:delete,:destroy]
    before_action :authenticate_admin!, only: [:admin] 
    def index
        if user_signed_in?
            if current_user.admin?
                redirect_to :action => 'admin'
            else 
            @albums = Album.where("user_id = ?", current_user.id).published 
            end
      
          else
            redirect_to '/home/index'
        end

    end

    def new
        @album=Album.new
        @formSubmitBtn="Create"
    end

    def create
        @album=Album.new(album_params)
        if @album.save
            redirect_to @album
        else
            render :new, status: :unprocessable_entity
        end
    end
    
    def show
        @album=Album.find(params[:id])

    end

    def edit
        @formSubmitBtn="Update"
        @album=Album.find(params[:id])
    end

    def update
        @album=Album.find(params[:id])
        if @album.update(album_params)
            redirect_to @album
        else
            render :edit,status: :unprocessable_entity
        end
    end

    def destroy
        @album = Album.find(params[:id])
        @album.destroy
        redirect_to albums_path
      end

      def draft
        @albums=Album.where("user_id = ?", current_user.id).unpublished

      end

      def admin
        @user=User.all
        @users = User.all.where("id != ?", current_user.id)
     
      end
      def toggle
        @user = User.find_by_id(params[:id])
      
        if @user != nil?
          if @user.deactivated == false
            	bool = true
          else
              bool = false
          end
          @user.update(deactivated: bool)
        else
          set_flash "Error, please try again"
        end
      end

    private
    def  album_params
       params.require(:album).permit(:title, :tags_id,:description,:publish,:cover_picture,:tags_method,:user_id,images:[])
    end

   def correct_user
        @album=current_user.albums.find_by(id: params[:id])
        redirect_to albums_path, danger: "You are not authorised to modify" if @album.nil?
    
      end

    
end
