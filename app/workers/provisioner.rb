class Provisioner
  attr_reader :order_item

  def self.provision(order_item_id)
    new(OrderItem.find(order_item_id)).provision
  rescue Excon::Errors::BadRequest, Excon::Errors::Forbidden
    authentication_error
    raise
  rescue => e
    critical_error(e.message)
    raise
  ensure
    order_item.save!
  end

  def self.retire(order_item_id)
    new(OrderItem.find(order_item_id)).retire
  rescue Excon::Errors::BadRequest, Excon::Errors::Forbidden
    authentication_error
    raise
  rescue => e
    warning_retirement_error(e.message)
    raise
  ensure
    order_item.save!
  end

  def initialize(order_item)
    @order_item = order_item
  end

  private

  def warning_retirement_error(message)
    order_item.provision_status = :warning
    order_item.status_msg = "Retirement failed: #{message}"[0..254]
  end

  def authentication_error
    order_item.provision_status = :critical
    order_item.status_msg = 'Bad request. Check for valid credentials and proper permissions.'
  end

  def critical_error(message)
    order_item.provision_status = :critical
    order_item.status_msg = message
  end
end
