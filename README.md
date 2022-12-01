# GLOO PLATFORM PROVISIONING

## Background
Rebuilding client environments is cumbersome without automation. I used what I had already to automate the install process of a multi-cluster setup into a single helm chart. The automation currently uses Rancher heavily, but could/should be swapped with clusterapi or crossplane. I would **not** recommend this for production as is.

## Required Components
* Management Server with:
  * kube-janitor (cluster scoped alpha)
  * rancher (current)
  * fleet (go template alpha)
* DigitalOcean Domain (currently skrzypek.us)
* AWS Credentials (for parameter store)
* Gloo Mesh License (currently static)
* Corresponding GitRepos

## Input

```
helm install {{releasename}} ./infra/rancher-clusters \
                --set global.provider={{eks/gke/aks}} \
                --set global.client={{clientname}}
```

## Automation

![Diagram](/_assets/automation.svg)

### Phase 1: 

* Provision Infrastructure
  * Create 1 Management Server
  * Create X Agent Servers

### Phase 2:

* Shared Resources
  * Gloo Mesh CRDS
  * External Secrets Operator 
* Manager
  * External DNS
* Agents
  * External Secrets Pull Secrets

### Phase 3:

* Manager
  * Gloo Mesh Enterprise 
* Agents 
  * Gloo Mesh Agent

### Phase 4:

* Manager
  * KubernetesCluster(s)
  * IstioLifecycle Manager
  * GatewayLifecycle Manager(s)
  * External Secrets Push 
  * Istio Workspace
  * Istio WorkspaceSettings
  * RootTrustPolicy


## TODO

* swap builtin ca with letsencrypt
* create gitops dependency between clusters
* sealed-secrets on infra cluster
* generate license
* input portal
* output portal
* select gloo mesh version
* swap out rancher with clusterapi or crossplane
* swap out digitalocean dns with dns matching provider
* switch external secrets provider
