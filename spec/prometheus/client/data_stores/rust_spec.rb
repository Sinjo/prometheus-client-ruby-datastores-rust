# frozen_string_literal: true

RSpec.describe Prometheus::Client::DataStores::Rust do
  it "has a version number" do
    expect(Prometheus::Client::DataStores::Rust::VERSION).to be_a(String)
  end
end
