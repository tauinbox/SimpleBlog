require "spec_helper"

feature "Article Creation" do
  before(:each) do
    sign_up
  end

  scenario "allows user to visit new article page" do
    visit new_article_path    
    expect(page).to have_content I18n.t('articles.new')
  end

  scenario "allows user to create new article" do
    visit new_article_path

    fill_in :article_title, :with => "Test Article Title"
    fill_in :article_text, :with => "Content for new article"

    click_button I18n.t('articles.create')

    expect(page).to have_content 'Test Article Title'
  end
end
