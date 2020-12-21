class ResumesController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
  def sign_up_params
    params.require(:user).permit(:email, :password, :name)
  end
  def index
    if(user_signed_in?)
      @resumes = Resume.where(:user_id => User.find(current_user.id))
    else
      @resumes = Resume.where(:user_id => nil)
    end
  end
  def new
    @resume = Resume.new
  end
  def create
    if(resume_params == nil)
      @resume = Resume.new()
      render "new"
    else
      if(resume_params[:true_label] == nil)
        ActionController::Parameters.permit_all_parameters = true
        file_name = (resume_params[:attachment]).original_filename
        cur_id = (user_signed_in?) ? User.find(current_user.id) : nil
        parampa = ActionController::Parameters.new(name:file_name,attachment: resume_params[:attachment],true_label: nil, pred_label: nil, user: cur_id)
        parampa= parampa.permit!
        @resume = Resume.new(parampa)
        if @resume.save
          redirect_to :controller => 'resumes', :action => 'result'
        else
          render "new"
        end
      else
        @res = Resume.order(:updated_at).last
        if(resume_params[:true_label] != "")
          Resume.update(@res[:id], :true_label => resume_params[:true_label])
        end
        redirect_to :controller => "resumes", :action => "index", notice: "The file #{@res[:name]} will be inspected and proceed, as soon as it possible"
        end
      end
    end
  def change
    @resume = Resume.new

  end
  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy
    redirect_to resumes_path, notice:  "The file #{@resume.name} has been deleted."
  end
  def result
    @resume = Resume.order(:updated_at).last
    labels = ['Cat','Dog','Elephant','Hamster']
    if(@resume[:pred_label] == nil )
      @pred_label = labels.sample
      Resume.update(@resume[:id], :pred_label => @pred_label,:true_label => @pred_label)
    else
      @pred_label = @resume[:pred_label]
    end


  end
  private
  def resume_params
    begin
      params.require(:resume).permit(:name, :attachment,:true_label)
    rescue ActionController::ParameterMissing
    end
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, address_attributes: [:country, :state, :city, :area, :postal_code]])
  end
end