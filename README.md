# Inception Of Things

Blablah

# Architecture

## Part 1
```mermaid
flowchart TD
    subgraph VM["🖥️ Host"]
        subgraph vm11["📦 Server"]
            K3s11["☸️ k3s"]
        end
        subgraph vm12["📦 Server Worker"]
            K3s12["☸️ k3s"]
        end
    end

K3s11 <--> K3s12
```

## Part 2
```mermaid
flowchart TD
    subgraph VM["🖥️ Host"]
        client["👤"]
        subgraph vm2["📦 Server"]
            subgraph K3s2["☸️ k3s"]
                k["🪸 kuberettes"]
                subgraph app1
                    pod1["🫛"]
                end
                subgraph app2
                    pod2["🫛"]
                    pod3["🫛"]
                    pod4["🫛"]
                end
                subgraph app3
                    pod5["🫛"]
                end
            end
        end
    end
    client <--> k
    k <--> app1
    k <--> app2
    k <--> app3

```
