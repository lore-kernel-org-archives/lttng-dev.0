From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Add UDP and ICMP packet
 header information to the tracepoint:
Date: Mon, 9 Mar 2020 11:28:01 -0400 (EDT)
Message-ID: <1568442012.21567.1583767681155.JavaMail.zimbra@efficios.com>
References: <20191113163814.31606-1-walbroel@silexica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 48bhtv2fb6z1DRm
 for <lttng-dev@lists.lttng.org>; Mon,  9 Mar 2020 11:28:07 -0400 (EDT)
In-Reply-To: <20191113163814.31606-1-walbroel@silexica.com>
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

----- On Nov 13, 2019, at 11:38 AM, Florian Walbroel walbroel@silexica.com wrote:

> * UDP transport header
> * ICMP transport header
> 
> (Correct indentation for switch/case)

Hi Florian,

Please address the additional comments below,

[...]
> 
> +static inline enum transport_header_types __get_transport_header_type_ip(struct
> sk_buff *skb)
> +{
> +	switch(ip_hdr(skb)->protocol) {

this should be:

  switch (ip_hdr(skb)->protocol) {

> +	case IPPROTO_TCP:
> +		return TH_TCP;
> +	case IPPROTO_UDP:
> +		return TH_UDP;
> +	case IPPROTO_ICMP:
> +		return TH_ICMP;
> +	}
> +	return TH_NONE;
> +}
> +
> +static inline enum transport_header_types
> __get_transport_header_type_ipv6(struct sk_buff *skb)
> +{
> +	switch(ipv6_hdr(skb)->nexthdr) {

And this:

  switch (ipv6_hdr(skb)->nexthdr) {

> +	case IPPROTO_TCP:
> +		return TH_TCP;
> +	case IPPROTO_UDP:
> +		return TH_UDP;
> +	case IPPROTO_ICMP:
> +		return TH_ICMP;
> +	}
> +	return TH_NONE;
> +}
> +

[...]


> 
> static const struct lttng_enum_desc transport_header_type = {
> @@ -510,15 +633,32 @@ LTTNG_TRACEPOINT_EVENT_CLASS(net_dev_template,
> 					ctf_integer_type(unsigned char, th_type)
> 
> 					/* Copy the transport header. */
> -					if (th_type == TH_TCP) {
> +					switch (th_type) {
> +					case TH_TCP: {
> 						ctf_align(uint32_t)
> 						ctf_array_type(uint8_t, tcp_hdr(skb),
> 								sizeof(struct tcphdr))
> +						break;
> +					}
> +					case TH_UDP: {
> +						ctf_align(uint32_t)
> +						ctf_array_type(uint8_t, udp_hdr(skb),
> +								sizeof(struct udphdr))
> +						break;
> +					}
> +					case TH_ICMP: {
> +						ctf_align(uint32_t)
> +						ctf_array_type(uint8_t, icmp_hdr(skb),
> +								sizeof(struct udphdr))
> +						break;

Shouldn't this be "sizeof(struct icmphdr)" ?

By looking at their definitions they appear to be the same size by chance,
but it's good to have the right type here.

After a last respin of the patch, we should be good to merge.

Thanks,

Mathieu


> +					}
> +					default:
> +						/*
> +						* For any other transport header type,
> +						* there is nothing to do.
> +						*/
> +						break;
> 					}
> -					/*
> -					 * For any other transport header type,
> -					 * there is nothing to do.
> -					 */
> 				}
> 			)
> 		)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
