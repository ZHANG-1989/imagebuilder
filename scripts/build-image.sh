#!/usr/bin/env bash
set -euo pipefail

VERSION="${VERSION:-25.12-SNAPSHOT}"
TARGET="${TARGET:-x86/64}"
PROFILE="${PROFILE:-generic}"
IMAGEBUILDER_URL="${IMAGEBUILDER_URL:-https://downloads.immortalwrt.org/releases/25.12-SNAPSHOT/targets/x86/64/immortalwrt-imagebuilder-25.12-SNAPSHOT-x86-64.Linux-x86_64.tar.zst}"
EXTRA_IMAGE_NAME="${EXTRA_IMAGE_NAME:-daede}"
OUT_DIR="${OUT_DIR:-$PWD/out}"
PREFLIGHT="${PREFLIGHT:-1}"
ROOTFS_PARTSIZE="${ROOTFS_PARTSIZE:-1024}"
INSTALL_DAEDE="${INSTALL_DAEDE:-1}"
DAEDE_REPO="${DAEDE_REPO:-kenzok8/openwrt-daede}"
DAEDE_RELEASE_TAG="${DAEDE_RELEASE_TAG:-latest}"
DAEDE_ARCH="${DAEDE_ARCH:-x86_64}"
DAEDE_APK_URL="${DAEDE_APK_URL:-}"

