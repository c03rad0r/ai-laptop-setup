# Manual Configuration for Nostr & Cashu Stack

This document outlines the necessary manual configuration steps required before running the `playbooks/install-nostr-cashu-stack.yml` Ansible playbook.

## 1. DNS Configuration

Before running the playbook, you must have valid DNS records pointing to your VPS for the domains you intend to use. Caddy requires this to successfully obtain SSL/TLS certificates.

Ensure the following DNS `A` or `AAAA` records are created:

- `blossom.yourdomain.com` -> `YOUR_VPS_IP_ADDRESS`
- `relay.yourdomain.com` -> `YOUR_VPS_IP_ADDRESS`
- `bostr.yourdomain.com` -> `YOUR_VPS_IP_ADDRESS`
- `mint.yourdomain.com` -> `YOUR_VPS_IP_ADDRESS`

## 2. Playbook Variables

Open the `playbooks/install-nostr-cashu-stack.yml` file and edit the `vars` section. You must replace the following placeholder values:

- `nostr_public_key`: Your Nostr public key (in hex format). This authorizes you to upload media to the Blossom server.
  ```yaml
  nostr_public_key: "YOUR_NOSTR_PUBLIC_KEY"
  ```

- `blossom_domain`: The domain for your Blossom media server.
  ```yaml
  blossom_domain: "blossom.yourdomain.com"
  ```

- `relay_domain`: The domain for your Khatru Nostr relay.
  ```yaml
  relay_domain: "relay.yourdomain.com"
  ```

- `bostr_domain`: The domain for your bostr2 Nostr relay.
  ```yaml
  bostr_domain: "bostr.yourdomain.com"
  ```

- `mint_domain`: The domain for your Cashu mint.
  ```yaml
  mint_domain: "mint.yourdomain.com"
  ```

- `cashu_voucher_pubkey`: Your public key for creating P2PK-locked vouchers. This is a client-side operation, but the variable is here for documentation.
  ```yaml
  cashu_voucher_pubkey: "YOUR_P2PK_PUBLIC_KEY"
  ```

## 3. (Optional) Cashu Backend

By default, the Cashu mint is configured to use `FakeWallet`, which is suitable for testing without real transactions. If you want to connect to a Lightning backend, you will need to modify the playbook.

For example, to use LNBits, you would change the following variables in `playbooks/install-nostr-cashu-stack.yml`:

```yaml
cashu_ln_backend: "Lnbits"
```

And add the following to the `vars` section:

```yaml
cashu_lnbits_api_url: "https://legend.lnbits.com" # Or your own instance
cashu_lnbits_admin_key: "YOUR_LNBITS_ADMIN_KEY"
```

You would also need to update the `templates/cdk-mintd.service.j2` template to include the LNBits environment variables.
