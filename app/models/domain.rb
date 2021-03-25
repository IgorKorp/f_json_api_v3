class Domain
  attr_accessor :domain

  def initialize(link)
    self.domain = get_domain(link)
  end

  def self.get_array_uniq_domains(from: 0, to: -1)
    array_links = Link.get_all_models(from: from, to: to).reduce([]) do |arr, link|
      arr << Domain.new(link.link).domain
    end
    array_links.uniq.compact
  end

  private
  def get_domain(link)
    if link.nil?
      return  nil
    end
    domain = URI.parse(link).host
    if domain.nil?
      domain = link
    end
    domain.gsub(/^www\./, '')
  end
end