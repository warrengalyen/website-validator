TAG=`git describe --tags --abbrev=0`
VERSION ?= `[ -d ".git" ] && git describe --tags --abbrev=0 || echo "0.0.0"`
LDFLAGS=-ldflags "-s -w -X main.appVersion=${VERSION}"
BINARY="website-validator"

build = echo "\n\nBuilding $(1)-$(2)" && GOOS=$(1) GOARCH=$(2) go build ${LDFLAGS} -o dist/${BINARY}_${VERSION}_$(1)_$(2) \
	&& bzip2 dist/${BINARY}_${VERSION}_$(1)_$(2) \
	&& if [ $(1) = "windows" ]; then mv dist/${BINARY}_${VERSION}_$(1)_$(2).bz2 dist/${BINARY}_${VERSION}_$(1)_$(2).exe.bz2; fi

build: *.go go.*
	go build ${LDFLAGS} -o ${BINARY}
	rm -rf /tmp/go-*

clean:
	rm -f ${BINARY}

release:
	mkdir -p dist
	rm -f dist/${BINARY}_${VERSION}_*
	$(call build,linux,amd64)
	$(call build,linux,386)
	$(call build,linux,arm)
	$(call build,linux,arm64)
	$(call build,darwin,amd64)
	$(call build,windows,amd64)