#EXTRA_PACKAGES="${EXTRA_PACKAGES:-luci luci-i18n-base-zh-cn luci-i18n-package-manager-zh-cn luci-app-daede kmod-sched-core kmod-sched-bpf kmod-veth kmod-xdp-sockets-diag curl nano}"
EXTRA_PACKAGES="${EXTRA_PACKAGES:-apk-openssl attendedsysupgrade-common autocore automount base-files block-mount busybox ca-bundle cgi-io dae dae-geoip dae-geosite daed daed-geoip daed-geosite default-settings default-settings-chn dnsmasq-full dropbear e100-firmware e2fsprogs ethtool fdisk firewall4 fstools fwtool getrandom grub2 grub2-bios-setup grub2-efi hostapd hostapd-common i915-firmware-dmc ip-tiny ip6tables-nft ipset iptables-mod-conntrack-extra iptables-mod-ipopt iptables-nft iw jansson4 jshn jsonfilter kernel kmod-3c59x kmod-8139cp kmod-8139too kmod-acpi-video kmod-ath kmod-ath9k kmod-ath9k-common kmod-backlight kmod-button-hotplug kmod-cfg80211 kmod-crypto-aead kmod-crypto-arc4 kmod-crypto-ccm kmod-crypto-cmac kmod-crypto-crc32 kmod-crypto-crc32c kmod-crypto-ctr kmod-crypto-ecb kmod-crypto-gcm kmod-crypto-geniv kmod-crypto-gf128 kmod-crypto-ghash kmod-crypto-hash kmod-crypto-hmac kmod-crypto-manager kmod-crypto-null kmod-crypto-rng kmod-crypto-seqiv kmod-crypto-sha1 kmod-crypto-sha3 kmod-crypto-sha512 kmod-crypto-user kmod-dma-buf kmod-drm kmod-drm-buddy kmod-drm-display-helper kmod-drm-exec kmod-drm-i915 kmod-drm-kms-helper kmod-drm-suballoc-helper kmod-drm-ttm kmod-drm-ttm-helper kmod-e100 kmod-e1000 kmod-e1000e kmod-fb kmod-fb-cfb-copyarea kmod-fb-cfb-fillrect kmod-fb-cfb-imgblt kmod-fb-sys-fops kmod-fb-sys-ram kmod-forcedeth kmod-fs-exfat kmod-fs-ext4 kmod-fs-f2fs kmod-fs-ntfs3 kmod-fs-vfat kmod-hid kmod-hid-generic kmod-hwmon-core kmod-i2c-algo-bit kmod-i2c-core kmod-i40e kmod-igb kmod-igbvf kmod-igc kmod-input-core kmod-input-evdev kmod-ip6tables kmod-ipt-conntrack kmod-ipt-conntrack-extra kmod-ipt-core kmod-ipt-ipopt kmod-ipt-ipset kmod-ixgbe kmod-ixgbevf kmod-lib-crc-ccitt kmod-lib-crc16 kmod-lib-crc32c kmod-libeth kmod-libie kmod-libphy kmod-mac80211 kmod-macvlan kmod-mdio kmod-mdio-devres kmod-mii kmod-mppe kmod-natsemi kmod-ne2k-pci kmod-net-selftests kmod-nf-conncount kmod-nf-conntrack kmod-nf-conntrack-netlink kmod-nf-conntrack6 kmod-nf-flow kmod-nf-ipt kmod-nf-ipt6 kmod-nf-log kmod-nf-log6 kmod-nf-nat kmod-nf-nathelper kmod-nf-reject kmod-nf-reject6 kmod-nf-tproxy kmod-nfnetlink kmod-nft-compat kmod-nft-core kmod-nft-fib kmod-nft-fullcone kmod-nft-nat kmod-nft-offload kmod-nft-tproxy kmod-nls-base kmod-nls-cp437 kmod-nls-iso8859-1 kmod-nls-utf8 kmod-pcnet32 kmod-phy-ax88796b kmod-phylink kmod-ppp kmod-pppoe kmod-pppox kmod-pps kmod-ptp kmod-r8101 kmod-r8125 kmod-r8126 kmod-r8168 kmod-random-core kmod-sched-bpf kmod-sched-core kmod-scsi-core kmod-sis900 kmod-slhc kmod-tg3 kmod-tulip kmod-usb-common kmod-usb-core kmod-usb-hid kmod-usb-net kmod-usb-net-asix kmod-usb-net-asix-ax88179 kmod-usb-net-rtl8150 kmod-usb-net-rtl8152-vendor kmod-usb-storage kmod-usb-storage-extras kmod-usb-storage-uas kmod-veth kmod-via-rhine kmod-via-velocity kmod-vmxnet3 kmod-xdp-sockets-diag libblkid1 libblobmsg-json20260213 libc libcap libcomerr0 libe2p2 libext2fs2 libf2fs6 libfdisk1 libgcc1 libgmp10 libipset13 libiptext-nft0 libiptext0 libiptext6-0 libiwinfo-data libiwinfo20230701 libjson-c5 libjson-script20260213 liblua5.1.5 liblucihttp-lua liblucihttp-ucode liblucihttp0 libmnl0 libncurses6 libnetfilter-conntrack3 libnettle8 libnfnetlink0 libnftnl11 libnl-tiny1 libopenssl3 libpthread librt libsensors5 libsmartcols1 libss2 libsysfs2 libubox20260213 libubus-lua libubus20251202 libuci20250120 libuclient20201210 libucode20230711 libudebug libustream-openssl20201210 libuuid1 libuv1 libwebsockets-full libxtables12 lm-sensors logd lua luci luci-app-attendedsysupgrade  luci-app-firewall luci-app-mwan3 luci-app-package-manager luci-app-ttyd luci-app-v2raya luci-base luci-compat luci-i18n-attendedsysupgrade-zh-cn luci-i18n-base-zh-cn luci-i18n-firewall-zh-cn luci-i18n-mwan3-zh-cn luci-i18n-package-manager-zh-cn luci-i18n-ttyd-zh-cn luci-i18n-v2raya-zh-cn luci-lib-base luci-lib-ip luci-lib-jsonc luci-lib-nixio luci-lib-uqr luci-light luci-lua-runtime luci-mod-admin-full luci-mod-network luci-mod-status luci-mod-system luci-proto-ipv6 luci-proto-ppp luci-theme-bootstrap mkf2fs mtd mwan3 netifd nftables-json ntfs3-mount odhcp6c odhcpd-ipv6only openwrt-keyring owut partx-utils ppp ppp-mod-pppoe procd procd-seccomp procd-ujail rpcd rpcd-mod-file rpcd-mod-iwinfo rpcd-mod-luci rpcd-mod-rpcsys rpcd-mod-rrdns rpcd-mod-ucode shellsync sysfsutils terminfo ttyd ubox ubus ubusd uci uclient-fetch ucode ucode-mod-digest ucode-mod-fs ucode-mod-html ucode-mod-log ucode-mod-lua ucode-mod-math ucode-mod-nl80211 ucode-mod-rtnl ucode-mod-ubus ucode-mod-uci ucode-mod-uclient ucode-mod-uloop uhttpd uhttpd-mod-ubus urandom-seed urngd usign v2ray-geoip v2ray-geosite v2raya wifi-scripts wireless-regdb wpa-supplicant xray-core xtables-nft zlib zoneinfo-asia zoneinfo-core luci-app-daede curl nano   }"
WORK_DIR="${WORK_DIR:-$PWD/work}"
IB_ARCHIVE="$WORK_DIR/imagebuilder.tar.zst"

mkdir -p "$WORK_DIR" "$OUT_DIR"

