# frozen_string_literal: true

RSpec.describe Prometheus::Client::DataStores::Rust::SingleThreaded do
  it "gets" do
    store = described_class.new.for_metric(nil, metric_type: nil)
    label_set = { foo: "bar", baz: "quux" }

    expect(store.get(labels: label_set)).to eq(0.0)
  end
end
