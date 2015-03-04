# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  description        :text
#  active             :boolean
#  img                :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  deleted_at         :datetime
#  product_type_id    :integer
#  setup_price        :decimal(10, 4)   default(0.0)
#  hourly_price       :decimal(10, 4)   default(0.0)
#  monthly_price      :decimal(10, 4)   default(0.0)
#  service_type_id    :integer
#  service_catalog_id :integer
#  cloud_id           :integer
#  chef_role          :string(255)
#  options            :json
#  provisionable_type :string(255)
#  provisionable_id   :integer
#
# Indexes
#
#  index_products_on_deleted_at        (deleted_at)
#  index_products_on_product_type_id   (product_type_id)
#  index_products_on_provisionable_id  (provisionable_id)
#

class Product < ActiveRecord::Base
  acts_as_paranoid

  store_accessor :options

  has_many :chargebacks
  belongs_to :provisionable, polymorphic: true
  belongs_to :product_type
  has_many :answers, class_name: 'ProductAnswer'

  accepts_nested_attributes_for :answers

  delegate :provisioner, to: :provisionable
end
