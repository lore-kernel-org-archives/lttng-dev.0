From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC] LTTng address API proposal v2
Date: Tue, 7 Aug 2012 12:25:29 -0400
Message-ID: <20120807162529.GA31399__37974.885691847$1344356756$gmane$org@Krystal>
References: <50213DDE.8070709@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Symb4-0006nW-W9
	for lttng-dev@lists.lttng.org; Tue, 07 Aug 2012 12:25:31 -0400
Content-Disposition: inline
In-Reply-To: <50213DDE.8070709@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> Here is the second and updated version after Yannick comments.
> 
>     - v0.2: 07/08/0212
>         * Change lttng_create_session_addr to lttng_create_session_url
>         * Describe URL string format
>         * Add set_consumer_url examples
>         * Add the HOP option to the set_consumer_url function
> 
> Cheers!
> David
> -----BEGIN PGP SIGNATURE-----
> 
> iQEcBAEBCgAGBQJQIT3aAAoJEELoaioR9I02vqIH/1YeAlh+ogt1wvRv3bkExZB6
> vywtNVUVx/ys7KgaqkRolvGmbBKZEMPTwXaiGXDSfbij9hgkLvpjNhc26c9b443r
> 9GJ603Jn+PPEa/vOMBPY8sqxGKyKLoSL400sXNLhPo2t18+neWOLDhgcfXd4VIT7
> FgmOQzUQZsImFNGJUTNSFKD7m/NM73F7pM8VG1OjXfOfNAb1KtoV6QYSApoAayQ+
> g2XdPgsAkDQssh82xLQ0Ousg3Cpk72e/jyroUNNnT8Dy7rSTXLsLz7indBzfFoAw
> cIzTwREbarYT7cEbNnH0oFRxUK/94MEPjeWd2cSNJxsaidYj9mD07ST9UWfputU=
> =GYy5
> -----END PGP SIGNATURE-----

> RFC - LTTng address API proposal
> 
> Author: David Goulet <david.goulet@efficios.com>
> 
> Contributors:
>     * Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 	* Yannick Brosseau <yannick.brosseau@polymtl.ca>
> 
> Version:
>     - v0.1: 31/07/2012
>         * Initial proposal
> 	- v0.2: 07/08/0212
> 		* Change lttng_create_session_addr to lttng_create_session_url
> 		* Describe URL string format
> 		* Add set_consumer_url examples
> 		* Add the HOP option to the set_consumer_url function
> 
> Introduction
> -----------------
> 
> This document proposes the use of string URLs to the command line interface and
> API which will deprecate a function and propose new ones.
> 
> The purpose of this proposal is to support network streaming using URL string
> format that you can find in proposal doc/proposals/0003-network.consumer.txt,
> remove the lttng_uri structure from the API and integrate the URL string to the
> API.
> 
> API
> -----------------
> 
> In order not to expose the new lttng_uri structure used to identify trace
> location for lttng consumer, the public API will only use string address where
> it will be converted in a lttng_uri and sent to the session daemon.
> 
> [*] Create session:
> 
> With the introduction of the enable-consumer command used for network streaming,
> the create session command has been modified so the user could define a consumer
> location either on the network or local with the command. This change deprecates
> the old API function and adds a new one.
> 
> Current and will be deprecated:
> --> lttng_create_session(const char *name, const char *path);
> 
> Proposed:
> --> lttng_create_session_url(const char *name, const char *url,
> 								int enable_consumer);
> 
> The _name_ argument is the session name and _url_ is a string representing the
> URL specified by the user which is define like so:
> 
> PROTO://[HOSTNAME|IP][:PORT][/PATH]
> 
> The proto supported at this stage are (6 means IPv6):
> 
> 	* net, net6, tcp, tcp6, file
> 
> The PATH section is the destination path on the _remote_ host where the trace
> data will be written. For example:
> 
> 	* net://hostname/foo/bar
> 
> Results in writing the trace data in $USER/lttng-traces/foo/bar where
> "$USER/lttng-traces" is the default output directory set by the lttng-relayd.
> It is possible to change this option.
> 
> The <net(6)> protocol has a special case where the user can input two ports
> respectively being the control and data port.
> 
> 	* net://[HOSTNAME|IP][:CTRL_PORT][:DATA_PORT][/PATH]
> 
> Finally, the enable_consumer option will disable the use of the consumer for

enable_consumer option will disable -> this is backwards. We could say
"allows controlling if enabled/disabled".

> the tracing session. This will be useful with the upcoming snapshot feature.
> The motivation behind this flag is to offer the same options as the
> enable-consumer command where you can only set the URI for the consumer and not
> enable it.
> 
> Note that the hop feature CAN NOT be used with this function call since only
> one URL can be define here.

define -> defined

I wonder if the url arg to lttng_create_session_url could be a
"url_list" ? (comma separated) this would enable specifying hops+dest
with create session.

Thanks,

Mathieu

> 
> [*] Consumer:
> 
> The 2.2+ roadmap will implement the concept of hop for network streaming. This
> hop is basically a proxy daemon which will relay the information to a final
> destination. It is possible to define as many hops as you want but once the
> final destination is set, it's not possible anymore.
> 
> Current and will be deprecated:
> --> lttng_set_consumer_uri(...)
> 
> Proposed:
> --> lttng_set_consumer_url(struct lttng_handle *handle,
> 				const char *url, enum lttng_url_type type);
> 
> For both functions (consumer and create), the _url_ will be parsed into a
> lttng_uri in the liblttng-ctl and sent to the session daemon.
> 
> The _type_ argument is the URL type where the possibilities are:
> 
> enum lttng_url_type {
> 	LTTNG_URL_DST,		/* Final destination */
> 	LTTNG_URL_HOP,		/* HOP destination */
> };
> 
> Example:
> 
> 	set_consumer_url(handle, "net://42.42.42.2", LTTNG_URL_HOP);
> 	set_consumer_url(handle, "net://42.42.42.3", LTTNG_URL_HOP);
> 	set_consumer_url(handle, "net://42.42.42.42", LTTNG_URL_DST);
> 
> 
> With all this, the lttng_uri data structure will not be exposed to the public
> API and the user command line interface.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
