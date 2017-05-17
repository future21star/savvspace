class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:index, :new]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    authorize @profile
    @phone_call = if @profile.phone
                    PhoneCall.new(profile: @profile)
                  end
    @phone_call.build_from_phone if @phone_call
    @tab = params[:tab]
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
    authorize @profile
  end

  # GET /profiles/1/edit
  def edit
    authorize @profile
    @profile.build_phone unless @profile.phone
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    authorize @profile

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    authorize @profile
    respond_to do |format|
      if @profile.update(profile_params)
        if profile_params[:avatar].present?
          if profile_params[:avatar].instance_of? String
            avatar_data = JSON.parse(profile_params[:avatar])[0]
            past_avatar = @profile.past_avatars.find_by(public_id:avatar_data['public_id']);
            if past_avatar.present?
              @profile.avatar_url = Cloudinary::Utils.cloudinary_url(past_avatar.path)
            else
              att_file = Cloudinary::Uploader.upload(Cloudinary::Utils.cloudinary_url(@profile.avatar.path))
              new_past_avatar = @profile.past_avatars.new(public_id:att_file['public_id'], version:att_file['version'],width:att_file['width'],height:att_file['height'],format:att_file['format'],resource_type:att_file['resource_type'])
              new_past_avatar.save
            end
          else
            att_file = Cloudinary::Uploader.upload(Cloudinary::Utils.cloudinary_url(@profile.avatar.path))
            new_past_avatar = @profile.past_avatars.new(public_id:att_file['public_id'], version:att_file['version'],width:att_file['width'],height:att_file['height'],format:att_file['format'],resource_type:att_file['resource_type'])
            new_past_avatar.save
          end
        end
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    authorize @profile
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = if params[:user_id]
                   User.find(params[:user_id]).profile
                 elsif params[:vendor_id]
                   Vendor.find(params[:vendor_id]).profile
                 elsif params[:username]
                   Profile.find_by(username: params[:username])
                 else
                   Profile.find(params[:id])
                 end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).
        permit(:name, :username, :bio, :contact_email, :linked_in, :facebook, :twitter,
               :instagram, :avatar, :background, phone_attributes: [:number], past_avatars: [])
    end
end
