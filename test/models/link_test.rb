require "test_helper"

class LinkTest < ActiveSupport::TestCase

  test 'should save link' do
    link = Link.created(args: {link: 'http://yandex.ru'})
    assert_equal('http://yandex.ru', link.link)
  end


end
