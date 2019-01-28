function decrypt-file
    openssl aes-256-cbc -a -d -salt -base64 -in $argv[1] -out $argv[2]
end
