require "test_helper"

class DomainsControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    from = Time.new(2018,1,15).to_i
    to = Time.new(2018,4,15).to_i
    links = ['https://ya.ru', 'https://ya.ru?q=123','funbox.ru', 'https://stackoverflow.com/questions/11828270/how-to-exit-the-vim-editor']
    i = 1
    links.each do |link|
      Link.created(args: {link: link, created_at: Time.new(2018,i,15).to_i})
      i += 1
    end
    get "/visited_domains?from=#{from}&to=#{to}", as: :json
    assert_equal "{\"domains\":[\"ya.ru\",\"funbox.ru\",\"stackoverflow.com\"],\"status\":\"ok\"}", @response.body
    assert_response :success
  end

end
