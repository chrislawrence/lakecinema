module Features
  def login 
    user = create(:user)
    visit login_url
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'Login'
  end
end
