class PropertyNotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_property_note, only: %i[show edit update destroy]

  # GET /property_notes
  # GET /property_notes.json
  def index
    @property_notes = PropertyNote.all
  end

  # GET /property_notes/1
  # GET /property_notes/1.json
  def show; end

  # GET /property_notes/new
  def new
    @property_note = current_user
                     .property_notes
                     .find_or_initialize_by(property_id: params[:property_id])
  end

  # GET /property_notes/1/edit
  def edit; end

  # POST /property_notes
  # POST /property_notes.json
  def create
    @property_note = current_user.property_notes.new(property_note_params)

    respond_to do |format|
      if @property_note.save
        format.html { redirect_to @property_note, notice: t('.notice') }
        format.json { render :show, status: :created, location: @property_note }
      else
        format.html { render :new }
        format.json { render json: @property_note.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  # PATCH/PUT /property_notes/1
  # PATCH/PUT /property_notes/1.json
  def update
    respond_to do |format|
      if @property_note.update(property_note_params)
        format.html { redirect_to @property_note, notice: t('.notice') }
        format.json { render :show, status: :ok, location: @property_note }
      else
        format.html { render :edit }
        format.json { render json: @property_note.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  # DELETE /property_notes/1
  # DELETE /property_notes/1.json
  def destroy
    @property_note.destroy
    respond_to do |format|
      format.html { redirect_to property_notes_url, notice: t('.notice') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_property_note
    @property_note = PropertyNote.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def property_note_params
    params.require(:property_note).permit(:user_id, :property_id, :text)
  end
end
