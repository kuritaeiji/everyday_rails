module LoginSupport
  def log_in(user)
    visit(root_path)
    click_on('Sign in')
    fill_in('Email', with: user.email)
    fill_in('Password', with: user.password)
    click_on('Log in')
  end
end

RSpec.configure { |config| config.include(LoginSupport) }