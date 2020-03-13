From: Florian Walbroel via lttng-dev <lttng-dev@lists.lttng.org>
Subject: [PATCH lttng-modules] Add UDP and ICMP packet header
 information to the tracepoint:
Date: Fri, 13 Mar 2020 12:32:47 +0100
Message-ID: <a7d8d1aa-7f7b-371e-ceda-2f7243e21077@silexica.com>
Reply-To: Florian Walbroel <walbroel@silexica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by lists.lttng.org (Postfix) with ESMTPS id 48f3Tb3BC2z1J3w
 for <lttng-dev@lists.lttng.org>; Fri, 13 Mar 2020 07:32:51 -0400 (EDT)
Received: by mail-wm1-x343.google.com with SMTP id 25so9541779wmk.3
 for <lttng-dev@lists.lttng.org>; Fri, 13 Mar 2020 04:32:51 -0700 (PDT)
Received: from [10.251.251.128] ([213.168.66.154])
 by smtp.gmail.com with ESMTPSA id k126sm16580334wme.4.2020.03.13.04.32.48
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2020 04:32:48 -0700 (PDT)
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* UDP transport header
* ICMP transport header

(Correct indentation for switch/case)
(Fix white space for switch and correct struct type (icmphdr))

Signed-off-by: Florian Walbroel <walbroel@silexica.com>
---
  instrumentation/events/lttng-module/net.h | 166 ++++++++++++++++++++--
  1 file changed, 153 insertions(+), 13 deletions(-)

diff --git a/instrumentation/events/lttng-module/net.h 
b/instrumentation/events/lttng-module/net.h
index bfa14fc..8e6ee29 100644
--- a/instrumentation/events/lttng-module/net.h
+++ b/instrumentation/events/lttng-module/net.h
@@ -11,6 +11,8 @@
  #include <linux/ip.h>
  #include <linux/ipv6.h>
  #include <linux/tcp.h>
+#include <linux/udp.h>
+#include <linux/icmp.h>
  #include <linux/version.h>
  #include <lttng-endian.h>
  #include <net/sock.h>
@@ -85,6 +87,53 @@ static struct lttng_event_field tcpfields[] = {
  	},
  };

+static struct lttng_event_field udpfields[] = {
+	[0] = {
+		.name = "source_port",
+		.type = __type_integer(uint16_t, 0, 0, 0,
+				__BIG_ENDIAN, 10, none),
+	},
+	[1] = {
+		.name = "dest_port",
+		.type = __type_integer(uint16_t, 0, 0, 0,
+				__BIG_ENDIAN, 10, none),
+	},
+	[2] = {
+		.name = "len",
+		.type = __type_integer(uint16_t, 0, 0, 0,
+				__BIG_ENDIAN, 10, none),
+	},
+	[3] = {
+		.name = "check",
+		.type = __type_integer(uint16_t, 0, 0, 0,
+				__BIG_ENDIAN, 10, none),
+	},
+};
+
+static struct lttng_event_field icmpfields[] = {
+	[0] = {
+		.name = "type",
+		.type = __type_integer(uint8_t, 0, 0, 0,
+				__BIG_ENDIAN, 10, none),
+	},
+	[1] = {
+		.name = "code",
+		.type = __type_integer(uint8_t, 0, 0, 0,
+				__BIG_ENDIAN, 10, none),
+	},
+	[2] = {
+		.name = "checksum",
+		.type = __type_integer(uint16_t, 0, 0, 0,
+				__BIG_ENDIAN, 10, none),
+	},
+	[3] = {
+		.name = "gateway",
+		.type = __type_integer(uint32_t, 0, 0, 0,
+				__BIG_ENDIAN, 10, none),
+	},
+};
+
+
  static struct lttng_event_field transport_fields[] = {
  	[0] = {
  		.name = "unknown",
@@ -102,13 +151,57 @@ static struct lttng_event_field transport_fields[] = {
  			.u._struct.fields = tcpfields,
  		},
  	},
+	[2] = {
+		.name = "udp",
+		.type = {
+			.atype = atype_struct,
+			.u._struct.nr_fields = ARRAY_SIZE(udpfields),
+			.u._struct.fields = udpfields,
+		},
+	},
+	[3] = {
+		.name = "icmp",
+		.type = {
+			.atype = atype_struct,
+			.u._struct.nr_fields = ARRAY_SIZE(icmpfields),
+			.u._struct.fields = icmpfields,
+		},
+	},
  };

  enum transport_header_types {
  	TH_NONE = 0,
  	TH_TCP = 1,
+	TH_UDP = 2,
+	TH_ICMP = 3,
  };

+static inline enum transport_header_types 
__get_transport_header_type_ip(struct sk_buff *skb)
+{
+	switch (ip_hdr(skb)->protocol) {
+	case IPPROTO_TCP:
+		return TH_TCP;
+	case IPPROTO_UDP:
+		return TH_UDP;
+	case IPPROTO_ICMP:
+		return TH_ICMP;
+	}
+	return TH_NONE;
+}
+
+static inline enum transport_header_types 
__get_transport_header_type_ipv6(struct sk_buff *skb)
+{
+	switch (ipv6_hdr(skb)->nexthdr) {
+	case IPPROTO_TCP:
+		return TH_TCP;
+	case IPPROTO_UDP:
+		return TH_UDP;
+	case IPPROTO_ICMP:
+		return TH_ICMP;
+	}
+	return TH_NONE;
+}
+
  static inline enum transport_header_types 
