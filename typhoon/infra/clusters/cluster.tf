module "bare-metal" {
  source = "git::https://github.com/poseidon/typhoon//bare-metal/container-linux/kubernetes?ref=v1.10.4"

  providers = {
    local    = "local.default"
    null     = "null.default"
    template = "template.default"
    tls      = "tls.default"
  }

  # this depends on your provider... vultr is /dev/vda
  install_disk = "/dev/vda"

  # bare-metal
  cluster_name           = "nubekit"
  matchbox_http_endpoint = "http://matchbox.ngrok.io.ngrok.io"
  os_channel             = "coreos-stable"
  os_version             = "1745.7.0"

  # configuration
  k8s_domain_name    = "c1.dangerscope.com"
  ssh_authorized_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+XW2By5ta72EWag4SIKauYeIxJ6Ij9YcKTGioUKc79gHzHRK1bJM2gfvsIQm7chXqQLU5R1Ad8YR+zh28HpPUZjQLEX/foa1fV2ADVCdDds/fka8RfWBjK+QiScRl+yhNRw7wN8lKFe+0DFLrmr7a//8eACe0VbJ/dPdNu2xm3yCVJTf3jOY3LFLX9pnze9jFv6cEqUwHxMuk8iEK4LwGzseFOz2bUy43BPON+mHPkOTYhDkBV3RuCWOs41kqNDaK1AbMdjVhWkowCavFznjSMSRP6jd+JJ264FZRhVQQUf0aBxDk7GTSOuGJhJ5I+cEcgKINVdIGUphJ+NE99nW8a00YtwC3FKv+rFKRP1JPFiP2vKmpLfdNKujUm6uLEEOSTOCEMiTs8e+Ghrws7RnH3gBbviO/DDtbiqWgtDfFmZvtgfV7OkNTuCCFGGF+rhzHDnE4SIR1A4gGEq00qM8rPp71OuSjZR3eyxCG5MnZs1BLTnUH0BN8GFsG73v0CN+iaigmd0oeNJcA0NstZXnmzHTCNOoAv7huHcKAKsrph4rdGJY+q2W7K5tTn9GUJ/eHw/H0t0I4LEe0edJPuC97M/HbtIbp+XwF0OE//5xJXBklZ/EIpN7xLb7T7rJsWNJ/Dfg9MN7qNTQk7s3nmmWBFN16KeSjIb9y4t2zu+3M/Q== dustindecker@protonmail.com"
  asset_dir          = "/assets"

  # machines
  controller_names   = ["c1"]
  controller_macs    = ["56:00:01:8e:3d:c8"]
  controller_domains = ["c1.dangerscope.com"]

  worker_names = []

  # "worker1",

  worker_macs = []

  # "52:54:00:2b:63:65",

  worker_domains = []

  # "worker1.your.infra.domain",
}
