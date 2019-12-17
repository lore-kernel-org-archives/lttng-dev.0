From: Florian Walbroel <walbroel@silexica.com>
Subject: Fwd: [PATCH lttng-modules] Add UDP and ICMP packet
 header information to the tracepoint:
Date: Tue, 17 Dec 2019 09:56:46 +0100
Message-ID: <7b697030-2d01-90bf-0225-fe52b42e9cd0__49008.6809311592$1576573031$gmane$org@silexica.com>
References: <20191113163814.31606-1-walbroel@silexica.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1159987931700979426=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by lists.lttng.org (Postfix) with ESMTPS id 47cX7l6Jm4z1B5K
 for <lttng-dev@lists.lttng.org>; Tue, 17 Dec 2019 03:56:51 -0500 (EST)
Received: by mail-wr1-x441.google.com with SMTP id d16so10365686wre.10
 for <lttng-dev@lists.lttng.org>; Tue, 17 Dec 2019 00:56:51 -0800 (PST)
Received: from [10.251.251.128] ([213.168.66.154])
 by smtp.gmail.com with ESMTPSA id s1sm2279872wmc.23.2019.12.17.00.56.47
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2019 00:56:47 -0800 (PST)
In-Reply-To: <20191113163814.31606-1-walbroel@silexica.com>
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

This is a multi-part message in MIME format.
--===============1159987931700979426==
Content-Type: multipart/alternative;
 boundary="------------40D40E9C634512DB05D3E250"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------40D40E9C634512DB05D3E250
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I sent in this patch last month and did not hear about any updates since 
then.

There were a few formatting issues that have been addressed. Is there 
anything more that should be done?

Best regards,
Florian Walbroel

-------- Forwarded Message --------
Subject: 	[PATCH lttng-modules] Add UDP and ICMP packet header 
information to the tracepoint:
Date: 	Wed, 13 Nov 2019 17:38:14 +0100
From: 	Florian Walbroel <walbroel@silexica.com>
To: 	lttng-dev@lists.lttng.org



* UDP transport header
* ICMP transport header

(Correct indentation for switch/case)

Signed-off-by: Florian Walbroel <walbroel@silexica.com>
---
instrumentation/events/lttng-module/net.h | 166 ++++++++++++++++++++--
1 file changed, 153 insertions(+), 13 deletions(-)