__get_transport_header_type(struct sk_buff *skb)
  {
  	if (__has_network_hdr(skb)) {
@@ -123,13 +216,13 @@ static inline enum transport_header_types 
__get_transport_header_type(struct sk_
  			 * header's data. This method works both for
  			 * sent and received packets.
  			 */
-			if ((skb->protocol == htons(ETH_P_IP) &&
-					ip_hdr(skb)->protocol == IPPROTO_TCP) ||
-				(skb->protocol == htons(ETH_P_IPV6) &&
-					ipv6_hdr(skb)->nexthdr == IPPROTO_TCP))
-				return TH_TCP;
+			if (skb->protocol == htons(ETH_P_IP)) {
+				return __get_transport_header_type_ip(skb);
+			} else if(skb->protocol == htons(ETH_P_IPV6)) {
+				return __get_transport_header_type_ipv6(skb);
+			}
  		}
-		/* Fallthrough for other cases where header is not TCP. */
+		/* Fallthrough for other cases where header is not recognized. */
  	}
  	return TH_NONE;
  }
@@ -137,16 +230,36 @@ static inline enum transport_header_types 
__get_transport_header_type(struct sk_
  static struct lttng_enum_entry proto_transport_enum_entries[] = {
  	[0] = {
  		.start = { .value = 0, .signedness = 0, },
-		.end = { .value = IPPROTO_TCP - 1, .signedness = 0, },
+		.end = { .value = IPPROTO_ICMP - 1, .signedness = 0, },
  		.string = "_unknown",
  	},
  	[1] = {
+		.start = { .value = IPPROTO_ICMP, .signedness = 0, },
+		.end = { .value = IPPROTO_ICMP, .signedness = 0, },
+		.string = "_icmp",
+	},
+	[2] = {
+		.start = { .value = IPPROTO_ICMP + 1, .signedness = 0, },
+		.end = { .value = IPPROTO_TCP - 1, .signedness = 0, },
+		.string = "_unknown",
+	},
+	[3] = {
  		.start = { .value = IPPROTO_TCP, .signedness = 0, },
  		.end = { .value = IPPROTO_TCP, .signedness = 0, },
  		.string = "_tcp",
  	},
-	[2] = {
+	[4] = {
  		.start = { .value = IPPROTO_TCP + 1, .signedness = 0, },
+		.end = { .value = IPPROTO_UDP - 1, .signedness = 0, },
+		.string = "_unknown",
+	},
+	[5] = {
+		.start = { .value = IPPROTO_UDP, .signedness = 0, },
+		.end = { .value = IPPROTO_UDP, .signedness = 0, },
+		.string = "_udp",
+	},
+	[6] = {
+		.start = { .value = IPPROTO_UDP + 1, .signedness = 0, },
  		.end = { .value = 255, .signedness = 0, },
  		.string = "_unknown",
  	},
@@ -169,6 +282,16 @@ static struct lttng_enum_entry 
transport_enum_entries[] = {
  		.end = { .value = TH_TCP, .signedness = 0, },
  		.string = "_tcp",
  	},
+	[2] = {
+		.start = { .value = TH_UDP, .signedness = 0, },
+		.end = { .value = TH_UDP, .signedness = 0, },
+		.string = "_udp",
+	},
+	[3] = {
+		.start = { .value = TH_ICMP, .signedness = 0, },
+		.end = { .value = TH_ICMP, .signedness = 0, },
+		.string = "_icmp",
+	},
  };

  static const struct lttng_enum_desc transport_header_type = {
@@ -510,15 +633,32 @@ LTTNG_TRACEPOINT_EVENT_CLASS(net_dev_template,
  					ctf_integer_type(unsigned char, th_type)

  					/* Copy the transport header. */
-					if (th_type == TH_TCP) {
+					switch (th_type) {
+					case TH_TCP: {
  						ctf_align(uint32_t)
  						ctf_array_type(uint8_t, tcp_hdr(skb),
  								sizeof(struct tcphdr))
+						break;
+					}
+					case TH_UDP: {
+						ctf_align(uint32_t)
+						ctf_array_type(uint8_t, udp_hdr(skb),
+								sizeof(struct udphdr))
+						break;
+					}
+					case TH_ICMP: {
+						ctf_align(uint32_t)
+						ctf_array_type(uint8_t, icmp_hdr(skb),
+								sizeof(struct icmphdr))
+						break;
+					}
+					default:
+						/*
+						* For any other transport header type,
+						* there is nothing to do.
+						*/
+						break;
  					}
-					/*
-					 * For any other transport header type,
-					 * there is nothing to do.
-					 */
  				}
  			)
  		)
-- 
2.17.1
