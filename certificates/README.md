## Managing self signed certificates 

Sometimes you're working somewhere where they decided to self-sign all certificates in order to inspect all encrypted traffic, in order to avoid virus - and so they can inspect all traffic.

This makes a bunch of tools unhappy.

### Get hold of the certificate

- Open e.g. chrome on https://google.com
- Click the padlock, navigate through all certificate settings and export this to disk. This usually results in a .cer file. 

### Convert .cer file to .pem file

Find the .cer file. Open cygwin, issue the command 

    openssl x509 -inform der -in certificate.cer -out certificate.pem

### Use self signed certificate for git

Using certificate during initial clone:


    GIT_SSL_CAINFO=C:\\Users\\username\\Downloads\\rorcz_root_cert.pem \
        git clone https://github.com/sodasmile/snips.git

Using certificate for only this repository for all later git operations

    git config http.sslCAInfo C:\\Users\\username\\Downloads\\rorcz_root_cert.pem
