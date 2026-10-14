# Lab 01: Package Management

## Objective
Refresh Ubuntu package lists, install the tree package, and
explore the root user's filesystem.

## Commands Performed
- `sudo apt update`
- `sudo apt install -y tree`
- `tree --version`
- `sudo tree -L 2 /root`

## Skills Demonstrated
- APT package management
- Installing Linux packages
- Capturing command output
- Filesystem exploration
- Working with root-owned files and directories

## Evidence
- `evidence/tree-version.txt`
- `evidence/tree-output.txt`

## Results
- Package lists refreshed successfully.
- The tree package was installed successfully.
- Version output was saved to the required file.
- A two-level listing of `/root` was saved and verified.

## Key Learning
APT manages software packages on Ubuntu.
The `-y` option automatically confirms package installation.
The `tree -L 2` command limits the displayed directory depth.
