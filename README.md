# nubekit

nubekit is a collection of tooling that makes it easy to use [Typoon](https://github.com/poseidon/typhoon/)'s bare-metal deploy approach in any environment.

## how it works

There are 4 components required:

- `matchbox` - inventory-aware network boot server (iPXE)
- `terraform + typhoon` - applies cluster configuration to `matchbox`, waits until it can SSH into nodes to bootstrap the cluster
- `iPXE` - we generate a custom ISO for iPXE booting in environments that don't allow iPXE booting directly
- `ngrok` - optional component for easy HTTPS endpoint hosting for `matchbox` from a laptop behind a firewall.=

1. Typhoon applies cluster config to Matchbox.
1. ngrok exposes matchbox publicly with TLS
1. Server iPXE boots from Matchbox, and provides its MAC address
1. Matchbox response with a coreos `ignition` script to add to the ssh `authorized_keys`, and install coreos (optional) to the specified boot device, along with any other provided ignition snippets. 
1. When server reboots from installer, Typhoon will SSH into the node, provision the generated TLS certs and bootstrap Kubernetes and ETCD.

## prerequisites

You will need:

- VMs or bare metal that can boot from an ISO or iPXE boot
- Their MAC addresses (you can find them on the first boot attempt if you don't have them)
- DNS (A or AAAA record) for the nodes
- ngrok installed and authorized
- Host where provisioning is initiated from can hit `22/tcp` and `443/tcp` on the nodes being provisioned
- The block device name to install to, such as `/dev/sda`, which depends on the environment

## instructions

1. Define `typhoon/infra/clusters/cluster.tf` based on `typhoon/infra/clusters/cluster.example.tf`
1. Generate secrets for Typhoon to connect to Matchbox gRPC over TLS:
    ```
    make gen-secrets
    ```
1. Deploy matchbox server and expose via ngrok:
    ```
    make deploy-matchbox
    ```
1. Build iPXE ISO if you cannot iPXE boot directly:
    ```
    make build-ipxe
    ```
    The ISO will be in the `out` folder.

1. Build typhoon docker image (one time thing)
    ```
    make build-typhoon
    ```
1. Run typhoon apply
    ```
    make apply-typhoon
    ```
1. iPXE boot your nodes via ISO or native iPXE