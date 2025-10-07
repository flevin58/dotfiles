source $(dirname ${BASH_SOURCE[0]})/utils.sh

goroot=$(go env GOROOT)
gocache=$(go env GOCACHE)
gopath=$(go env GOPATH)

go clean -cache

remove "$HOME/Library/Application Support/go"
remove "$goroot"
remove "$gocache"
remove "$gopath"
echo "Done"
