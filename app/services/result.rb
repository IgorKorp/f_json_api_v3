class Result
  attr_accessor :status, :data, :code

  def initialize(status, data: nil, code: 200)
    @status = status
    @data = data
    @code = code
  end

  def success?
    status
  end

  def error?
    !success?
  end
end