resolve_daede_apk_url() {
  if [ -n "$DAEDE_APK_URL" ]; then
    printf '%s\n' "$DAEDE_APK_URL"
    return
  fi

  local release_api
  if [ "$DAEDE_RELEASE_TAG" = "latest" ]; then
    release_api="https://api.github.com/repos/$DAEDE_REPO/releases/latest"
  else
    release_api="https://api.github.com/repos/$DAEDE_REPO/releases/tags/$DAEDE_RELEASE_TAG"
  fi

  python3 - "$release_api" "$DAEDE_ARCH" <<'PY'
import json
import os
import sys
import urllib.request

release_api, arch = sys.argv[1:3]
request = urllib.request.Request(
    release_api,
    headers={
        "Accept": "application/vnd.github+json",
        "User-Agent": "kenzok8-imagebuilder",
    },
)
token = os.environ.get("GITHUB_TOKEN")
if token:
    request.add_header("Authorization", f"Bearer {token}")

with urllib.request.urlopen(request, timeout=30) as response:
    release = json.load(response)

suffix = f"-{arch}.apk"
matches = [
    asset.get("browser_download_url") or asset.get("url")
    for asset in release.get("assets", [])
    if asset.get("name", "").startswith("luci-app-daede-")
    and asset.get("name", "").endswith(suffix)
]

if not matches:
    tag = release.get("tag_name", release_api)
    raise SystemExit(f"luci-app-daede APK for {arch} not found in {tag}")

print(matches[0])
PY
}

install_daede_apk() {
  case "$INSTALL_DAEDE" in
    1|true|yes) ;;
    *)
      echo "Skipping luci-app-daede release APK download."
      return
      ;;
  esac

  local packages_dir="$WORK_DIR/imagebuilder/packages"
  local daede_url
  daede_url="$(resolve_daede_apk_url)"
  mkdir -p "$packages_dir"

  # Strip the -<arch> suffix from the release filename. apk mkndx indexes the
  # package under its canonical name-version.apk; if the file keeps the
  # -x86_64 suffix the index entry points to a missing file and the build
  # fails with "package mentioned in index not found".
  local fname="${daede_url##*/}"
  fname="${fname%-${DAEDE_ARCH}.apk}.apk"

  echo "Downloading luci-app-daede APK: $daede_url -> $fname"
  curl -L --retry 8 --retry-delay 5 --connect-timeout 30 \
    -o "$packages_dir/$fname" "$daede_url"
}

if [ ! -s "$IB_ARCHIVE" ]; then
  curl -L --retry 8 --retry-delay 5 --connect-timeout 30 \
    -o "$IB_ARCHIVE" "$IMAGEBUILDER_URL"
fi

rm -rf "$WORK_DIR/imagebuilder"
mkdir -p "$WORK_DIR/imagebuilder"
tar --use-compress-program=unzstd -xf "$IB_ARCHIVE" -C "$WORK_DIR/imagebuilder" --strip-components=1

cp -a files "$WORK_DIR/imagebuilder/files"
install_daede_apk

cd "$WORK_DIR/imagebuilder"

echo "Version: $VERSION"
echo "Target: $TARGET"
echo "Profile: $PROFILE"
echo "Rootfs part size: ${ROOTFS_PARTSIZE}MB"
echo "Extra packages: $EXTRA_PACKAGES"
echo "Install daede APK: $INSTALL_DAEDE"
echo "Daede release: $DAEDE_REPO@$DAEDE_RELEASE_TAG ($DAEDE_ARCH)"
mkdir -p "$OUT_DIR"
echo "extra_packages=$EXTRA_PACKAGES" > "$OUT_DIR/.extra_packages"

diagnose_failure() {
  cat >&2 <<'EOF'

ImageBuilder failed.

Common causes for this daede image:
- The selected ImmortalWrt snapshot ImageBuilder and package feeds are out of sync.
  Example: base packages require a newer libubox/libblobmsg-json than the public feed provides.
- luci-app-daede or one of the dae/daed eBPF dependencies
  (kmod-sched-bpf / kmod-veth / kmod-xdp-sockets-diag)
  is missing from the selected target's kmod feed for the current kernel version.
- The luci-app-daede release APK was not copied into the local ImageBuilder packages
  directory, or its architecture does not match the selected target.

About BTF (no longer a blocker on 25.12):
- ImmortalWrt 25.12 kernels enable CONFIG_DEBUG_INFO_BTF by default. dae/daed reads BTF
  directly from /sys/kernel/btf/vmlinux at runtime and does NOT require a separate
  vmlinux-btf package. Do not add vmlinux-btf to EXTRA_PACKAGES — it is not published
  in the feed and ImageBuilder cannot build it.
- If you ever target an older OpenWrt release whose kernel lacks built-in BTF, build
  vmlinux-btf via a full SDK build first (ImageBuilder cannot compile packages).

Next choices:
- Retry later with the same 25.12-SNAPSHOT URL after ImmortalWrt feeds finish syncing.
- Use a release/rc ImageBuilder URL and rebuild daede/dae/daed APKs against that release/rc.
- Override DAEDE_RELEASE_TAG, DAEDE_ARCH, or DAEDE_APK_URL if you need a specific
  luci-app-daede release asset.
- Verify kmod-* packages exist for the target+kernel combo via:
    make manifest PROFILE="$PROFILE" PACKAGES="$EXTRA_PACKAGES"
EOF
}

