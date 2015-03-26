class NotesController < ApplicationController
  layout 'application'
  before_action :logged_in_user, only: [:show, :new]

  def show
    @notes = current_user.notes
  end

  def new
    @note = Note.new
    render 'notes/_notesform'
  end

  def create
    # @note = Note.new(note_params)
    @note = current_user.notes.build(note_params)
    if @note.save
      flash[:success] = "Note successfully created"
      redirect_to notes_url
    else
      flash.now[:danger] = "An error occured somewhere"
      render 'show'
    end
  end

  def index
    
  end

  private
    def note_params
      params.require(:note).permit(:content, :category)
    end
end