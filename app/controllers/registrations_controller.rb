class RegistrationsController < Devise::RegistrationsController
  def new
    build_resource({})
    set_minimum_password_length
    self.resource.company = Company.new
    yield resource if block_given?
    respond_with self.resource
  end

  def create
    super
    resource.update_attributes(role: :manager)
  end

  private

  def sign_up_params
    user_params = [:name, :email, :password, :password_confirmation, [company_attributes: [:name]]]
    params.require(resource_name).permit(user_params)
  end
end