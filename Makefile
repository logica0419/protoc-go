.PHONY: build-%
build-%:
	docker build -t logica0419/protoc-go:${@:build-%=%} . --no-cache

,PHONY: push-%
push-%:
	docker push logica0419/protoc-go:${@:push-%=%}
