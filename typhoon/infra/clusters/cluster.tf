module "bare-metal" {
  source = "git::https://github.com/poseidon/typhoon//bare-metal/container-linux/kubernetes?ref=v1.10.4"

  providers = {
    local    = "local.default"
    null     = "null.default"
    template = "template.default"
    tls      = "tls.default"
  }

  # bare-metal
  cluster_name           = "nubekit"
  matchbox_http_endpoint = "https://f1ebb1d3.ngrok.io"
  os_channel             = "coreos-stable"
  os_version             = "1745.7.0"

  # configuration
  k8s_domain_name    = "controller1.your.infra.domain"
  ssh_authorized_key = "ssh-rsa AAAAB3Nz..."
  asset_dir          = "/assets"

  # machines
  controller_names   = ["controller1"]
  controller_macs    = ["52:54:00:86:72:be"]
  controller_domains = ["controller1.your.infra.domain"]

  worker_names = [
    "worker1",
  ]

  worker_macs = [
    "52:54:00:2b:63:65",
  ]

  worker_domains = [
    "worker1.your.infra.domain",
  ]
}
