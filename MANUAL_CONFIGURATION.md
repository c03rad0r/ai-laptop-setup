# Manual Configuration for Nostr & Cashu Stack

This document outlines the necessary manual configuration steps required before running the `playbooks/install-nostr-cashu-stack.yml` Ansible playbook.

## 1. Create a Secrets File

Instead of editing the playbook directly, it is best practice to store your secrets and user-specific variables in a separate file. Create a new file named `secrets.yml` and add the following content, replacing the placeholder values with your actual data. **Do not commit this file to version control.**

```yaml
# secrets.yml

# -- Nostr & Domain Configuration --
# Your Nostr public key (hex format) for Blossom uploads
nostr_public_key: "YOUR_NOSTR_PUBLIC_KEY"

# Your public key for creating P2PK-locked Cashu vouchers (client-side operation)
cashu_voucher_pubkey: "YOUR_P2PK_PUBLIC_KEY"

# Domains for your services
blossom_domain: "blossom.yourdomain.com"
relay_domain: "relay.yourdomain.com"
bostr_domain: "bostr.yourdomain.com"
gitea_domain: "gitea.yourdomain.com"
mint_domain: "mint.yourdomain.com"

# -- (Optional) Cashu LNBits Backend --
# To use LNBits instead of the default FakeWallet, uncomment and configure these.
# cashu_ln_backend: "Lnbits"
# cashu_lnbits_api_url: "https://legend.lnbits.com"
# cashu_lnbits_admin_key: "YOUR_LNBITS_ADMIN_KEY"
```

## 2. DNS Configuration

Before running the playbook, you must have valid DNS records pointing to your VPS for the domains you defined in `secrets.yml`. Caddy requires this to successfully obtain SSL/TLS certificates.

Ensure the following DNS `A` or `AAAA` records are created:

- `blossom.yourdomain.com` -> `YOUR_VPS_IP_ADDRESS`
- `relay.yourdomain.com` -> `YOUR_VPS_IP_ADDRESS`
- `bostr.yourdomain.com` -> `YOUR_VPS_IP_ADDRESS`
- `gitea.yourdomain.com` -> `YOUR_VPS_IP_ADDRESS`
- `mint.yourdomain.com` -> `YOUR_VPS_IP_ADDRESS`

## 3. Running the Playbook

When you execute the playbook, use the `--extra-vars` flag to pass your secrets file:

```bash
ansible-playbook playbooks/install-nostr-cashu-stack.yml --extra-vars "@secrets.yml"
```

This command tells Ansible to load all the variables from `secrets.yml`, keeping your main playbook clean and free of sensitive information.

## 4. OpenMPTCProuter

There is a separate playbook, `playbooks/install-openmptcprouter.yml`, for installing OpenMPTCProuter. This playbook is **not** compatible with the Nostr & Cashu stack and should be run on a separate, dedicated VPS. It requires no manual configuration, but it will take over the server's networking and firewall.
