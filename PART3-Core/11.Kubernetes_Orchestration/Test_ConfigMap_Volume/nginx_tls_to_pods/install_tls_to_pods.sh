# # Generate TLS keys and secrets first
#
# # Certificate for the Ingress (client → Ingress)
# openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#   -keyout tls/mynginx-ingress.key \
#   -out tls/mynginx-ingress.crt \
#   -subj "/CN=mynginx.com" \
#   -addext "subjectAltName=DNS:mynginx.com"
# 
# # Certificate for Nginx (Ingress → Pod)
# openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#   -keyout tls/mynginx-backend.key \
#   -out tls/mynginx-backend.crt \
#   -subj "/CN=mynginx.svc.cluster.local"  \
#   -addext "subjectAltName=DNS:mynginx.svc.cluster.local" 

# # Secret for the Ingress
# kubectl create secret tls \
#   ingress-tls-secret \
#   --cert=tls/mynginx-ingress.crt \
#   --key=tls/mynginx-ingress.key 
# 
# # Secret pour le backend Nginx
# kubectl create secret tls \
#   backend-tls-secret \
#   --cert=tls/mynginx-backend.crt \
#   --key=tls/mynginx-backend.key

kubectl apply -f nginx-tls-configmap.yaml
kubectl apply -f nginx-tls-deployment.yaml
kubectl apply -f nginx-tls-service.yaml
kubectl apply -f mynginx-ingress.yaml
