require "spec_helper"

feature "Article Creation" do
  before(:each) do
    sign_up
  end

  scenario "allows user to edit article" do

    # создаем новую статью
    visit new_article_path
    
    fill_in :article_title, :with => "Test Article Title"
    fill_in :article_text, :with => "Content for new article"

    click_button I18n.t('articles.create')

    # редактируем эту статью (она последняя созданная)
    visit edit_article_path(Article.last)

    # изменяем заголовок
    fill_in :article_title, :with => "New-Title"
    click_button I18n.t('articles.submit')

    # проверяем соответствие измененного заголовка
    expect(page).to have_content "New-Title"

    visit edit_article_path(Article.last)    

    # изменяем содержимое
    fill_in :article_text, :with => "Content-for-edit-article"
    click_button I18n.t('articles.submit')

    # проверяем соответствие измененного содержимого статьи
    expect(page).to have_content "Content-for-edit-article"
  end
end
