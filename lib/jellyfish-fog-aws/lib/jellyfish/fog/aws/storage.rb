module Jellyfish::Fog::AWS
  class Storage < ::Provisioner
    def provision
      instance_name = "id-#{order_item.uuid[0..9]}"
      storage = connection.directories.create(key: instance_name, public: true)

      order_item.instance_name = instance_name
      order_item.url = storage.public_url
    end

    def retire
      connection.delete_bucket(storage_key)
      order_item.provision_status = :retired
    end

    private

    def connection
      Fog::Storage.new(
        provider: 'AWS',
        aws_access_key_id: aws_settings[:access_key],
        aws_secret_access_key: aws_settings[:secret_key]
      )
    end

    def storage_key
      order_item.payload_response['key']
    end
  end
end
