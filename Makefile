# -----------------------------------------------------------------------------
# Define Commands
# -----------------------------------------------------------------------------

clean: # Removes deployed resources from the target cluster
	@kubectl delete -k ./config/local 2> /dev/null  || true

build: # Build all components as production ready assets
	@docker build --target prod -t project/test:latest .
	@helm dep update ./helm/project

deploy: # Deploy all assets to the kubernetes cluster
	@kubectl apply -k ./config/local/
	@helm upgrade --install -n $(shell make deploy/namespace) -f ./config/local/values.yaml $(USER) helm/project

deploy/namespace: # Runs the solution locally using pm2
	@cat ./config/local/kustomization.yaml | yq e '.namespace' -



