# GLOO PLATFORM PROVISIONING

## Background
This project was designed to reduce the number of manual steps for installing Gloo Platform.

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

* create gitops dependency between clusters
* generate license
* input portal
* output portal
* select gloo mesh version
* swap out digitalocean dns with dns matching provider
