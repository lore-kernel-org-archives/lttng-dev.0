From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Fwd: [PATCH lttng-modules] Add UDP and ICMP packet
 header information to the tracepoint:
Date: Tue, 17 Dec 2019 09:39:51 -0500 (EST)
Message-ID: <1666401048.8323.1576593591017.JavaMail.zimbra__24312.8185089276$1576593620$gmane$org@efficios.com>
References: <20191113163814.31606-1-walbroel@silexica.com>
 <7b697030-2d01-90bf-0225-fe52b42e9cd0@silexica.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2951255088393383298=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 47cglf6KlSz1BTF
 for <lttng-dev@lists.lttng.org>; Tue, 17 Dec 2019 09:39:58 -0500 (EST)
In-Reply-To: <7b697030-2d01-90bf-0225-fe52b42e9cd0@silexica.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Florian Walbroel <walbroel@silexica.com>
Cc: Julien Desfossez <ju@klipix.org>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2951255088393383298==
Content-Type: multipart/alternative;
	boundary="=_0ff169d0-142e-4be9-ab8e-4dd6aa188325"

--=_0ff169d0-142e-4be9-ab8e-4dd6aa188325
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Dec 17, 2019, at 3:56 AM, Florian Walbroel <walbroel@silexica.com>=
 wrote:=20

> Hi,

> I sent in this patch last month and did not hear about any updates since =
then.

> There were a few formatting issues that have been addressed. Is there any=
thing
> more that should be done?
Hi,=20

I was expecting review from Genevi=C3=A8ve and Julien on this patch, but ne=
ver heard back from=20
them.=20

Genevi=C3=A8ve, Julien, Michael, can you review this patch please ?=20

Thanks,=20

Mathieu=20

> Best regards,
> Florian Walbroel

> -------- Forwarded Message -------- Subject: =09[PATCH lttng-modules] Add=
 UDP and
> ICMP packet header information to the tracepoint:
> Date: =09Wed, 13 Nov 2019 17:38:14 +0100
> From: =09Florian Walbroel [ mailto:walbroel@silexica.com | <walbroel@sile=
xica.com>
> ]

> To: =09[ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]

> * UDP transport header
> * ICMP transport header

> (Correct indentation for switch/case)

> Signed-off-by: Florian Walbroel [ mailto:walbroel@silexica.com |
> <walbroel@silexica.com> ]
> ---
> instrumentation/events/lttng-module/net.h | 166 ++++++++++++++++++++--
> 1 file changed, 153 insertions(+), 13 deletions(-)

