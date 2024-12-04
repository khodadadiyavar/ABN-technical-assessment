# ABN-technical-assessment
## Technical assessment answers

#### This repository contains answers to the technical assessment from ABN-Amro.

## How to use the helm charts:

1- Clone the repository and go to the `helm` directory.
2- Execute the below command to install the chart for each service:
```bash
helm install <name-of-release> --namespace <destination-namespace> <chart-name>
```
3- You should see a message like below:
```bash
NAME: backend-api
LAST DEPLOYED: Wed Dec  4 23:03:57 2024
NAMESPACE: default
STATUS: deployed
REVISION: 1
```
4- You can configr the installation progress using the below command:
```bash
kubectl -n <namespace> get deployments
```
And you should see something like below:
```
NAME          READY   UP-TO-DATE   AVAILABLE   AGE
backend-api   1/1     1            1           5m32s
```

### How to change the helm chart

To modify the helm chart go to the relative directory and find the desired parameter in the `values.yaml` file and apply your changes. Make sure to update the chart version after applying your changes.

##### if you are changing the image tag make sure to update the `chart.yaml` file `appVersion` section.

To Monitor the status of the pods:
```bash
kubectl get pods -o wide
```

To see how much resource is being used by each node:
```
kubectl top nodes
```
Sample output:
```
NAME             CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
node1            250m         12%    512Mi           25%
node2            300m         15%    1024Mi          50%
```

To display resource utilization for pods with a specific label, such as k8s-app=kube-Devops, you can use kubectl top with a label selector:
```bash
kubectl top pods --selector=k8s-app=kube-Devops
```
Sample output:
```NAME                       CPU(cores)   MEMORY(bytes)
kube-devops-pod1           50m          128Mi
kube-devops-pod2           60m          150Mi
```
