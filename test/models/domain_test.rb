require "test_helper"

class DomainTest < ActiveSupport::TestCase
  test 'search by uuid' do
    from = 1610654400
    to = 1610913600
    link_array = {link: ['http://yandex.ru', 'http://funbox.ru', 'http://yandex.ru?q=123']}
    Link.created(args: {link: link_array[:link][0], created_at: from})
    Link.created(args: {link: link_array[:link][1], created_at: to})
    Link.created(args: {link: link_array[:link][2], created_at: to})
    domains = Domain.get_array_uniq_domains(from: from,  to: to)
    assert_equal(['yandex.ru', 'funbox.ru'].sort, domains.sort)
  end
end
