From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC] LTTng address API proposal v3
Date: Tue, 7 Aug 2012 15:19:15 -0400
Message-ID: <20120807191915.GB454__46095.8899152049$1344367182$gmane$org@Krystal>
References: <502167DF.5000806@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SypJF-000888-0F
	for lttng-dev@lists.lttng.org; Tue, 07 Aug 2012 15:19:17 -0400
Content-Disposition: inline
In-Reply-To: <502167DF.5000806@efficios.com>
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
> After a discussion with Mathieu and Yannick, here is some big changes.
> 
> I hope I did not forget anything important.
> 
> Cheers!
> David
> -----BEGIN PGP SIGNATURE-----
> 
> iQEcBAEBCgAGBQJQIWfcAAoJEELoaioR9I02SAkH/iic+EYwOs5dw0X+yS37sBrp
> rbP8VHm+v7OP4Lc+x84pfHBnz0pk5qM7MN5/lmMpRfRwCiYNW8CbxC13V5Au6UgC
> PsNQdZGduVb56xmB5zhV1cD1laiU2W+0vdQzahIN0YDDZowYa6uJda9yjav/b6z8
> +duI2Zuw9NPOUnIDCSIpb3hKA4NZIZFsQGn+/IToikqWyRt/4wwiufaZNtlC85/w
> C0pGJL/9TBTY4rFmyZ/e19lJRUoNEygrFRRoJb5qxKWH5nHvfRXdFGw78xjDgim7
> g9AvrWZ7g73KZaS7LEpmAcofgRicWafIMd0+jUXv0MMrj3NeT/xD66UbtcUusl8=
> =jRvr
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
> 		* Remove lttng_create_session_addr
> 		* Describe URL string format
> 		* Add set_consumer_url examples
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
> In order NOT to expose the new lttng_uri structure used to identify trace
> location for lttng consumer, the public API will only use string address where
> it will be converted in a lttng_uri and sent to the session daemon.
> 
> [*] Create session:
> 
> With the introduction of the enable-consumer command used for network
> streaming, the create session command has been modified so the user could
> define a consumer location either on the network or local with the command.
> 
> This does NOT change the current API call but rather simply rename _path_ to
> _url_ and how it is used in the lttng-ctl library.
> 
> Call changed from:
> --> lttng_create_session(const char *name, const char *path);
> 
> To:
> --> lttng_create_session(const char *name, const char *url);
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
> If the proto is NOT recognized, the string is considered to be a simple path on
> the local filesystem.

you could specify that it is a path relative to the process CWD (unless
it starts with a /).

> 
> The PATH section is the destination path on the _remote_ host where the trace
> data will be written with the <target_hostname> append after.

The last sentence is not clear (after reading it 2-3 times, it's still
not obvious what it explains).

Simply saying that the PATH is relative to a subdirectory "hostname",
under the remote relayd "virtual" root directory, might be enough.


> The relayd
> defines a default location

... for its virtual root directory...

> if none is given using the -o, --output option. This
> default is at:
> 
> 	* $USER/lttng-traces
> 
> For example, this URL results in writing the trace data in
> "$USER/lttng-traces/<target_hostname>/foo/bar".
> 
> 	* net://hostname/foo/bar
> 
> The PATH part can not be bigger than PATH_MAX (define in limits.h) which is
> 4096 bytes at the time of this proposal. Moreover, "../" is ignored and
> removed. For instance, using "net://localhost/../../" will set the path to the
> default one.
> 
> The <net(6)> protocol has a special case where the user can input two ports
> respectively being the control and data port.
> 
> 	* net://[HOSTNAME|IP][:CTRL_PORT][:DATA_PORT][/PATH]
> 
> If _url_ is not NULL, the lttng_create_session will use two API calls.

If _url_ is not NULL, in addition to creating the session, the
lttng_create_session will use the two following API calls:

> 
> 	1) lttng_set_consumer_url(handle, url);
> 	2) lttng_enable_consumer(handle);
> 
> If _url_ is NULL, then NO consumer is created for this tracing session and
> subsequent calls are needed to set up a consumer (i.e lttng_enable_consumer and
> lttng_set_consumer_url).
> 
> [*] Consumer:
> 
> This call is simply renamed.
> 
> From:
> --> lttng_set_consumer_uri(...)
> 
> To:
> --> lttng_set_consumer_url(struct lttng_handle *handle,
> 				const char *url);
> 
> For both functions (consumer and create), the _url_ will be parsed into a
> lttng_uri in the liblttng-ctl and sent to the session daemon.
> 
> Example:
> 
> 	lttng_set_consumer_url(handle, "net://42.42.42.2");
> 
> 
> With all this, the lttng_uri data structure will NOT be exposed to the public
> API and the user command line interface.

The rest looks good!

Thanks,

Mathieu


> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
