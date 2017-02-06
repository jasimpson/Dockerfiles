Docker container with YAF, super_mediator, and SiLK tools from the NetSA Security Suite



## NetSA Security Suite

The [Network Situational Awareness (NetSA) Security Suite](https://tools.netsa.cert.org) is a collection of flow collection and analysis tools from the [Software Engineering Institute (SEI)](http://www.sei.cmu.edu). The NetSA tools contained in this docker are:

|Project|Description|
|-------|-----------|
|[YAF](https://tools.netsa.cert.org/yaf/index.html)|Yet Another Flow Sensor (YAF) processes packet data into bidirectional flow records that can be used as input to an IPFIX Collecting Process. YAF's output can be used with super_mediator, Pipeline 5, and the SiLK tools.|
|[super_mediator](https://tools.netsa.cert.org/super_mediator/index.html)|super_mediator is an IPFIX mediator for use with the YAF and SiLK tools. It collects and filters YAF output data to various IPFIX collecting processes and/or csv files. super_mediator can be configured to perform de-duplication of DNS resource records as exported by YAF.|
|[SiLK](https://tools.netsa.cert.org/silk/index.html)|The System for Internet Level Knowledge (SiLK) is an efficient network flow collection and storage infrastructure that will accept flow data from a variety of sensors. SiLK also provides a suite of efficient command-line tools for analysis.|


The run script includes the following use cases:

|Use Case|Projects|Commands|
|--------|--------|--------|
|PCAP to Netflow (Binary IPFIX)<sup>1</sup>|YAF|yaf|
|PCAP to Netflow (Binary IPFIX) with App Labeling<sup>2</sup>|YAF|yaf|
|PCAP to Netflow (Binary IPFIX) with App Labeling and Deep Packet Inspection (DPI)|YAF|yaf|
|PCAP to Netflow (ASCII IPFIX)|YAF|yaf + yafscii|
|PCAP to Netflow (ASCII IPFIX) with App Labeling|YAF|yaf + yafscii|
|PCAP to Netflow (ASCII IPFIX) with App Labeling and Deep Packet Inspection (DPI)<sup>3</sup>|YAF, super_mediator|yaf + super_mediator|
|PCAP to Netflow (Binary IPFIX) to Netflow (SiLK)<sup>4</sup>|YAF, SiLK|yaf + rwipfix2silk|


<sup>1</sup> The tools can be configured using command line arguments or using the corresonding `.conf` file, but not both.  
<sup>2</sup> Application labeling requires payload capture to be enabled with the `--max-payload` option. A minimum payload capture length of 384 octets is recommended for best results.  
<sup>3</sup> `super_mediator` is required to convert DPI data.  
<sup>4</sup>  In order to retain compatibility with the SiLK Tools, use `--silk` to prevent yaf from nesting TCP Information Elements.  



## Usage

Set environment variable defaults in Dockerfile:

| Key               | Value  |
| ----------------- | ------ |
| LIBFIXBUF_VERSION | 1.7.1  |
| YAF_VERSION       | 2.8.4  |
| SM_VERSION        | 1.5.0  |
| SILK_VERSION      | 3.14.0 |

Copy pcap file to processes:

A sample `test.pcap` from [http://tcpreplay.appneta.com/wiki/captures.html](http://tcpreplay.appneta.com/wiki/captures.html) is included in `/files`

Build docker image:

```
docker build -t my_docker_id/my_docker_name .
```

Run docker container:

```
docker run \
-v /path/to/Dockerfile/files:/files
-t my_docker_id/my_docker_name
```

Check output files:

The output and log files are copied to `/files`



## References

yaf Docs: [https://tools.netsa.cert.org/yaf/yaf.html](https://tools.netsa.cert.org/yaf/yaf.html)  
yafscii Docs: [https://tools.netsa.cert.org/yaf/yafscii.html](https://tools.netsa.cert.org/yaf/yafscii.html)  
yaf deep packet inspection Docs: [https://tools.netsa.cert.org/yaf/yafdpi.html](https://tools.netsa.cert.org/yaf/yafdpi.html)  
super_mediator Docs: [https://tools.netsa.cert.org/super_mediator/super_mediator.html](https://tools.netsa.cert.org/super_mediator/super_mediator.html)  
rwipfix2silk Docs: [https://tools.netsa.cert.org/silk/rwipfix2silk.html](https://tools.netsa.cert.org/silk/rwipfix2silk.html)  
