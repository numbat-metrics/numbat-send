# numbat-send
Send a single metric to a Numbat receiver.

## Installation
```sh
npm install -g numbat-send
```

## Usage
```
Options:
  --uri, -u    URI of the collector/analyzer to send to  [default: "tcp://127.0.0.1:3333"]
  --app, -a    Application name to use  [required]
  --value, -v  Value to send  [default: 1]
  --name, -n   Name of the metric to send  [required]
  --ttl, -t    TTL of the metric
  --tag        Any tag you want to send, in `--tag "foo=bar"` form  [array]

Missing required arguments: app, name
```
