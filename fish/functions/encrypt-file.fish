function encrypt-file
    openssl aes-256-cbc -a -salt -base64 -in $argv[1] -out $argv[2]
end
