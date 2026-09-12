#!/bin/sh
# 首次开机执行：把 LAN 管理地址固定为 192.168.5.1，
# DHCP 下发 192.168.5.100-192.168.5.249（掩码 255.255.255.0）。
uci -q set network.lan.ipaddr='192.168.5.1'
uci -q set network.lan.netmask='255.255.255.0'
uci -q set dhcp.lan.start='100'
uci -q set dhcp.lan.limit='150'
uci -q set dhcp.lan.leasetime='12h'
uci -q commit network
uci -q commit dhcp
exit 0
