require "test_helper"

class LinksControllerTest < ActionDispatch::IntegrationTest
  test "should create link" do
    post '/visited_links',
         params: { links: ['https://ya.ru', 'https://ya.ru?q=123','funbox.ru', 'https://stackoverflow.com/questions/11828270/how-to-exit-the-vim-editor'] },
         as: :json

    assert_response 200
  end

end
