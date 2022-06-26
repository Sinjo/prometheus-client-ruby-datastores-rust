# frozen_string_literal: true

require_relative "rust/version"
require "rutie"

module Prometheus
  module Client
    module DataStores
      module Rust
        Rutie.new(:prometheus_client_datastores_rust).init 'Init_data_stores_module', "./lib"
      end
    end
  end
end
