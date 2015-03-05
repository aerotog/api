class Provisioner
  attr_reader :order_item

  def self.provision(order_item_id)
    order_item = OrderItem.find(order_item_id)
    new(order_item).provision
  rescue => e
    critical_error(order_item, e.message)
    raise
  ensure
    order_item.save!
  end

  def self.retire(order_item_id)
    order_item = OrderItem.find(order_item_id)
    new(order_item).retire
  rescue => e
    warning_retirement_error(order_item, e.message)
    raise
  ensure
    order_item.save!
  end

  def initialize(order_item)
    @order_item = order_item
  end

  private

  def self.warning_retirement_error(order_item, message)
    order_item.provision_status = :warning
    order_item.status_msg = "Retirement failed: #{message}"[0..254]
  end

  def self.critical_error(order_item, message)
    order_item.provision_status = :critical
    order_item.status_msg = message
  end
end
