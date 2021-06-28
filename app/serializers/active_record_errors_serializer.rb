class ActiveRecordErrorsSerializer
  attr_reader :object

  def initialize(object)
    @object = object
  end

  def to_h
    serializable_hash
  end

  def as_json(_payload = nil)
    { data: { type: 'errors' }, attributes: to_h }
  end

  private

  def serializable_hash
    object.errors.messages.flat_map do |field, errors|
      errors.flat_map do |error_message|
        {
          source: { pointer: "/data/attributes/#{field}" },
          details: error_message
        }
      end
    end
  end
end