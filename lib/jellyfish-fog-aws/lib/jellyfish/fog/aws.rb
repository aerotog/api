require 'railties'
require 'fog'

module Jellyfish
  module Fog
    module AWS
      class Engine < ::Rails::Engine
        config.to_prepare do
          Dir.glob(Jellyfish::Fog::AWS::Engine.root.join('lib/**/*.rb')).each do |file|
            require_dependency(file) unless file =~ /version/
          end
        end
      end
    end
  end
end
