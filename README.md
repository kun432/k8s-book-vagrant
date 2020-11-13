# k8s-book-vagrant

## Prerequisite

- Vagrant
- Virtualbox
- Virutalbox Extension Pack
- vagrant-vbguset (Vagrant Pluguin) 

## Usage

`vagrant up` will create a cluster with 1 master / 2 workers.

```
$ vagrant up
```

On master, kubeconfig has been set for user vagrant.

```
$ vagrant ssh master
```

```
$ kubectl get node
NAME       STATUS   ROLES    AGE   VERSION
master     Ready    master   36m   v1.18.0
worker-1   Ready    <none>   30m   v1.18.0
worker-2   Ready    <none>   24m   v1.18.0
```