if [ "$PREFLIGHT" = "1" ] || [ "$PREFLIGHT" = "true" ]; then
  echo "Running package manifest preflight..."
  if ! make manifest PROFILE="$PROFILE" PACKAGES="$EXTRA_PACKAGES"; then
    diagnose_failure
    exit 1
  fi
fi

# Slim image formats: keep only squashfs EFI img.gz + qcow2 + vmdk
sed -i \
  -e 's/^CONFIG_TARGET_ROOTFS_EXT4FS=y/# CONFIG_TARGET_ROOTFS_EXT4FS is not set/' \
  -e 's/^CONFIG_TARGET_ROOTFS_TARGZ=y/# CONFIG_TARGET_ROOTFS_TARGZ is not set/' \
  -e 's/^CONFIG_VDI_IMAGES=y/# CONFIG_VDI_IMAGES is not set/' \
  -e 's/^CONFIG_VHDX_IMAGES=y/# CONFIG_VHDX_IMAGES is not set/' \
  -e 's/^CONFIG_ISO_IMAGES=y/# CONFIG_ISO_IMAGES is not set/' \
  -e 's/^CONFIG_GRUB_IMAGES=y/# CONFIG_GRUB_IMAGES is not set/' \
  .config

if ! make image \
    PROFILE="$PROFILE" \
    PACKAGES="$EXTRA_PACKAGES" \
    FILES=files \
    BIN_DIR="$OUT_DIR" \
    EXTRA_IMAGE_NAME="$EXTRA_IMAGE_NAME" \
    ROOTFS_PARTSIZE="$ROOTFS_PARTSIZE"; then
  diagnose_failure
  exit 1
fi

# Rename to short friendly names — the immortalwrt prefix is too long for GitHub UI
	cd "$OUT_DIR"
	for f in *-squashfs-combined-efi.img.gz;  do [ -f "$f" ] && mv "$f" daede-squashfs-efi.img.gz;  done
	for f in *-squashfs-combined-efi.qcow2; do [ -f "$f" ] && mv "$f" daede-squashfs-efi.qcow2; done
	for f in *-squashfs-combined-efi.vmdk;  do [ -f "$f" ] && mv "$f" daede-squashfs-efi.vmdk;  done
	for f in *-kernel.bin;                do [ -f "$f" ] && mv "$f" daede-kernel.bin;            done
	for f in *-rootfs.tar.gz;             do [ -f "$f" ] && mv "$f" daede-rootfs.tar.gz;         done
	for f in *.manifest;                  do [ -f "$f" ] && mv "$f" daede.manifest;              done
	for f in *.bom.cdx.json;              do [ -f "$f" ] && mv "$f" daede.bom.cdx.json;          done
	for f in *.img.gz *.qcow2 *.vmdk *.bin *.tar.gz *.manifest *.bom.cdx.json; do
	  [ -f "$f" ] || continue
	  sha256sum "$f"
	done > sha256sums
	# Build date in CST for release notes
	BUILD_DATE="$(TZ='Asia/Shanghai' date '+%F %H:%M CST')"
	cat > BUILD-MANIFEST.txt <<BODYEOF
## daede 固件 · ${EXTRA_IMAGE_NAME}

基于 ImmortalWrt 25.12-SNAPSHOT，x86-64 通用镜像，squashfs-only。

### 推荐下载

| 格式 | 适用场景 | 文件 |
|------|----------|------|
| **img.gz** | 物理机 dd 写盘 / PVE 导入 | daede-squashfs-efi.img.gz |
| **qcow2** | QEMU / Proxmox VE | daede-squashfs-efi.qcow2 |
| **vmdk** | VMware ESXi / Workstation | daede-squashfs-efi.vmdk |

> 额外：`daede-rootfs.tar.gz` 裸文件系统，可用于 LXC 容器转换。

### 镜像详情

- **系统类型**：squashfs（只读根 + overlay 可写层，抗断电）
- **分区**：combined（含分区表 + 引导，直接 dd）
- **启动**：EFI
- **根分区大小**：${ROOTFS_PARTSIZE} MB
- **构建日期**：${BUILD_DATE}
- **ImageBuilder**：${IMAGEBUILDER_URL}

### 预装软件

\`$(cat "$OUT_DIR/.extra_packages" 2>/dev/null || echo "$EXTRA_PACKAGES")\`

### 校验

\`\`\`bash
sha256sum -c sha256sums --ignore-missing
\`\`\`
BODYEOF
	ls -la "$OUT_DIR"
