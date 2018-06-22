provider "matchbox" {
  # RPC endpoint is only exposed on internal cluster network
  endpoint    = "localhost:8081"
  client_cert = "${file("/run/secrets/localhost.crt")}"
  client_key  = "${file("/run/secrets/localhost.key")}"
  ca          = "${file("/run/secrets/matchbox.crt")}"
}

provider "local" {
  version = "~> 1.0"
  alias   = "default"
}

provider "null" {
  version = "~> 1.0"
  alias   = "default"
}

provider "template" {
  version = "~> 1.0"
  alias   = "default"
}

provider "tls" {
  version = "~> 1.0"
  alias   = "default"
}
