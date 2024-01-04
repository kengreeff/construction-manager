# README

## Credentials

```
EDITOR="code --wait" bin/rails credentials:edit --environment=production
```

## Deploy
This app is deployed to fly.io. You will need to install flyctl before using the commands below

Setup infra:

```
fly launch
```

To deploy:

```
fly ssh console --pty -C "/rails/bin/rails console"
```

To use Rails Console in production:

```
fly ssh console --pty -C "/rails/bin/rails console"
```