# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

use Rack::Health

# Export metrics for prometheus
use Yabeda::Prometheus::Exporter

run Rails.application
