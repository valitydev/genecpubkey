-module(genecpubkey).

-export([main/1]).

-spec main([string()]) -> no_return().

main([PrivKeyPEMFilename, PubKeyPEMFilename]) ->
    {ok, PrivKeyPEMBin} = file:read_file(PrivKeyPEMFilename),
    [PrivKeyPEMEntry] = public_key:pem_decode(PrivKeyPEMBin),
    [PrivKeyPEMEntry] = public_key:pem_decode(PrivKeyPEMBin),
    PrivKey = public_key:pem_entry_decode(PrivKeyPEMEntry),
    {'ECPrivateKey', 1, _, ECParams, PublicKey} = PrivKey,
    PubKey = {{'ECPoint', PublicKey}, ECParams},
    PubKeyPEMEntry = public_key:pem_entry_encode('SubjectPublicKeyInfo', PubKey),
    PubKeyPEMBin = public_key:pem_encode([PubKeyPEMEntry]),
    ok = file:write_file(PubKeyPEMFilename, PubKeyPEMBin).
