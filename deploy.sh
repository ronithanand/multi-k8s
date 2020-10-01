docker build -t ronithanand/multi-client:latest -t ronithanand/multi-client:$SHA -f ./client /Dockerfile ./client
docker build -t ronithanand/multi-server:latest -t ronithanand/multi-server:$SHA  -f ./server /Dockerfile ./server
docker build -t ronithanand/multi-worker:latest -t ronithanand/multi-worker:$SHA -f ./worker /Dockerfile ./worker
docker push ronithanand/multi-client:latest
docker push ronithanand/multi-server:latest
docker push ronithanand/multi-worker:latest
docker push ronithanand/multi-client:$SHA
docker push ronithanand/multi-server:$SHA
docker push ronithanand/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ronithanand/multi-server:$SHA
kubectl set image deployments/client-deployment server=ronithanand/multi-client:$SHA
kubectl set image deployments/worker-deployment server=ronithanand/multi-worker:$SHA
