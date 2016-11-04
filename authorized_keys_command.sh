#!/bin/bash -e

if [ -z "$1" ]; then
  exit 1
fi

aws iam list-ssh-public-keys --user-name "$1@colorjar.com" --query "SSHPublicKeys[?Status == 'Active'].[SSHPublicKeyId]" --output text | while read KeyId; do
  aws iam get-ssh-public-key --user-name "$1@colorjar.com" --ssh-public-key-id "$KeyId" --encoding SSH --query "SSHPublicKey.SSHPublicKeyBody" --output text
done
