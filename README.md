# Inception Of Things


# Architecture

## Part 1
```mermaid
flowchart LR
    subgraph server["🖥️ caburgesS"]
        s_ip["192.168.56.110"]
        k3sS["☸️ k3s server"]
        token["📄 token"]
    end
    subgraph worker["🖥️ caburgesW"]
        w_ip["192.168.56.111"]
        k3sW["☸️ k3s worker"]
    end
    k3sS <===> k3sW
    token -.- k3sW
```
### Useful Commands
- Launch the 2 VMs: `vagrant up`
- SSH into the Server machine: `vagrant ssh caburgesS`
- SSH into the Worker machine: `vagrant ssh caburgesSW`
- Detailed info on nodes: `kubectl get nodes -o wide`
- Check network configuration: `ip a`
- Check eth1 interface: `ip a show eth1`

## Part 2
```mermaid
flowchart LR
    client["👤 client"]
    p8888[":8888\n(Browser Test)"]
    subgraph server["🖥️ caburgesS"]
        subgraph k3s["☸️ k3s server"]
            p80[":80"]
            ingress["🔀 
                     ingress
                     (by host)"]
            subgraph app_one["app-one"]
                pod1["🫛 :80"]
            end
            subgraph app_two["app-two"]
                pod2a["🫛 :80"]
                pod2b["🫛 :80"]
                pod2c["🫛 :80"]
            end
            subgraph app_three["app-three"]
                pod3["🫛 :80"]
            end
        end
    end
    p80 --- ingress
    client --- p80
    p8888 --- p80
    ingress === app_one
    ingress === app_two
    ingress === app_three
```
### Useful Commands
- Show details of everything: `kubectl get all`
- Show details of nodes: `kubectl get nodes -o wide`
- Show the Ingress: kubectl `describe ingress`
- Curl with app one as Host: `curl -H "Host: app1.com" 192.168.56.110 | grep 'app-one' `
- Curl with app two as Host: `curl -H "Host: app2.com" 192.168.56.110 | grep 'app-two'`
- Curl with no specified Host: `curl 192.168.56.110 | grep 'app-three'`

## Part 3
```mermaid
flowchart LR
    github["🐙 github.com"]

    client["👤 client"]
    subgraph docker["🐋 Docker"]
        h8080[":8080"]
        h8888[":8888"]
        subgraph k3d["☸️ k3d loadbalancer"]
            lb30001[":30001"]
            lb30000[":30000"]
            subgraph argocd_ns["namespace: argocd"]
                argocd["🐙 :8080"]
            end
            subgraph dev_ns["namespace: dev"]
                app["🫛 :8888"]
            end
        end
    end
    client --- h8080 --- lb30001 --- argocd
    client --- h8888 --- lb30000 ---- app
    github ----- argocd
    argocd --> dev_ns
```
### Useful Commands
- Show name spaces: `kubectl get ns`
- Show clusters: `k3d cluster list`
- Show pods in dev namespace: `kubectl get pods -n dev`
- Show pods in argocd namespace: `kubectl get pods -n argocd`
- Curl will app: `curl http://localhost:8888`
- Access argocd web UI: `https://localhost:8080`

## Bonus
```mermaid
flowchart LR
    client["👤 client"]
    subgraph docker["🐋 Docker"]
        h8080[":8080"]
        h8888[":8888"]
        h8081[":8081"]
        subgraph k3d["☸️ k3d loadbalancer"]
            lb30001[":30001"]
            lb30000[":30000"]
            lb30080[":30080"]
            subgraph argocd_ns["namespace: argocd"]
                argocd["🐙 :8080"]
            end
            subgraph dev_ns["namespace: dev"]
                app["🫛 :8888"]
            end
            subgraph git_ns["namespace: gitlab"]
                gitlab["🐙"]
            end
        end
    end
    client --- h8080 --- lb30001 ---- argocd
    client --- h8888 --- lb30000 ----- app
    client --- h8081 --- lb30080 --- gitlab
    argocd --> dev_ns
    gitlab --- argocd 
```
### Useful Commands
- `Helm status gitlab`
- `Helm show values`
- `Helm get manifest`
- `Helm get values`
  
# Resources
- https://docs.k3s.io/installation/configuration
- https://oneuptime.com/blog/post/2026-02-02-k3s-networking-guide/view
- https://k3d.io/stable/
- https://argo-cd.readthedocs.io/en/stable/
- https://argo-cd.readthedocs.io/en/stable/core_concepts/
- https://argo-cd.readthedocs.io/en/stable/getting_started/
- https://helm.sh/docs/intro/quickstart
- https://docs.gitlab.com/charts/
