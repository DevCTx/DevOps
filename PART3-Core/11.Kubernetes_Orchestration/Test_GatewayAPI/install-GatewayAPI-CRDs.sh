# 1. Gateway API CRDs (creates GatewayClass / Gateway / HTTPRoute types…)
kubectl apply --server-side --force-conflicts -f \
  https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.4.1/standard-install.yaml

#2. The NGINX Gateway Fabric controller (the one that implements your GatewayClass)
kubectl apply --server-side --force-conflicts -f \
  https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v2.1.0/deploy/crds.yaml

# The controller will create the GatewayClass 
# and the the nginx-gateway namespace itself
kubectl apply --server-side --force-conflicts -f \
  https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v2.1.0/deploy/default/deploy.yaml

