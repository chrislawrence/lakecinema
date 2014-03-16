require 'spec_helper'

feature "Admin adds a programme" do
  before do
    @week = build(:week)
  end

  scenario "User fills out the form to add a new week" do
    fill_week_fields
    click_button 'Save'
    expect(page).to have_content(@week.title)
  end

  scenario "User adds a movie", :js do
    fill_week_fields
    within('.movie.one') do
      fill_in 'Title', with: 'The Godfather'
      choose_autocomplete_result 'The Godfather'
    end
    click_button 'Save'
    expect(page).to have_content('The Godfather')
  end

  def fill_week_fields
    visit new_week_path
    fill_in 'Start date', with: @week.start_date
    fill_in 'End date', with: @week.end_date
  end

  def choose_autocomplete_result(item_text, input_selector="input[data-autocomplete]")
    page.execute_script %Q{ $('#{input_selector}').trigger("focus") }
    page.execute_script %Q{ $('#{input_selector}').trigger("keydown") }
    # Set up a selector, wait for it to appear on the page, then use it.
    item_selector = "ul.ui-autocomplete li.ui-menu-item a:contains('#{item_text}')"
    page.should have_selector item_selector
    page.execute_script %Q{ $("#{item_selector}").trigger("mouseenter").trigger("click"); }
  end

  def fill_autocomplete(field, options = {})
    fill_in field, :with => options[:with]

    page.execute_script %Q{ $('##{field}').trigger("focus") }
    page.execute_script %Q{ $('##{field}').trigger("keydown") }
    selector = "ul.ui-autocomplete a:contains('#{options[:select]}')"

    page.should have_selector selector
    page.execute_script "$(\"#{selector}\").mouseenter().click()"
  end
  
end
