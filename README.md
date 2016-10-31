Let's Encrypt S3Front
=====================

Use the letsencrypt client to generate and install a certificate to be used with
an AWS CloudFront distribution of an S3 bucket. Runs
[dlapiduz/letsencrypt-s3front](https://github.com/dlapiduz/letsencrypt-s3front)
on the first of every month.

## Setup

Follow [this
guide](https://docs.aws.amazon.com/gettingstarted/latest/swh/website-hosting-intro.html) to use S3 and CloudFront for static site hosting. Make sure both HTTP and
HTTPS is enabled on the distribution.

You must also create an IAM user with a policy similar to [this
sample](https://github.com/dlapiduz/letsencrypt-s3front/blob/master/sample-aws-policy.json).

## Running the container

### Configuration

- `AWS_ACCESS_KEY_ID` From the IAM user **Required**
- `AWS_SECRET_ACCESS_KEY` From the IAM user **Required**
- `S3_BUCKET` The S3 bucket **Required**
- `S3_REGION` The S3 region (default: "us-east-1") **Optional**
- `CF_DISTRIBUTION_ID` The distribution id from CloudFront **Required**
- `DOMAINS` Domain names separated with a space **Required**

### Volumes

- /etc/letsencrypt
- /var/lib/letsencrypt

### Example

```
docker run --name=letsencrypt-data erlend/letsencrypt-s3front true
docker run -d \
   --name=letsencrypt \
   --volumes-from=letsencrypt-data \
   --env-file=yourconfig erlend/letsencrypt-s3front
docker exec -it letsencrypt setup
```
