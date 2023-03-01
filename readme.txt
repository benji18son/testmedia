# MediaWiki on Kubernetes

1) Clone repo and access directory with kubernetes files
```
git clone https://github.com/benji18son/testmedia.git
cd bena_mediawikki/mediawikki
```
2) Using helm chart we can deploy the media either manually or via terraform file.
```
```
3) Verify everything was created as expected.
```
kubectl describe deployments
```
4) Launch browser and point it to a kubernetes node followed by port ":30010". Go through mediawiki installation wizard and enter the following when prompted
```
Database host: svc-wiki-sql
Database name: wikidb
Database username: wikiuser
Database password: wikiuser
```

5) Verify services are up and running
```
kubectl get pods --namespace=kube-system
kubectl get services --namespace=kube-system
```


6) Another way of deployment of helm via Teraform

terraform plan -var “project=YOUR_PROJECT”
terraform apply -var “project=YOUR_PROJECT”


The “helm_release” resource is the resource that represents the Helm chart you want to apply. You have to reference the local file path to your Helm chart



7) CI/CD Jenkins File

Here the jenkins file which will trigger and create the docker image and push the image to gcr and deploy the chart in cluster.


The environment block sets some environment variables that will be used throughout the pipeline.
The stages block defines two stages: Build Docker image and Deploy Helm chart.
In the Build Docker image stage, a Docker image is built using the docker.build command. The image is then pushed to GCR using the docker.withRegistry command.
In the Deploy Helm chart stage, the Helm chart is deployed to the Kubernetes cluster using the helm upgrade --install command.