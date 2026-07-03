# ImmortalWrt for Gemtek XR1710G

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/naoki66/ImmortalWrt-for-Gemtek-XR1710G/build-xr1710g.yml)
![GitHub last commit](https://img.shields.io/github/last-commit/naoki66/ImmortalWrt-for-Gemtek-XR1710G)
![GitHub Releases](https://img.shields.io/github/v/release/naoki66/ImmortalWrt-for-Gemtek-XR1710G)

适用于 Gemtek XR1710G / W1700K 的 ImmortalWrt 定制固件

## 🌟 固件下载

最新版本：[GitHub Releases](https://github.com/naoki66/ImmortalWrt-for-Gemtek-XR1710G/releases/latest)

| 文件 | 说明 | 大小 |
|------|------|------|
| `immortalwrt-airoha-an7581-gemtek_xr1710g-ubi-squashfs-sysupgrade.itb` | 主固件（sysupgrade） | ~82MB |
| `immortalwrt-airoha-an7581-gemtek_xr1710g-ubi-initramfs-recovery.itb` | 恢复固件（recovery） | ~71MB |

### 固件包说明

默认固件包含以下软件包：

**核心功能**
- LuCI Web 管理界面
- WiFi 7 三频支持（2.4G/5G/6G）
- MLO (Multi-Link Operation) 配置
- NPU 硬件加速支持
- DSCP offload QoS 功能
- 流量卸载优化（flow-offload + nft-offload）

**网络工具**
- WireGuard VPN
- tcpdump, mtr, iperf3
- BBR 拥塞控制

**实用工具**
- OpenClash PassWall dae 常用代理
- 风扇自动调速
- OpenSSH SFTP Server

## 📋 设备规格

| 项目 | 规格 |
|------|------|
| 型号 | Gemtek XR1710G / W1700K |
| SoC | Airoha AN7581 (ARM64) |
| CPU | ARM Cortex-A53 四核 @ 1.5GHz |
| 内存 | 2GB DDR4 |
| 闪存 | 256MB NAND (SPI-NAND) |
| WiFi | MT7996 WiFi 7 三频 (2.4G/5G/6G) |
| 网口 | 1× 10G (WAN) + 1× 10G (LAN) + 2× 1G (LAN) |
| 风扇 | NCT7802 温控风扇 |

## ✨ 功能特性

### 核心功能
- ✅ 完整的 XR1710G / W1700K 设备树支持
- ✅ WiFi 7 三频支持 (2.4G/5G/6G)，支持 MLO (Multi-Link Operation)
- ✅ 10G 万兆网口支持，基于 Airoha 以太网驱动
- ✅ NPU (Network Processing Unit) 硬件加速支持
- ✅ DSCP offload QoS 功能
- ✅ 流量卸载优化 (flow-offload + nft-offload)
- ✅ 风扇自动调速 (基于 NCT7802 温度传感器)

### 软件特性
- ✅ LuCI Web 管理界面
- ✅ IPv6 完整支持
- ✅ WireGuard VPN 支持
- ✅ 网络调试工具 (tcpdump, mtr, iperf3)
- ✅ AdGuard Home 广告过滤
- ✅ SQM 智能队列管理

### 开发特性
- ✅ GitHub Actions 自动编译
- ✅ 每日自动同步上游更新
- ✅ 内核版本 6.18

## 🔧 编译指南

### 环境要求

- Ubuntu 22.04+ / Debian 12+
- 至少 8GB 内存（建议 16GB+）
- 至少 100GB 磁盘空间（建议 200GB+）
- Git, build-essential, clang, gcc, g++, binutils, etc.

### 编译步骤

```bash
# 克隆仓库
git clone https://github.com/naoki66/ImmortalWrt-for-Gemtek-XR1710G.git
cd ImmortalWrt-for-Gemtek-XR1710G

# 更新并安装依赖
./scripts/feeds update -a
./scripts/feeds install -a

# 配置编译选项
make menuconfig

# 目标平台选择
# Target System  → Airoha
# Subtarget      → an7581
# Target Profile → Gemtek XR1710G (U-Boot layout)

# 下载源码（可选，推荐）
make download -j$(nproc)

# 开始编译
make -j$(nproc)
```

### 编译产物

编译完成后，固件位于：
```
bin/targets/airoha/an7581/
```

## 📦 安装指南

### U-Boot 方式

1. 通过 UART 进入 U-Boot
2. 将固件上传到内存
3. 刷写固件到 NAND

```bash
# 在 U-Boot 中
tftpboot 0x40000000 immortalwrt-airoha-an7581-gemtek_xr1710g-ubi-squashfs-sysupgrade.itb
nand erase.part ubi
nand write 0x40000000 ubi ${filesize}
reset
```

### Sysupgrade 方式

```bash
scp immortalwrt-airoha-an7581-gemtek_xr1710g-ubi-squashfs-sysupgrade.itb root@192.168.1.1:/tmp/
ssh root@192.168.1.1 sysupgrade /tmp/immortalwrt-airoha-an7581-gemtek_xr1710g-ubi-squashfs-sysupgrade.itb
```

### Web 升级方式

1. 登录 LuCI 管理界面
2. 进入 **系统** → **备份/升级**
3. 选择固件文件并点击 **升级**

## ⚙️ 默认配置

### 网络

- LAN: 192.168.1.1/24
- WAN: DHCP
- 网口映射: LAN2/LAN3/LAN4 为局域网，WAN 为广域网

### WiFi

| 频段 | SSID | 加密方式 | 默认密码 |
|------|------|----------|----------|
| 2.4G | W1700K(XR1710G)-2G | WPA/WPA2 | 12345678 |
| 5G | W1700K(XR1710G)-5G | WPA3 SAE | 12345678 |
| 6G | W1700K(XR1710G)-6G | WPA3 SAE | 12345678 |

> ⚠️ 首次登录后请修改默认密码和 WiFi 配置

## 🛠️ U-Boot

本仓库包含 XR1710G 专用的 U-Boot 分支作为子模块，支持 HTTP Recovery 功能。

### U-Boot 特性

- ✅ 10GbE 支持
- ✅ HTTP Recovery (网页恢复模式)
- ✅ 内置 DHCP 服务器
- ✅ 恢复页面地址: `http://192.168.255.1`

### 进入 HTTP Recovery

1. 将 PC 连接到 10GbE 网口，设置为 DHCP 自动获取
2. 上电开机
3. 10GbE 网口 LED 开始闪烁后，按住 reset 按钮
4. 状态 LED 从红色变为流动模式，表示进入恢复模式
5. 在浏览器中打开 `http://192.168.255.1`

### 编译 U-Boot

```bash
# 进入子模块
cd u-boot

# 设置交叉编译工具链
export CROSS_COMPILE=aarch64-none-linux-gnu-

# 配置 XR1710G
make xr1710g_defconfig

# 编译
make -j$(nproc)

# 生成链加载器镜像
./build-chainloader-fit.sh
```

### 刷写 U-Boot

```bash
# 将 xr1710g-chainloader-slot.bin 复制到设备 /tmp
scp out/xr1710g-chainloader-slot.bin root@192.168.1.1:/tmp/

# 在设备上刷写 chainloader 分区
flash_erase /dev/mtd2 0 8
nandwrite -p /dev/mtd2 /tmp/xr1710g-chainloader-slot.bin
sync
reboot
```

## 🔄 自动同步

本仓库配置了 GitHub Actions 自动同步上游更新：

- **每日同步**: 每天凌晨 3 点自动同步 ImmortalWrt 官方更新
- **自动编译**: 同步成功后自动触发编译
- **预发布**: 编译成功后自动发布到 GitHub Releases

## 📚 上游仓库

本仓库基于以下上游项目：

- **ImmortalWrt 官方**: [https://github.com/immortalwrt/immortalwrt](https://github.com/immortalwrt/immortalwrt)
- **YYH2913 设备源**: [https://github.com/YYH2913/openwrt](https://github.com/YYH2913/openwrt)
- **lvcdy XR1710G**: [https://github.com/lvcdy/openwrt_xr1710g](https://github.com/lvcdy/openwrt_xr1710g)
- **YYH2913 U-Boot**: [https://github.com/YYH2913/http-uboot-xr1710g](https://github.com/YYH2913/http-uboot-xr1710g)

## 🙏 特别致谢

感谢以下项目和开发者的贡献：

- [ImmortalWrt](https://github.com/immortalwrt/immortalwrt) 团队
- [YYH2913](https://github.com/YYH2913) 提供的 Airoha 驱动和设备支持
- [lvcdy](https://github.com/lvcdy) 提供的 XR1710G 优化
- [dangowrt](https://github.com/dangowrt) 提供的 Airoha 驱动基础
- 所有为 Airoha AN7581 平台贡献代码的开发者

## ⚠️ 注意事项

1. **备份数据**: 刷写固件前请备份所有重要数据
2. **硬件兼容**: 本固件仅适用于 Gemtek XR1710G / W1700K 设备
3. **风险提示**: 刷写固件可能导致设备变砖，请谨慎操作
4. **恢复模式**: 如果刷写失败，请使用 HTTP Recovery 模式恢复

## 📝 更新日志

### v20260703-pre
- 同步 ImmortalWrt 上游更新
- 更新内核到 6.18
- 添加 DSCP offload QoS 功能
- 修复编译交互提示问题
- 更新 GitHub Actions 配置

## 📄 许可证

本项目遵循 OpenWrt / ImmortalWrt 的许可证条款（GPL-2.0-or-later）。

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📮 联系方式

如有问题或建议，请通过以下方式联系：
- GitHub Issues: [提交问题](https://github.com/naoki66/ImmortalWrt-for-Gemtek-XR1710G/issues)
- Pull Requests: [提交改进](https://github.com/naoki66/ImmortalWrt-for-Gemtek-XR1710G/pulls)
