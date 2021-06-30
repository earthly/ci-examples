# Running Earthly in Kubernetes

This is an example ddeployment of Earthly in Kubernetes. It uses an external `buildkitd` service to allow better isolation of the privileged pods.

This example is _not_ production ready. In a production setting, you should:

* Configure mTLS between buildkitd and earthly ([see container documentation](https://docs.earthly.dev/docs/guides/using-the-earthly-docker-images))
* Configure and log in to a Docker registry
* Ensure your Docker daemon is accessible to the earthly pod
* Mount / configure the workspace so you can get any artifacts produced out of the pod
