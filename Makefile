all:
	docker build \
		--build-arg http_proxy=http://192.168.0.100:20172 \
		--build-arg https_proxy=http://192.168.0.100:20172 \
		-t  vim-env:base .
