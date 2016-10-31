#!/bin/sh
. /etc/env

for domain in `echo $DOMAINS | fold -s`
do
  domain_args="$domain_args -d $domain"
done

letsencrypt \
  --agree-tos \
  -a letsencrypt-s3front:auth \
  --letsencrypt-s3front:auth-s3-bucket $S3_BUCKET \
  --letsencrypt-s3front:auth-s3-region $S3_REGION \
  -i letsencrypt-s3front:installer \
  --letsencrypt-s3front:installer-cf-distribution-id $CF_DISTRIBUTION_ID \
  $@ $domain_args | tee -a /var/log/letsencrypt.log
