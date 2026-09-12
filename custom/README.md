# custom/ 定制目录说明

本仓库是 `naoki66/ImmortalWrt-for-Gemtek-XR1710G` 的 fork，所有“个性化修改”都放在这个目录，
上游（naoki66 + immortalwrt）更新时不会被覆盖。

| 文件 | 作用 |
| --- | --- |
| `config.fragment` | 插件开关（编译前追加到 `.config`，可增删要编译的插件） |
| `feeds.conf.custom` | 额外 feed（OpenClash 官方源，编译时拉取最新版） |
| `scripts/fetch-openclash-core.sh` | 编译时下载最新 mihomo 内核，打包进固件 `/etc/openclash/core/clash_meta` |
| `files/` | 固件文件覆盖层（目前用于首次开机把后台地址设为 `192.168.5.1`、DHCP 下发 `192.168.5.100-249`） |

## 常用操作

- **增/减插件**：改 `custom/config.fragment`，然后手动运行 `Build XR1710G Firmware`。
- **改后台地址**：改 `custom/files/etc/uci-defaults/99-custom-network.sh`（只在首次开机或刷机后首次启动生效）。
- **同步上游**：运行 `Sync Upstream (naoki66 + ImmortalWrt)`，会自动合并并触发一次构建 + 发布 Release。

## 注意事项

- `.gitattributes` 里把 `.github/workflows/build-firmware.yml` 标记为 `merge=keep-ours`：
  同步上游时如果该文件冲突，会保留本仓库版本（因为里面含定制 hook）。上游 workflow 有大改动时，
  需要手动把新特性合并进来。
- `config.seed` 不设保护，保持跟随 naoki66 上游更新；本仓库的插件开关一律写在 `custom/config.fragment`。
