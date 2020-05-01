function encrypt-file
    openssl aes-256-cbc -a -salt -base64 -in $argv[1] -out $argv[2]

    echo use the following to decrypt:
    echo openssl aes-256-cbc -a -d -salt -base64 -in $argv[2] -out $argv[2].decrypted
end
