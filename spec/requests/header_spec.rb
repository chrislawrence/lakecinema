require 'spec_helper'

describe 'header' do
  it 'renders the default header' do
    get root_path
    expect(assigns(:header_path)).to eq('layouts/header')
  end

  it 'renders the admin header' do
    get dashboard_url
    expect(assigns(:header_path)).to eq('layouts/admin_header')
  end

  it 'renders the small header' do
    get contact_path
    expect(assigns(:header_path)).to eq('layouts/small_header')
  end
end
