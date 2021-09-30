# Pull-Through Cache

This is an example of how you might configure and use a pull-through cache to augment your Earthly CI builds. There are a couple parts within this folder, some of which are meant for illustration only. If you need additional help configuring a pull-through cache with 

## `terraform` Folder

This contains a modified version of the Terraform module we use to deploy pull-through caches in Digital Ocean. It's probably not usable for you as-is, but with some tweaking you can make it your own.

## `+updated-registry`

This target provides an up-to-date version of `registry:2`, if you need it.

## Running The Demo 

### `+local-pull-through`

This target sets up and runs a local pull through cache. It _should_ be usable against any repository; it's been tested successfully against `registry-1.docker.io` and `ghcr.io`. Though, Docker Hub is hard coded and will require you to manually edit the `Earthfile` (the setting for buildkit) and `config-template.yaml` (the proxy URL). Its also possible to omit the username and password to mirror a public repository.

It will make modifications to your Earthly configuration, and requires restarting the daemon. Back up your config file if you are worried about loosing settings.

You can run it like this to proxy Docker Hub out of the box:

```shell
earthly --secret REPO_USER=user \
        --secret REPO_PASSWORD=docker_token \
        +pull-through
```

### `+pull-through-clean`

This cleans up the changes it made to your system. It:

* Deletes the cache docker container
* Deletes the generated config file
* Deletes the generated proxy auth file
* Resets the config changes made to your Earthly config

### `+pull-through-stats`

This prints the debug cache stats from the cache's debug endpoint.