kubectl create secret tls dashboard-secret-tls \
  --cert=tls/selfsigned.crt --key=tls/selfsigned.key -n kubernetes-dashboard

kubectl apply -f apps.myapp.com-gatewayapi.yaml

kubectl get pods -A | grep -E 'analytics|shopping'         # both Running

kubectl describe gateway myapp-gateway -n kubernetes-dashboard   # AttachedRoutes http=3, https=1


# launch minikube tunnel if needed


GW=$(kubectl get gateway myapp-gateway -n kubernetes-dashboard \
     -o jsonpath='{.status.addresses[0].value}')

echo "$GW  analytics.myapp.com shopping.myapp.com dashboard.myapp.com" | sudo tee -a /etc/hosts




