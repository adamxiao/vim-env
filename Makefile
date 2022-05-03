all:
	docker build \
		--build-arg http_proxy=http://192.168.0.100:20172 \
		--build-arg https_proxy=http://192.168.0.100:20172 \
		-t  vim-env:base .

alpine:
	docker build -f ./Dockerfile.alpine \
		--build-arg http_proxy=http://192.168.0.100:20172 \
		--build-arg https_proxy=http://192.168.0.100:20172 \
		-t  vim-env:alpine-base .
