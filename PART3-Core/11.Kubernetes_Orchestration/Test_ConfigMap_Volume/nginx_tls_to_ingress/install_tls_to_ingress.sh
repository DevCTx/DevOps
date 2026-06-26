# # Generate TLS keys and secret first
# openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#   -keyout tls/mynginx.key \
#   -out tls/mynginx.crt \
#   -subj "/CN=mynginx.com" \
#   -addext "subjectAltName=DNS:mynginx.com"

# kubectl create secret tls \
#   mynginx-tls-secret \
#   --cert=tls/mynginx.crt \
#   --key=tls/mynginx.key

kubectl apply -f nginx-http-deployment.yaml
kubectl apply -f nginx-http-service.yaml
kubectl apply -f mynginx-ingress.yaml
