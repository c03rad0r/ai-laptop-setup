# AI Laptop Setup

This Ansible project automates the setup of Ubuntu laptops for AI development work.

## Tools that will be installed

- ngit (Git extension)
- rana (Nostr miner)
- Git (version control)
- Emacs (text editor)
- Syncthing (file synchronization)
- Terminator (terminal emulator)
- htop (system monitor)

## Prerequisites

- Ubuntu OS
- Ansible installed

## Installation

1. Clone this repository
2. Run the playbook:
   ```
   sudo ansible-playbook playbooks/setup-ai-laptop.yml
   ```

## Usage

To setup a new AI laptop, simply run:

```bash
cd ~/ai-laptop-setup
sudo ansible-playbook playbooks/setup-ai-laptop.yml
```

