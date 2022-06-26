# frozen_string_literal: true

RSpec.describe Prometheus::Client::Rust::Datastores do
  it "has a version number" do
    expect(Prometheus::Client::Rust::Datastores::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
