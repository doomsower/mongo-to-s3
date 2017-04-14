This is docker image for backing up wwguide's mongodb to s3

Usage:

```docker
  mongodbbackup:
    image: 'doomsower/mongo-to-s3'
    env_file: <env file with secret variables>
    environment:
      - <Not so secret variables> 
      - TZ=Europe/Moscow
      - CRON_TX=Europe/Moscow
      - CRON_TIME=0 0 * * *
    networks:
      - <network with mongo>
    depends_on:
      - "mongo"

```

Available variables: 

| Variable name          | Default value  | Description                                                      |
|------------------------|----------------|------------------------------------------------------------------|
| CRON_TIME              | 0 0 * * *      | Cron expression                                                  |
| TZ                     | Europe/Moscow  | Cron time zone                                                   |
| CRON_TZ                | Europe/Moscow  | Cron time zone                                                   |
| INIT_BACKUP            | true           | Make backup when container starts?                               |
| MONGODB_HOST           | mongo          | MongoDB host (make sure that containers are in the same network) |
| MONGODB_PORT           | 27017          |                                                                  |
| MONGODB_DB             |                | MongoDB database name                                            |
| S3_BUCKET              |                | S3 Bucket name                                                   |
| AWS_ACCESS_KEY_ID      |                | AWS Creadentials                                                 |
| AWS_SECRET_ACCESS_KEY  |                | AWS Creadentials                                                 |
| AWS_DEFAULT_REGION     |                | For example, `eu-west-1`                                         |