diff --git a/instrumentation/events/lttng-module/net.h 
b/instrumentation/events/lttng-module/net.h
index bfa14fc..ad1892a 100644
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
+ [0] = {
+ .name = "source_port",
+ .type = __type_integer(uint16_t, 0, 0, 0,
+ __BIG_ENDIAN, 10, none),
+ },
+ [1] = {
+ .name = "dest_port",
+ .type = __type_integer(uint16_t, 0, 0, 0,
+ __BIG_ENDIAN, 10, none),
+ },
+ [2] = {
+ .name = "len",
+ .type = __type_integer(uint16_t, 0, 0, 0,
+ __BIG_ENDIAN, 10, none),
+ },
+ [3] = {
+ .name = "check",
+ .type = __type_integer(uint16_t, 0, 0, 0,
+ __BIG_ENDIAN, 10, none),
+ },
+};
+
+static struct lttng_event_field icmpfields[] = {
+ [0] = {
+ .name = "type",
+ .type = __type_integer(uint8_t, 0, 0, 0,
+ __BIG_ENDIAN, 10, none),
+ },
+ [1] = {
+ .name = "code",
+ .type = __type_integer(uint8_t, 0, 0, 0,
+ __BIG_ENDIAN, 10, none),
+ },
+ [2] = {
+ .name = "checksum",
+ .type = __type_integer(uint16_t, 0, 0, 0,
+ __BIG_ENDIAN, 10, none),
+ },
+ [3] = {
+ .name = "gateway",
+ .type = __type_integer(uint32_t, 0, 0, 0,
+ __BIG_ENDIAN, 10, none),
+ },
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
+ [2] = {
+ .name = "udp",
+ .type = {
+ .atype = atype_struct,
+ .u._struct.nr_fields = ARRAY_SIZE(udpfields),
+ .u._struct.fields = udpfields,
+ },
+ },
+ [3] = {
+ .name = "icmp",
+ .type = {
+ .atype = atype_struct,
+ .u._struct.nr_fields = ARRAY_SIZE(icmpfields),
+ .u._struct.fields = icmpfields,
+ },
+ },
};
enum transport_header_types {
TH_NONE = 0,
TH_TCP = 1,
+ TH_UDP = 2,
+ TH_ICMP = 3,
};
+static inline enum transport_header_types 
__get_transport_header_type_ip(struct sk_buff *skb)
+{
+ switch(ip_hdr(skb)->protocol) {
+ case IPPROTO_TCP:
+ return TH_TCP;
+ case IPPROTO_UDP:
+ return TH_UDP;
+ case IPPROTO_ICMP:
+ return TH_ICMP;
+ }
+ return TH_NONE;
+}
+
+static inline enum transport_header_types 
__get_transport_header_type_ipv6(struct sk_buff *skb)
+{
+ switch(ipv6_hdr(skb)->nexthdr) {
+ case IPPROTO_TCP:
+ return TH_TCP;
+ case IPPROTO_UDP:
+ return TH_UDP;
+ case IPPROTO_ICMP:
+ return TH_ICMP;
+ }
+ return TH_NONE;
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
- if ((skb->protocol == htons(ETH_P_IP) &&
- ip_hdr(skb)->protocol == IPPROTO_TCP) ||
- (skb->protocol == htons(ETH_P_IPV6) &&
- ipv6_hdr(skb)->nexthdr == IPPROTO_TCP))
- return TH_TCP;
+ if (skb->protocol == htons(ETH_P_IP)) {
+ return __get_transport_header_type_ip(skb);
+ } else if(skb->protocol == htons(ETH_P_IPV6)) {
+ return __get_transport_header_type_ipv6(skb);
+ }
}
- /* Fallthrough for other cases where header is not TCP. */
+ /* Fallthrough for other cases where header is not recognized. */
}
return TH_NONE;
}
@@ -137,16 +230,36 @@ static inline enum transport_header_types 
__get_transport_header_type(struct sk_
static struct lttng_enum_entry proto_transport_enum_entries[] = {
[0] = {
.start = { .value = 0, .signedness = 0, },
- .end = { .value = IPPROTO_TCP - 1, .signedness = 0, },
+ .end = { .value = IPPROTO_ICMP - 1, .signedness = 0, },
.string = "_unknown",
},
[1] = {
+ .start = { .value = IPPROTO_ICMP, .signedness = 0, },
+ .end = { .value = IPPROTO_ICMP, .signedness = 0, },
+ .string = "_icmp",
+ },
+ [2] = {
+ .start = { .value = IPPROTO_ICMP + 1, .signedness = 0, },
+ .end = { .value = IPPROTO_TCP - 1, .signedness = 0, },
+ .string = "_unknown",
+ },
+ [3] = {
.start = { .value = IPPROTO_TCP, .signedness = 0, },
.end = { .value = IPPROTO_TCP, .signedness = 0, },
.string = "_tcp",
},
- [2] = {
+ [4] = {
.start = { .value = IPPROTO_TCP + 1, .signedness = 0, },
+ .end = { .value = IPPROTO_UDP - 1, .signedness = 0, },
+ .string = "_unknown",
+ },
+ [5] = {
+ .start = { .value = IPPROTO_UDP, .signedness = 0, },
+ .end = { .value = IPPROTO_UDP, .signedness = 0, },
+ .string = "_udp",
+ },
+ [6] = {
+ .start = { .value = IPPROTO_UDP + 1, .signedness = 0, },
.end = { .value = 255, .signedness = 0, },
.string = "_unknown",
},
@@ -169,6 +282,16 @@ static struct lttng_enum_entry 
transport_enum_entries[] = {
.end = { .value = TH_TCP, .signedness = 0, },
.string = "_tcp",
},
+ [2] = {
+ .start = { .value = TH_UDP, .signedness = 0, },
+ .end = { .value = TH_UDP, .signedness = 0, },
+ .string = "_udp",
+ },
+ [3] = {
+ .start = { .value = TH_ICMP, .signedness = 0, },
+ .end = { .value = TH_ICMP, .signedness = 0, },
+ .string = "_icmp",
+ },
};
static const struct lttng_enum_desc transport_header_type = {
@@ -510,15 +633,32 @@ LTTNG_TRACEPOINT_EVENT_CLASS(net_dev_template,
ctf_integer_type(unsigned char, th_type)
/* Copy the transport header. */
- if (th_type == TH_TCP) {
+ switch (th_type) {
+ case TH_TCP: {
ctf_align(uint32_t)
ctf_array_type(uint8_t, tcp_hdr(skb),
sizeof(struct tcphdr))
+ break;
+ }
+ case TH_UDP: {
+ ctf_align(uint32_t)
+ ctf_array_type(uint8_t, udp_hdr(skb),
+ sizeof(struct udphdr))
+ break;
+ }
+ case TH_ICMP: {
+ ctf_align(uint32_t)
+ ctf_array_type(uint8_t, icmp_hdr(skb),
+ sizeof(struct udphdr))
+ break;
+ }
+ default:
+ /*
+ * For any other transport header type,
+ * there is nothing to do.
+ */
+ break;
}
- /*
- * For any other transport header type,
- * there is nothing to do.
- */
}
)
)

-- 
2.17.1


--------------40D40E9C634512DB05D3E250
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=windows-1252">
  </head>
  <body>
    <p>Hi,</p>
    <p>I sent in this patch last month and did not hear about any
      updates since then.<br>
    </p>
    <p>There were a few formatting issues that have been addressed. Is
      there anything more that should be done?<br>
    </p>
    <div class="moz-forward-container">Best regards,</div>
    <div class="moz-forward-container">Florian Walbroel</div>
    <div class="moz-forward-container"><br>
    </div>
    <div class="moz-forward-container">-------- Forwarded Message
      --------
      <table class="moz-email-headers-table" cellspacing="0"
        cellpadding="0" border="0">
        <tbody>
          <tr>
            <th valign="BASELINE" nowrap="nowrap" align="RIGHT">Subject:
            </th>
            <td>[PATCH lttng-modules] Add UDP and ICMP packet header
              information to the tracepoint:</td>
          </tr>
          <tr>
            <th valign="BASELINE" nowrap="nowrap" align="RIGHT">Date: </th>
            <td>Wed, 13 Nov 2019 17:38:14 +0100</td>
          </tr>
          <tr>
            <th valign="BASELINE" nowrap="nowrap" align="RIGHT">From: </th>
            <td>Florian Walbroel <a class="moz-txt-link-rfc2396E" href="mailto:walbroel@silexica.com">&lt;walbroel@silexica.com&gt;</a></td>
          </tr>
          <tr>
            <th valign="BASELINE" nowrap="nowrap" align="RIGHT">To: </th>
            <td><a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a></td>
          </tr>
        </tbody>
      </table>
      <br>
      <br>
      * UDP transport header<br>
      * ICMP transport header<br>
      <br>
      (Correct indentation for switch/case)<br>
      <br>
      Signed-off-by: Florian Walbroel <a class="moz-txt-link-rfc2396E" href="mailto:walbroel@silexica.com">&lt;walbroel@silexica.com&gt;</a><br>
      ---<br>
      instrumentation/events/lttng-module/net.h | 166
      ++++++++++++++++++++--<br>
      1 file changed, 153 insertions(+), 13 deletions(-)<br>
      <br>
      diff --git a/instrumentation/events/lttng-module/net.h
      b/instrumentation/events/lttng-module/net.h<br>
      index bfa14fc..ad1892a 100644<br>
      --- a/instrumentation/events/lttng-module/net.h<br>
      +++ b/instrumentation/events/lttng-module/net.h<br>
      @@ -11,6 +11,8 @@<br>
      #include &lt;linux/ip.h&gt;<br>
      #include &lt;linux/ipv6.h&gt;<br>
      #include &lt;linux/tcp.h&gt;<br>
      +#include &lt;linux/udp.h&gt;<br>
      +#include &lt;linux/icmp.h&gt;<br>
      #include &lt;linux/version.h&gt;<br>
      #include &lt;lttng-endian.h&gt;<br>
      #include &lt;net/sock.h&gt;<br>
      @@ -85,6 +87,53 @@ static struct lttng_event_field tcpfields[] = {<br>
      },<br>
      };<br>
      +static struct lttng_event_field udpfields[] = {<br>
      + [0] = {<br>
      + .name = "source_port",<br>
      + .type = __type_integer(uint16_t, 0, 0, 0,<br>
      + __BIG_ENDIAN, 10, none),<br>
      + },<br>
      + [1] = {<br>
      + .name = "dest_port",<br>
      + .type = __type_integer(uint16_t, 0, 0, 0,<br>
      + __BIG_ENDIAN, 10, none),<br>
      + },<br>
      + [2] = {<br>
      + .name = "len",<br>
      + .type = __type_integer(uint16_t, 0, 0, 0,<br>
      + __BIG_ENDIAN, 10, none),<br>
      + },<br>
      + [3] = {<br>
      + .name = "check",<br>
      + .type = __type_integer(uint16_t, 0, 0, 0,<br>
      + __BIG_ENDIAN, 10, none),<br>
      + },<br>
      +};<br>
      +<br>
      +static struct lttng_event_field icmpfields[] = {<br>
      + [0] = {<br>
      + .name = "type",<br>
      + .type = __type_integer(uint8_t, 0, 0, 0,<br>
      + __BIG_ENDIAN, 10, none),<br>
      + },<br>
      + [1] = {<br>
      + .name = "code",<br>
      + .type = __type_integer(uint8_t, 0, 0, 0,<br>
      + __BIG_ENDIAN, 10, none),<br>
      + },<br>
      + [2] = {<br>
      + .name = "checksum",<br>
      + .type = __type_integer(uint16_t, 0, 0, 0,<br>
      + __BIG_ENDIAN, 10, none),<br>
      + },<br>
      + [3] = {<br>
      + .name = "gateway",<br>
      + .type = __type_integer(uint32_t, 0, 0, 0,<br>
      + __BIG_ENDIAN, 10, none),<br>
      + },<br>
      +};<br>
      +<br>
      +<br>
      static struct lttng_event_field transport_fields[] = {<br>
      [0] = {<br>
      .name = "unknown",<br>
      @@ -102,13 +151,57 @@ static struct lttng_event_field
      transport_fields[] = {<br>
      .u._struct.fields = tcpfields,<br>
      },<br>
      },<br>
      + [2] = {<br>
      + .name = "udp",<br>
      + .type = {<br>
      + .atype = atype_struct,<br>
      + .u._struct.nr_fields = ARRAY_SIZE(udpfields),<br>
      + .u._struct.fields = udpfields,<br>
      + },<br>
      + },<br>
      + [3] = {<br>
      + .name = "icmp",<br>
      + .type = {<br>
      + .atype = atype_struct,<br>
      + .u._struct.nr_fields = ARRAY_SIZE(icmpfields),<br>
      + .u._struct.fields = icmpfields,<br>
      + },<br>
      + },<br>
      };<br>
      enum transport_header_types {<br>
      TH_NONE = 0,<br>
      TH_TCP = 1,<br>
      + TH_UDP = 2,<br>
      + TH_ICMP = 3,<br>
      };<br>
      +static inline enum transport_header_types
      __get_transport_header_type_ip(struct sk_buff *skb)<br>
      +{<br>
      + switch(ip_hdr(skb)-&gt;protocol) {<br>
      + case IPPROTO_TCP:<br>
      + return TH_TCP;<br>
      + case IPPROTO_UDP:<br>
      + return TH_UDP;<br>
      + case IPPROTO_ICMP:<br>
      + return TH_ICMP;<br>
      + }<br>
      + return TH_NONE;<br>
      +}<br>
      +<br>
      +static inline enum transport_header_types
      __get_transport_header_type_ipv6(struct sk_buff *skb)<br>
      +{<br>
      + switch(ipv6_hdr(skb)-&gt;nexthdr) {<br>
      + case IPPROTO_TCP:<br>
      + return TH_TCP;<br>
      + case IPPROTO_UDP:<br>
      + return TH_UDP;<br>
      + case IPPROTO_ICMP:<br>
      + return TH_ICMP;<br>
      + }<br>
      + return TH_NONE;<br>
      +}<br>
      +<br>
      static inline enum transport_header_types
      __get_transport_header_type(struct sk_buff *skb)<br>
      {<br>
      if (__has_network_hdr(skb)) {<br>
      @@ -123,13 +216,13 @@ static inline enum transport_header_types
      __get_transport_header_type(struct sk_<br>
      * header's data. This method works both for<br>
      * sent and received packets.<br>
      */<br>
      - if ((skb-&gt;protocol == htons(ETH_P_IP) &amp;&amp;<br>
      - ip_hdr(skb)-&gt;protocol == IPPROTO_TCP) ||<br>
      - (skb-&gt;protocol == htons(ETH_P_IPV6) &amp;&amp;<br>
      - ipv6_hdr(skb)-&gt;nexthdr == IPPROTO_TCP))<br>
      - return TH_TCP;<br>
      + if (skb-&gt;protocol == htons(ETH_P_IP)) {<br>
      + return __get_transport_header_type_ip(skb);<br>
      + } else if(skb-&gt;protocol == htons(ETH_P_IPV6)) {<br>
      + return __get_transport_header_type_ipv6(skb);<br>
      + }<br>
      }<br>
      - /* Fallthrough for other cases where header is not TCP. */<br>
      + /* Fallthrough for other cases where header is not recognized.
      */<br>
      }<br>
      return TH_NONE;<br>
      }<br>
      @@ -137,16 +230,36 @@ static inline enum transport_header_types
      __get_transport_header_type(struct sk_<br>
      static struct lttng_enum_entry proto_transport_enum_entries[] = {<br>
      [0] = {<br>
      .start = { .value = 0, .signedness = 0, },<br>
      - .end = { .value = IPPROTO_TCP - 1, .signedness = 0, },<br>
      + .end = { .value = IPPROTO_ICMP - 1, .signedness = 0, },<br>
      .string = "_unknown",<br>
      },<br>
      [1] = {<br>
      + .start = { .value = IPPROTO_ICMP, .signedness = 0, },<br>
      + .end = { .value = IPPROTO_ICMP, .signedness = 0, },<br>
      + .string = "_icmp",<br>
      + },<br>
      + [2] = {<br>
      + .start = { .value = IPPROTO_ICMP + 1, .signedness = 0, },<br>
      + .end = { .value = IPPROTO_TCP - 1, .signedness = 0, },<br>
      + .string = "_unknown",<br>
      + },<br>
      + [3] = {<br>
      .start = { .value = IPPROTO_TCP, .signedness = 0, },<br>
      .end = { .value = IPPROTO_TCP, .signedness = 0, },<br>
      .string = "_tcp",<br>
      },<br>
      - [2] = {<br>
      + [4] = {<br>
      .start = { .value = IPPROTO_TCP + 1, .signedness = 0, },<br>
      + .end = { .value = IPPROTO_UDP - 1, .signedness = 0, },<br>
      + .string = "_unknown",<br>
      + },<br>
      + [5] = {<br>
      + .start = { .value = IPPROTO_UDP, .signedness = 0, },<br>
      + .end = { .value = IPPROTO_UDP, .signedness = 0, },<br>
      + .string = "_udp",<br>
      + },<br>
      + [6] = {<br>
      + .start = { .value = IPPROTO_UDP + 1, .signedness = 0, },<br>
      .end = { .value = 255, .signedness = 0, },<br>
      .string = "_unknown",<br>
      },<br>
      @@ -169,6 +282,16 @@ static struct lttng_enum_entry
      transport_enum_entries[] = {<br>
      .end = { .value = TH_TCP, .signedness = 0, },<br>
      .string = "_tcp",<br>
      },<br>
      + [2] = {<br>
      + .start = { .value = TH_UDP, .signedness = 0, },<br>
      + .end = { .value = TH_UDP, .signedness = 0, },<br>
      + .string = "_udp",<br>
      + },<br>
      + [3] = {<br>
      + .start = { .value = TH_ICMP, .signedness = 0, },<br>
      + .end = { .value = TH_ICMP, .signedness = 0, },<br>
      + .string = "_icmp",<br>
      + },<br>
      };<br>
      static const struct lttng_enum_desc transport_header_type = {<br>
      @@ -510,15 +633,32 @@
      LTTNG_TRACEPOINT_EVENT_CLASS(net_dev_template,<br>
      ctf_integer_type(unsigned char, th_type)<br>
      /* Copy the transport header. */<br>
      - if (th_type == TH_TCP) {<br>
      + switch (th_type) {<br>
      + case TH_TCP: {<br>
      ctf_align(uint32_t)<br>
      ctf_array_type(uint8_t, tcp_hdr(skb),<br>
      sizeof(struct tcphdr))<br>
      + break;<br>
      + }<br>
      + case TH_UDP: {<br>
      + ctf_align(uint32_t)<br>
      + ctf_array_type(uint8_t, udp_hdr(skb),<br>
      + sizeof(struct udphdr))<br>
      + break;<br>
      + }<br>
      + case TH_ICMP: {<br>
      + ctf_align(uint32_t)<br>
      + ctf_array_type(uint8_t, icmp_hdr(skb),<br>
      + sizeof(struct udphdr))<br>
      + break;<br>
      + }<br>
      + default:<br>
      + /*<br>
      + * For any other transport header type,<br>
      + * there is nothing to do.<br>
      + */<br>
      + break;<br>
      }<br>
      - /*<br>
      - * For any other transport header type,<br>
      - * there is nothing to do.<br>
      - */<br>
      }<br>
      )<br>
      )<br>
      <pre class="moz-signature">-- 
2.17.1

</pre>
    </div>
  </body>
</html>

--------------40D40E9C634512DB05D3E250--

--===============1159987931700979426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1159987931700979426==--
