require "spec_helper"

feature "Comment Creation" do
  before(:each) do
    sign_up
  end

  scenario "allows user to create new article" do
    visit new_article_path

    fill_in :article_title, :with => "Test Article Title"
    fill_in :article_text, :with => "Content for new article"

    click_button I18n.t('articles.create')

    fill_in :comment_body, :with => "This-is-a-test-comment"

    click_button I18n.t('articles.add_comment')

    expect(page).to have_content "This-is-a-test-comment"
  end
end
