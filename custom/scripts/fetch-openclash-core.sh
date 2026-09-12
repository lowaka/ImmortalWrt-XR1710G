#!/bin/sh
# 编译时把当时最新版的 OpenClash(mihomo) 内核打进固件，路由器上就不用再联网下载内核。
# 产物：files/etc/openclash/core/clash_meta（XR1710G 为 aarch64）
set -e

CORE_DIR="files/etc/openclash/core"
mkdir -p "$CORE_DIR"

URLS="
https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz
https://cdn.jsdelivr.net/gh/vernesong/OpenClash@core/meta/clash-linux-arm64.tar.gz
https://ghfast.top/https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz
https://gh-proxy.com/https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz
"

ok=0
for url in $URLS; do
  echo "== 下载 OpenClash 内核: $url"
  rm -f /tmp/clash /tmp/clash-meta.tar.gz
  if curl -fsSL --retry 3 --connect-timeout 20 -o /tmp/clash-meta.tar.gz "$url" \
     && tar -xzf /tmp/clash-meta.tar.gz -C /tmp \
     && [ -s /tmp/clash ]; then
    ok=1
    break
  fi
done

if [ "$ok" != "1" ]; then
  echo "::error::OpenClash 内核下载失败，请检查网络或更换镜像源" >&2
  exit 1
fi

install -m 0755 /tmp/clash "$CORE_DIR/clash_meta"
test -s "$CORE_DIR/clash_meta"
echo "OpenClash 内核已打包: $(ls -l "$CORE_DIR/clash_meta")"
