from __future__ import print_function, unicode_literals

import sys

from cryptography.PublicKey import RSA
from cryptography.Signature import PKCS1_v1_5
from cryptography.Hash import SHA256

def verifier(pubkey, sig, data):
    rsakey = RSA.importKey(key)
    signer = PKCS1_v1_5.new(rsakey)
    digest = SHA256.new()

    digest.update(data)
    return signer.verify(digest, sig)


with open("public.key", 'rb') as f: key = f.read()
with open("foo.tgz.sha256", 'rb') as f: sig = f.read()
with open("foo.tgz", 'rb') as f: data = f.read()

if verifier(key, sig, data):
    print("Verified OK")
else:
    print("Verification Failure")
