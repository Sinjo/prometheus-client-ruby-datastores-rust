# frozen_string_literal: true

RSpec.describe Prometheus::Client::DataStores::Rust::SingleThreaded do
  it "reverses" do
    expect(described_class.reverse("apples")).to eq("selppa")
  end
end
