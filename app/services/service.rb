class Service
  include Dry::Monads[:result, :do]
  def self.call(...)
    new(...).call
  end
end
