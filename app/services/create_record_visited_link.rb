class CreateRecordVisitedLink < Service
  include Callable

  def initialize(links = nil)
    @unix_time = Time.new.to_i
    @array_links = links
  end

  def call
    result = check_links
    if result.nil?
      create_records
    else
      result
    end
  end

  private

  def check_links
    if @array_links.nil? || @array_links.empty? || !@array_links.kind_of?(Array)
      return error({status: 400, error: 'link of list was empty or not array'}, code: 400)
    elsif not_validate_links?
      return error({status: 422, error: 'links not valid'}, code: 422)
    end
    nil
  end

  def not_validate_links?
    @array_links.each do |link|
      unless validate_link link
        return true
      end
    end
    false
  end

  def create_records
    @array_links.each  do |link|
      Link.created(args: {link: link, created_at: @unix_time})
    end
    success({status: 'ok'})
  end

  def validate_link(link)
    pattern = /[-a-zA-Z0-9@:%_\+.~#?&\/=]{2,256}\.[a-z]{2,4}\b(\/[-a-zA-Z0-9@:%_\+.~#?&\/=]*)?/
    pattern === link
  end
end