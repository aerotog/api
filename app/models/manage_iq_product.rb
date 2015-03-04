# == Schema Information
#
# Table name: manage_iq_products
#
#  id                 :integer          not null, primary key
#  created_at         :datetime
#  updated_at         :datetime
#  service_type_id    :integer
#  service_catalog_id :integer
#  chef_role          :string(100)
#  options            :json
#  cloud_id           :integer
#

class ManageIqProduct < ActiveRecord::Base
  has_one :product, as: :provisionable
  belongs_to :cloud

  def provisioner
    ManageIQ
  end
end
