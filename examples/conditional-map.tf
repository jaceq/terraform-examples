locals {
  probe {
    http_probe {
      http_get = [ {
        path = "${var.http_probe_url}"
        port = "${var.http_probe_port}"
      } ]
      failure_threshold = "${var.failure_threshold}"
      period_seconds = "${var.period_seconds}"
      success_threshold = "${var.success_threshold}"
      timeout_seconds = "${var.timeout_seconds}"
      initial_delay_seconds = "${var.initial_delay_seconds}"
    }
    exec_probe {
      exec = [ {
        command = ["${split(",",var.readiness_probe_exec)}"]
      } ]
      failure_threshold = "${var.failure_threshold}"
      period_seconds = "${var.period_seconds}"
      success_threshold = "${var.success_threshold}"
      timeout_seconds = "${var.timeout_seconds}"
      initial_delay_seconds = "${var.initial_delay_seconds}"
    }
  }
}

readiness_probe = ["${local.probe["${var.http_probe_url == "" || var.http_probe_port == "" ? "exec_probe" : "http_probe"}"]}"]
