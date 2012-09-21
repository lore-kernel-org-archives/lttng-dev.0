From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Bug324 patch
Date: Fri, 21 Sep 2012 10:59:00 -0400
Message-ID: <20120921145859.GA29319__2011.12818108431$1348239568$gmane$org@Krystal>
References: <505C7CC5.3030501@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TF4h3-0003yg-JD
	for lttng-dev@lists.lttng.org; Fri, 21 Sep 2012 10:59:01 -0400
Content-Disposition: inline
In-Reply-To: <505C7CC5.3030501@efficios.com>
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
> For the mutt users not getting the attachments :P :D
> 
> https://bugs.lttng.org/attachments/51/pthread_cond_patch.diff

You forgot to take associated cond_mutex around pthread_cond_signal
calls.

Otherwise it looks OK.

Thanks,

Mathieu

> -----BEGIN PGP SIGNATURE-----
> 
> iQEcBAEBCgAGBQJQXHzFAAoJEELoaioR9I02sZYH/A/fc04tZnUCDGOYsOmY8E+g
> JRoxCXdnR43FOUL6xjpsla9eLxUtPRMdN1gRanrnCfboBFAJpTG8Wvb6zhmhsXZa
> OoqdcqfRnDcDunb7sjcqG7HCBxK15qhon08QXNGrgz1XwqZK1so+39h+3LbcHumD
> uF9P02eprfONOhyD2PxBYRhn0dIQ/VEoBntel+Jvm0dZjQ6xWErLJATa/XojuteH
> ZbMkXJITshu6d00lhMn8cHdAZObhSuqUgxhIfcsAoG4E8ZkaSNCOFuv96jyrQTdp
> BXCQfZb9UAvyOETb9z8MFDFQnvOxeXepea0B5RDiImupnx7R6+QDEQcuPvx0eHo=
> =ECat
> -----END PGP SIGNATURE-----

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
