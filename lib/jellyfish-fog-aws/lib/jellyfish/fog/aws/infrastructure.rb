module Jellyfish::Fog::AWS
  class Infrastructure < ::Provisioner
    def provision
      # TODO: Must get an image_id from product types
      details = order_item.answers.merge('image_id' => 'ami-acca47c4')
      begin
        server = connection.servers.create(details).tap { |s| s.wait_for { ready? } }
      rescue Excon::Errors::BadRequest, Excon::Errors::Forbidden => e
        raise e, 'Bad request. Check for valid credentials and proper permissions.', e.backtrace
      end

      order_item.instance_id = server.id
      order_item.private_ip = server.private_ip_address
      order_item.public_ip = server.public_ip_address
    end

    def retire
      connection.servers.delete(server_identifier)
      order_item.provision_status = :retired
    rescue Excon::Errors::BadRequest, Excon::Errors::Forbidden => e
      raise e, 'Bad request. Check for valid credentials and proper permissions.', e.backtrace
    end

    private

    def connection
      Fog::Compute.new(
        provider: 'AWS',
        aws_access_key_id: aws_settings[:access_key],
        aws_secret_access_key: aws_settings[:secret_key]
      )
    end

    def server_identifier
      order_item.payload_response['id']
    end
  end
end
