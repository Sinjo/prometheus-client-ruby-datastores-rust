module Prometheus
  module Client
    module DataStores
      module Rust
        # Stores all the data in a simple Hash for each Metric
        #
        # Has *no* synchronization primitives, making it the fastest store for single-threaded
        # scenarios, but must absolutely not be used in multi-threaded scenarios.
        class SingleThreaded
          class InvalidStoreSettingsError < StandardError; end

          def for_metric(metric_name, metric_type:, metric_settings: {})
            # We don't need `metric_type` or `metric_settings` for this particular store
            validate_metric_settings(metric_settings: metric_settings)

            MetricStore.new
          end

          private

          def validate_metric_settings(metric_settings:)
            unless metric_settings.empty?
              raise InvalidStoreSettingsError,
                "SingleThreaded doesn't allow any metric_settings"
            end
          end

          # Create the shell of this - we'll add methods to it in single_threaded.rs
          #
          # The reason to define thie here at all is that there's no way to
          # make it private from the Rust side.
          class MetricStore
          end

          private_constant :MetricStore
        end
      end
    end
  end
end
