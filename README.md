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
4- You can confirm the installation progress using the below command:
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
```bash
NAME                           CPU(cores)   MEMORY(bytes)
backend-api-54d86f48d9-7rjcx   8m           86Mi
data-api-6d678f9d78-tmh5z      32m          48Mi
```

### Secret management

The backend_api app connects to an external API, and for that it uses an API key. The best way to store these keys is to use a Secret Manager service that integrates with Kubernetes. I suggest using AWS secrets manager as it support automatic secret rotation and update.

### Healthcheck

You can find a script to check the status of the backend API in the new infrastructure. Although I beleive the way I implemented it you won't be needing such script. The helm chart deploys a deployment that has a K8s readiness check and a liveness check which can be traked via the K8s API or any alert mnaagement system.
I also included the manifest of a pod that automatically checks the health of the backend API and prints the status to the output, this also ca be traked and logged using apporopraite logging tools. The pod also can be used as a cron job so it does not run all the time if you're looking for a scheduled health check.

### Ansible playbook

This repo also includes an Ansible play bood that makes sure that the `helm` binary is available, and deploys the helm charts.
