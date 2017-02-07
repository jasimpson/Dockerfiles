#!/bin/bash



echo "pcap to ipfix"
# Refer to the documentation for arguments
# https://tools.netsa.cert.org/yaf/yaf.html
yaf \
--in /files/test.pcap --out /files/pcap2ipfix.yaf \
--log /files/pcap2ipfix.log --verbose
echo



echo "pcap to ipfix with app labeling"
# Refer to the documentation for arguments
# https://tools.netsa.cert.org/yaf/yaf.html
yaf \
--in /files/test.pcap --out /files/pcap2ipfix-applabel.yaf \
--applabel --max-payload=1500 \
--log /files/pcap2ipfix-applabel.log --verbose
echo



echo "pcap to ipfix with app labeling and deep packet inspection"
# Refer to the documentation for arguments
# https://tools.netsa.cert.org/yaf/yaf.html
# https://tools.netsa.cert.org/yaf/yafdpi.html
yaf \
--in /files/test.pcap --out /files/pcap2ipfix-applabel-dpi.yaf \
--applabel --max-payload=1500 \
--plugin-name=/usr/local/lib/yaf/dpacketplugin.la \
--log /files/pcap2ipfix-applabel-dpi.log --verbose
echo



echo "pcap to ipfix with app labeling to ascii using yafscii"
# Refer to the documentation for arguments
# https://tools.netsa.cert.org/yaf/yaf.html
# https://tools.netsa.cert.org/yaf/yafscii.html
yaf \
--in /files/test.pcap \
--applabel --max-payload=1500 \
| \
yafscii \
--out /files/pcap2ipfix-applabel-yafscii.psv \
--tabular --print-header \
--log /files/pcap2ipfix-applabel-yafscii.log --verbose
echo



echo "pcap to ipfix with app labeling and deep packet inspection to ascii using super mediator"
# Refer to the documentation for arguments
# https://tools.netsa.cert.org/yaf/yaf.html
# https://tools.netsa.cert.org/yaf/yafdpi.html
# https://tools.netsa.cert.org/super_mediator/super_mediator.html
yaf \
--in /files/test.pcap \
--applabel --max-payload=1500 \
--plugin-name=/usr/local/lib/yaf/dpacketplugin.la \
--flow-stats \
--entropy \
| \
super_mediator \
-c /files/dpi_multi_file_extra_fields.conf \
--out /files/pcap2ipfix-applabel-dpi-sm.psv \
--output-mode text --print-headers \
--log /files/pcap2ipfix-applabel-dpi-sm.log --verbose
echo



echo "pcap to ipfix to silk using rwipfix2silk"
# Refer to the documentation for arguments
# https://tools.netsa.cert.org/yaf/yaf.html
# https://tools.netsa.cert.org/silk/rwipfix2silk.html
yaf \
--in /files/test.pcap \
--applabel --max-payload=1500 \
--silk \
| \
rwipfix2silk \
--silk-output=/files/pcap2ipfix-applabel-silk.rw \
--interface-values=vlan \
--log-destination /files/pcap2ipfix-applabel-silk.log --log-flags=all
echo
