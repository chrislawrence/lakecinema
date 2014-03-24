require 'spec_helper'

describe NavigationHelper do
  describe '#nav_link' do
    before :each do
      helper.stub(:current_page?).and_return(true)
    end

    it 'adds the current class for the current page' do
      expect(helper.nav_link('link', 'url')).to include('current')
    end

    it 'does not add the current class for the current page' do
      helper.stub(:current_page?).and_return(false)
      expect(helper.nav_link('link', 'url')).to_not include('current')
    end

    it 'keeps options given in the method call' do
      link = helper.nav_link('link', 'url', id: 'test')
      expect(link).to include("id=\"test\"")
    end

    it 'adds to the class when given in the method call' do
      link = helper.nav_link('link', 'url', class: 'last')
      expect(link).to include("class=\"last current\"")
    end
  end
end
