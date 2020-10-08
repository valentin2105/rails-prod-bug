class NotesController < ApplicationController
    def new
        @note = Note.new
    end

    def index
        @notes = Note.all
        flash.now[:notice] = "Il y a #{@notes.size} notes"

    end
    
    def show
        @note = Note.find(params[:id])
    end

    def create 
        @note = Note.new(note_params)
        @note['author'] = current_user.email
        if @note.save
          redirect_to @note
        else
          render 'new'
        end        
    end

    private
        def note_params
            params.require(:note).permit(:title, :text, :date, :author)
        end
end
