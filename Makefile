all:
	docker build \
		--build-arg http_proxy=http://proxy.iefcu.cn:20172 \
		--build-arg https_proxy=http://proxy.iefcu.cn:20172 \
		-t  vim-env:base .

alpine:
	docker build -f ./Dockerfile.alpine \
		--build-arg http_proxy=http://proxy.iefcu.cn:20172 \
		--build-arg https_proxy=http://proxy.iefcu.cn:20172 \
		-t  vim-env:alpine-base .

debian:
	docker build -f ./Dockerfile.debian \
		--build-arg http_proxy=http://proxy.iefcu.cn:20172 \
		--build-arg https_proxy=http://proxy.iefcu.cn:20172 \
		-t  vim-env:debian-base .
