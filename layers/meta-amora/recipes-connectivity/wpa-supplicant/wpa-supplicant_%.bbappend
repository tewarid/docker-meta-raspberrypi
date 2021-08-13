FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://wpa-supplicant-service.patch"
SYSTEMD_AUTO_ENABLE = "enable"
