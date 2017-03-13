# nm-java-app
[![Docker Repository on Quay](https://quay.io/repository/nousmotards/nm-java-app/status "Docker Repository on Quay")](https://quay.io/repository/nousmotards/nm-java-app)

Container build to run Java application on Nousmotards infra

# Build

Simply run:

```
docker build -t nm-java-app .
```

# Run

The images are accessible to quay.io:

```
docker pull quay.io/nousmotards/nm-java-app
```

You can run an image with required args like this:

```
docker run -e WGET_OPTIONS="--user=<username> --password=<password> -e URL="<main_url>" -e APP_NAME=<name_of_the_app> -e ENVIRONMENT=<prod|preprod...> -e VERSION='<app_version>' -e AWS_ACCESS_KEY='<aws_key>' -e AWS_SECRET_KEY='<aws_secret>' -e AWS_REGION='<s3_region>' -e AWS_BUCKET='<s3_bucket_name>' nm-java-app
```
