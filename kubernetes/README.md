# Running Earthly in Kubernetes

This is an example deployment of Earthly in Kubernetes. It uses an external `buildkitd` service to allow better isolation of the privileged pods.

This example is _not_ production ready. In a production setting, you should:

* Configure mTLS between buildkitd and earthly ([see container documentation](https://docs.earthly.dev/docs/guides/using-the-earthly-docker-images))
* Configure and log in to a Docker registry
* Ensure your Docker daemon is accessible to the earthly pod
* Mount / configure the workspace so you can get any artifacts produced out of the pod

## Dependencies

Requires [`kind`](https://kind.sigs.k8s.io/docs/user/quick-start/#installation) and [`kubectl`](https://kubernetes.io/docs/tasks/tools/) to run the automated tools. Follow their instructions for installation on your platform.

## Running The Example

Clone this repository, and then simply run `earthly ./kubernetes+start`. This will use `earthly`'s `LOCALLY` functionality to perform operations directly on your computer. This is not recommended 

## Running Multiple Buildkit Instances

Buildkit has local cache. to fully realize the benefits of `earthly`, you'll need to ensure that your connections are sticky to prevent any "roaming" builds. In addition, it could take longer for a cache to appear "warm" since each buildkit instance would need to build its own cache.