> diff --git a/instrumentation/events/lttng-module/net.h
> b/instrumentation/events/lttng-module/net.h
> index bfa14fc..ad1892a 100644
> --- a/instrumentation/events/lttng-module/net.h
> +++ b/instrumentation/events/lttng-module/net.h
> @@ -11,6 +11,8 @@
> #include <linux/ip.h>
> #include <linux/ipv6.h>
> #include <linux/tcp.h>
> +#include <linux/udp.h>
> +#include <linux/icmp.h>
> #include <linux/version.h>
> #include <lttng-endian.h>
> #include <net/sock.h>
> @@ -85,6 +87,53 @@ static struct lttng_event_field tcpfields[] =3D {
> },
> };
> +static struct lttng_event_field udpfields[] =3D {
> + [0] =3D {
> + .name =3D "source_port",
> + .type =3D __type_integer(uint16_t, 0, 0, 0,
> + __BIG_ENDIAN, 10, none),
> + },
> + [1] =3D {
> + .name =3D "dest_port",
> + .type =3D __type_integer(uint16_t, 0, 0, 0,
> + __BIG_ENDIAN, 10, none),
> + },
> + [2] =3D {
> + .name =3D "len",
> + .type =3D __type_integer(uint16_t, 0, 0, 0,
> + __BIG_ENDIAN, 10, none),
> + },
> + [3] =3D {
> + .name =3D "check",
> + .type =3D __type_integer(uint16_t, 0, 0, 0,
> + __BIG_ENDIAN, 10, none),
> + },
> +};
> +
> +static struct lttng_event_field icmpfields[] =3D {
> + [0] =3D {
> + .name =3D "type",
> + .type =3D __type_integer(uint8_t, 0, 0, 0,
> + __BIG_ENDIAN, 10, none),
> + },
> + [1] =3D {
> + .name =3D "code",
> + .type =3D __type_integer(uint8_t, 0, 0, 0,
> + __BIG_ENDIAN, 10, none),
> + },
> + [2] =3D {
> + .name =3D "checksum",
> + .type =3D __type_integer(uint16_t, 0, 0, 0,
> + __BIG_ENDIAN, 10, none),
> + },
> + [3] =3D {
> + .name =3D "gateway",
> + .type =3D __type_integer(uint32_t, 0, 0, 0,
> + __BIG_ENDIAN, 10, none),
> + },
> +};
> +
> +
> static struct lttng_event_field transport_fields[] =3D {
> [0] =3D {
> .name =3D "unknown",
> @@ -102,13 +151,57 @@ static struct lttng_event_field transport_fields[] =
=3D {
> .u._struct.fields =3D tcpfields,
> },
> },
> + [2] =3D {
> + .name =3D "udp",
> + .type =3D {
> + .atype =3D atype_struct,
> + .u._struct.nr_fields =3D ARRAY_SIZE(udpfields),
> + .u._struct.fields =3D udpfields,
> + },
> + },
> + [3] =3D {
> + .name =3D "icmp",
> + .type =3D {
> + .atype =3D atype_struct,
> + .u._struct.nr_fields =3D ARRAY_SIZE(icmpfields),
> + .u._struct.fields =3D icmpfields,
> + },
> + },
> };
> enum transport_header_types {
> TH_NONE =3D 0,
> TH_TCP =3D 1,
> + TH_UDP =3D 2,
> + TH_ICMP =3D 3,
> };
> +static inline enum transport_header_types __get_transport_header_type_ip=
(struct
> sk_buff *skb)
> +{
> + switch(ip_hdr(skb)->protocol) {
> + case IPPROTO_TCP:
> + return TH_TCP;
> + case IPPROTO_UDP:
> + return TH_UDP;
> + case IPPROTO_ICMP:
> + return TH_ICMP;
> + }
> + return TH_NONE;
> +}
> +
> +static inline enum transport_header_types
> __get_transport_header_type_ipv6(struct sk_buff *skb)
> +{
> + switch(ipv6_hdr(skb)->nexthdr) {
> + case IPPROTO_TCP:
> + return TH_TCP;
> + case IPPROTO_UDP:
> + return TH_UDP;
> + case IPPROTO_ICMP:
> + return TH_ICMP;
> + }
> + return TH_NONE;
> +}
> +
> static inline enum transport_header_types __get_transport_header_type(str=
uct
> sk_buff *skb)
> {
> if (__has_network_hdr(skb)) {
> @@ -123,13 +216,13 @@ static inline enum transport_header_types
> __get_transport_header_type(struct sk_
> * header's data. This method works both for
> * sent and received packets.
> */
> - if ((skb->protocol =3D=3D htons(ETH_P_IP) &&
> - ip_hdr(skb)->protocol =3D=3D IPPROTO_TCP) ||
> - (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
> - ipv6_hdr(skb)->nexthdr =3D=3D IPPROTO_TCP))
> - return TH_TCP;
> + if (skb->protocol =3D=3D htons(ETH_P_IP)) {
> + return __get_transport_header_type_ip(skb);
> + } else if(skb->protocol =3D=3D htons(ETH_P_IPV6)) {
> + return __get_transport_header_type_ipv6(skb);
> + }
> }
> - /* Fallthrough for other cases where header is not TCP. */
> + /* Fallthrough for other cases where header is not recognized. */
> }
> return TH_NONE;
> }
> @@ -137,16 +230,36 @@ static inline enum transport_header_types
> __get_transport_header_type(struct sk_
> static struct lttng_enum_entry proto_transport_enum_entries[] =3D {
> [0] =3D {
> .start =3D { .value =3D 0, .signedness =3D 0, },
> - .end =3D { .value =3D IPPROTO_TCP - 1, .signedness =3D 0, },
> + .end =3D { .value =3D IPPROTO_ICMP - 1, .signedness =3D 0, },
> .string =3D "_unknown",
> },
> [1] =3D {
> + .start =3D { .value =3D IPPROTO_ICMP, .signedness =3D 0, },
> + .end =3D { .value =3D IPPROTO_ICMP, .signedness =3D 0, },
> + .string =3D "_icmp",
> + },
> + [2] =3D {
> + .start =3D { .value =3D IPPROTO_ICMP + 1, .signedness =3D 0, },
> + .end =3D { .value =3D IPPROTO_TCP - 1, .signedness =3D 0, },
> + .string =3D "_unknown",
> + },
> + [3] =3D {
> .start =3D { .value =3D IPPROTO_TCP, .signedness =3D 0, },
> .end =3D { .value =3D IPPROTO_TCP, .signedness =3D 0, },
> .string =3D "_tcp",
> },
> - [2] =3D {
> + [4] =3D {
> .start =3D { .value =3D IPPROTO_TCP + 1, .signedness =3D 0, },
> + .end =3D { .value =3D IPPROTO_UDP - 1, .signedness =3D 0, },
> + .string =3D "_unknown",
> + },
> + [5] =3D {
> + .start =3D { .value =3D IPPROTO_UDP, .signedness =3D 0, },
> + .end =3D { .value =3D IPPROTO_UDP, .signedness =3D 0, },
> + .string =3D "_udp",
> + },
> + [6] =3D {
> + .start =3D { .value =3D IPPROTO_UDP + 1, .signedness =3D 0, },
> .end =3D { .value =3D 255, .signedness =3D 0, },
> .string =3D "_unknown",
> },
> @@ -169,6 +282,16 @@ static struct lttng_enum_entry transport_enum_entrie=
s[] =3D {
> .end =3D { .value =3D TH_TCP, .signedness =3D 0, },
> .string =3D "_tcp",
> },
> + [2] =3D {
> + .start =3D { .value =3D TH_UDP, .signedness =3D 0, },
> + .end =3D { .value =3D TH_UDP, .signedness =3D 0, },
> + .string =3D "_udp",
> + },
> + [3] =3D {
> + .start =3D { .value =3D TH_ICMP, .signedness =3D 0, },
> + .end =3D { .value =3D TH_ICMP, .signedness =3D 0, },
> + .string =3D "_icmp",
> + },
> };
> static const struct lttng_enum_desc transport_header_type =3D {
> @@ -510,15 +633,32 @@ LTTNG_TRACEPOINT_EVENT_CLASS(net_dev_template,
> ctf_integer_type(unsigned char, th_type)
> /* Copy the transport header. */
> - if (th_type =3D=3D TH_TCP) {
> + switch (th_type) {
> + case TH_TCP: {
> ctf_align(uint32_t)
> ctf_array_type(uint8_t, tcp_hdr(skb),
> sizeof(struct tcphdr))
> + break;
> + }
> + case TH_UDP: {
> + ctf_align(uint32_t)
> + ctf_array_type(uint8_t, udp_hdr(skb),
> + sizeof(struct udphdr))
> + break;
> + }
> + case TH_ICMP: {
> + ctf_align(uint32_t)
> + ctf_array_type(uint8_t, icmp_hdr(skb),
> + sizeof(struct udphdr))
> + break;
> + }
> + default:
> + /*
> + * For any other transport header type,
> + * there is nothing to do.
> + */
> + break;
> }
> - /*
> - * For any other transport header type,
> - * there is nothing to do.
> - */
> }
> )
> )
> --
> 2.17.1

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_0ff169d0-142e-4be9-ab8e-4dd6aa188325
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br data-mce-bogus=3D"1"></div><div><span i=
d=3D"zwchr" data-marker=3D"__DIVIDER__">----- On Dec 17, 2019, at 3:56 AM, =
Florian Walbroel &lt;walbroel@silexica.com&gt; wrote:<br></span></div><div =
data-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid =
#1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font=
-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;f=
ont-size:12pt;"><p>Hi,</p>
    <p>I sent in this patch last month and did not hear about any
      updates since then.<br>
    </p>
    <p>There were a few formatting issues that have been addressed. Is
      there anything more that should be done?</p></blockquote><div>Hi,<br =
data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>I was e=
xpecting review from Genevi=C3=A8ve and Julien on this patch, but never hea=
rd back from<br data-mce-bogus=3D"1"></div><div>them.<br data-mce-bogus=3D"=
1"></div><div><br data-mce-bogus=3D"1"></div><div>Genevi=C3=A8ve, Julien, M=
ichael, can you review this patch please ?<br data-mce-bogus=3D"1"></div><d=
iv><br data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></di=
v><div><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1">=
</div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:=
2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:n=
ormal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sa=
ns-serif;font-size:12pt;"><p><br>
    </p>
    <div>Best regards,</div>
    <div>Florian Walbroel</div>
    <div><br>
    </div>
    <div>-------- Forwarded Message
      --------
      <table class=3D"moz-email-headers-table" cellspacing=3D"0" cellpaddin=
g=3D"0" border=3D"0"><tbody><tr><th valign=3D"BASELINE" nowrap=3D"nowrap" a=
lign=3D"RIGHT">Subject:
            </th><td>[PATCH lttng-modules] Add UDP and ICMP packet header
              information to the tracepoint:</td></tr><tr><th valign=3D"BAS=
ELINE" nowrap=3D"nowrap" align=3D"RIGHT">Date: </th><td>Wed, 13 Nov 2019 17=
:38:14 +0100</td></tr><tr><th valign=3D"BASELINE" nowrap=3D"nowrap" align=
=3D"RIGHT">From: </th><td>Florian Walbroel <a href=3D"mailto:walbroel@silex=
ica.com" target=3D"_blank" rel=3D"nofollow noopener noreferrer">&lt;walbroe=
l@silexica.com&gt;</a><br data-mce-bogus=3D"1"></td></tr><tr><th valign=3D"=
BASELINE" nowrap=3D"nowrap" align=3D"RIGHT">To: </th><td><a href=3D"mailto:=
lttng-dev@lists.lttng.org" target=3D"_blank" rel=3D"nofollow noopener noref=
errer">lttng-dev@lists.lttng.org</a><br data-mce-bogus=3D"1"></td></tr></tb=
ody></table>
      <br>
      <br>
      * UDP transport header<br>
      * ICMP transport header<br>
      <br>
      (Correct indentation for switch/case)<br>
      <br>
      Signed-off-by: Florian Walbroel <a href=3D"mailto:walbroel@silexica.c=
om" target=3D"_blank" rel=3D"nofollow noopener noreferrer">&lt;walbroel@sil=
exica.com&gt;</a><br>
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
      @@ -85,6 +87,53 @@ static struct lttng_event_field tcpfields[] =3D {<=
br>
      },<br>
      };<br>
      +static struct lttng_event_field udpfields[] =3D {<br>
      + [0] =3D {<br>
      + .name =3D "source_port",<br>
      + .type =3D __type_integer(uint16_t, 0, 0, 0,<br>
      + __BIG_ENDIAN, 10, none),<br>
      + },<br>
      + [1] =3D {<br>
      + .name =3D "dest_port",<br>
      + .type =3D __type_integer(uint16_t, 0, 0, 0,<br>
      + __BIG_ENDIAN, 10, none),<br>
      + },<br>
      + [2] =3D {<br>
      + .name =3D "len",<br>
      + .type =3D __type_integer(uint16_t, 0, 0, 0,<br>
      + __BIG_ENDIAN, 10, none),<br>
      + },<br>
      + [3] =3D {<br>
      + .name =3D "check",<br>
      + .type =3D __type_integer(uint16_t, 0, 0, 0,<br>
      + __BIG_ENDIAN, 10, none),<br>
      + },<br>
      +};<br>
      +<br>
      +static struct lttng_event_field icmpfields[] =3D {<br>
      + [0] =3D {<br>
      + .name =3D "type",<br>
      + .type =3D __type_integer(uint8_t, 0, 0, 0,<br>
      + __BIG_ENDIAN, 10, none),<br>
      + },<br>
      + [1] =3D {<br>
      + .name =3D "code",<br>
      + .type =3D __type_integer(uint8_t, 0, 0, 0,<br>
      + __BIG_ENDIAN, 10, none),<br>
      + },<br>
      + [2] =3D {<br>
      + .name =3D "checksum",<br>
      + .type =3D __type_integer(uint16_t, 0, 0, 0,<br>
      + __BIG_ENDIAN, 10, none),<br>
      + },<br>
      + [3] =3D {<br>
      + .name =3D "gateway",<br>
      + .type =3D __type_integer(uint32_t, 0, 0, 0,<br>
      + __BIG_ENDIAN, 10, none),<br>
      + },<br>
      +};<br>
      +<br>
      +<br>
      static struct lttng_event_field transport_fields[] =3D {<br>
      [0] =3D {<br>
      .name =3D "unknown",<br>
      @@ -102,13 +151,57 @@ static struct lttng_event_field
      transport_fields[] =3D {<br>
      .u._struct.fields =3D tcpfields,<br>
      },<br>
      },<br>
      + [2] =3D {<br>
      + .name =3D "udp",<br>
      + .type =3D {<br>
      + .atype =3D atype_struct,<br>
      + .u._struct.nr_fields =3D ARRAY_SIZE(udpfields),<br>
      + .u._struct.fields =3D udpfields,<br>
      + },<br>
      + },<br>
      + [3] =3D {<br>
      + .name =3D "icmp",<br>
      + .type =3D {<br>
      + .atype =3D atype_struct,<br>
      + .u._struct.nr_fields =3D ARRAY_SIZE(icmpfields),<br>
      + .u._struct.fields =3D icmpfields,<br>
      + },<br>
      + },<br>
      };<br>
      enum transport_header_types {<br>
      TH_NONE =3D 0,<br>
      TH_TCP =3D 1,<br>
      + TH_UDP =3D 2,<br>
      + TH_ICMP =3D 3,<br>
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
      - if ((skb-&gt;protocol =3D=3D htons(ETH_P_IP) &amp;&amp;<br>
      - ip_hdr(skb)-&gt;protocol =3D=3D IPPROTO_TCP) ||<br>
      - (skb-&gt;protocol =3D=3D htons(ETH_P_IPV6) &amp;&amp;<br>
      - ipv6_hdr(skb)-&gt;nexthdr =3D=3D IPPROTO_TCP))<br>
      - return TH_TCP;<br>
      + if (skb-&gt;protocol =3D=3D htons(ETH_P_IP)) {<br>
      + return __get_transport_header_type_ip(skb);<br>
      + } else if(skb-&gt;protocol =3D=3D htons(ETH_P_IPV6)) {<br>
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
      static struct lttng_enum_entry proto_transport_enum_entries[] =3D {<b=
r>
      [0] =3D {<br>
      .start =3D { .value =3D 0, .signedness =3D 0, },<br>
      - .end =3D { .value =3D IPPROTO_TCP - 1, .signedness =3D 0, },<br>
      + .end =3D { .value =3D IPPROTO_ICMP - 1, .signedness =3D 0, },<br>
      .string =3D "_unknown",<br>
      },<br>
      [1] =3D {<br>
      + .start =3D { .value =3D IPPROTO_ICMP, .signedness =3D 0, },<br>
      + .end =3D { .value =3D IPPROTO_ICMP, .signedness =3D 0, },<br>
      + .string =3D "_icmp",<br>
      + },<br>
      + [2] =3D {<br>
      + .start =3D { .value =3D IPPROTO_ICMP + 1, .signedness =3D 0, },<br>
      + .end =3D { .value =3D IPPROTO_TCP - 1, .signedness =3D 0, },<br>
      + .string =3D "_unknown",<br>
      + },<br>
      + [3] =3D {<br>
      .start =3D { .value =3D IPPROTO_TCP, .signedness =3D 0, },<br>
      .end =3D { .value =3D IPPROTO_TCP, .signedness =3D 0, },<br>
      .string =3D "_tcp",<br>
      },<br>
      - [2] =3D {<br>
      + [4] =3D {<br>
      .start =3D { .value =3D IPPROTO_TCP + 1, .signedness =3D 0, },<br>
      + .end =3D { .value =3D IPPROTO_UDP - 1, .signedness =3D 0, },<br>
      + .string =3D "_unknown",<br>
      + },<br>
      + [5] =3D {<br>
      + .start =3D { .value =3D IPPROTO_UDP, .signedness =3D 0, },<br>
      + .end =3D { .value =3D IPPROTO_UDP, .signedness =3D 0, },<br>
      + .string =3D "_udp",<br>
      + },<br>
      + [6] =3D {<br>
      + .start =3D { .value =3D IPPROTO_UDP + 1, .signedness =3D 0, },<br>
      .end =3D { .value =3D 255, .signedness =3D 0, },<br>
      .string =3D "_unknown",<br>
      },<br>
      @@ -169,6 +282,16 @@ static struct lttng_enum_entry
      transport_enum_entries[] =3D {<br>
      .end =3D { .value =3D TH_TCP, .signedness =3D 0, },<br>
      .string =3D "_tcp",<br>
      },<br>
      + [2] =3D {<br>
      + .start =3D { .value =3D TH_UDP, .signedness =3D 0, },<br>
      + .end =3D { .value =3D TH_UDP, .signedness =3D 0, },<br>
      + .string =3D "_udp",<br>
      + },<br>
      + [3] =3D {<br>
      + .start =3D { .value =3D TH_ICMP, .signedness =3D 0, },<br>
      + .end =3D { .value =3D TH_ICMP, .signedness =3D 0, },<br>
      + .string =3D "_icmp",<br>
      + },<br>
      };<br>
      static const struct lttng_enum_desc transport_header_type =3D {<br>
      @@ -510,15 +633,32 @@
      LTTNG_TRACEPOINT_EVENT_CLASS(net_dev_template,<br>
      ctf_integer_type(unsigned char, th_type)<br>
      /* Copy the transport header. */<br>
      - if (th_type =3D=3D TH_TCP) {<br>
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
      <pre class=3D"moz-signature">--=20
2.17.1

</pre>
    </div>
 =20
<br>_______________________________________________<br>lttng-dev mailing li=
st<br>lttng-dev@lists.lttng.org<br>https://lists.lttng.org/cgi-bin/mailman/=
listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker=3D=
"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http=
://www.efficios.com</div></div></body></html>
--=_0ff169d0-142e-4be9-ab8e-4dd6aa188325--

--===============2951255088393383298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2951255088393383298==--
