From: David Goulet <dgoulet@efficios.com>
Subject: Re: More LTTng problems
Date: Fri, 17 Aug 2012 11:15:46 -0400
Message-ID: <502E6022.60208__26433.3335952417$1345216580$gmane$org@efficios.com>
References: <CAGya9MmuQi2U6sneqEPwWUrF=1rNNA-zE9yrfneGZ6QBZhBeTg@mail.gmail.com>
	<20120817150806.GA15919@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1T2OH7-0005XI-OG
	for lttng-dev@lists.lttng.org; Fri, 17 Aug 2012 11:15:49 -0400
In-Reply-To: <20120817150806.GA15919@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: =?ISO-8859-1?Q?Daniel_Fle?= =?ISO-8859-1?Q?mstr=F6m?= <daniel.flemstrom@mdh.se>, lttng-dev@lists.lttng.org, Stefan Karlsson S12 <skn07007@student.mdh.se>, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi,

Actually, this error means that a problem occurred *during* the 32 bit
consumer spawning process... It seems the binary was found but failed
to exec it.

Running the session daemon (lttng-sessiond) with options "-vvv
- --verbose-consumer" will help us pin down the problem.

Send me back the output, I'll be able to tell you what's going on (and
also the series of command you guys did before the enable-event).

Last thing, make sure the lttng-consumerd did not segfault (dmesg) or
any other lttng-tools component.

Thanks!
David

Mathieu Desnoyers:
> It looks like you did not build a 32-bit consumer. I'm ccing David 
> Goulet, maintainer of lttng-tools.
> 
> Thanks,
> 
> Mathieu
> 
> * Henrik Hautakoski (henrik@fiktivkod.org) wrote:
>> Hi. got lttng working now. but when given the following command,
>> we get an error.
>> 
>> $ lttng enable-event -a -u Error: Events: 32-bit UST consumer
>> start failed (channel channel0, session mysession)
>> 
>> Could not find any information about this error massage. do you
>> have any ideas?
>> 
>> -- Henrik Hautakoski henrik@fiktivkod.org
> 
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQLmAfAAoJEELoaioR9I02rqEH/2w2QXXmpLE0iEYnl2FMrfYq
5e6p0TH1Qb4NSKvyAuSOfFJYWpNXjAKKDC/ajUuEH5PZiFtPZqiNK/jQQcTwns9t
dwZb1WSLm4Ue5z7jRV3yk8Gae/IaFQqbS5l3tTdKkE7rFOVO9Iew5+BPORHtBYA3
Bvmx9CcwxeOVizKMab5Y0JK9RbuFcnurUV33tUI9DAisloutrItm84GdKyE5wZ92
mXaneN+a0PhI68GsAmBq7dJMdjo+XABurr8oVL/kdWvUo8T1Sn298b5ki+se4zLL
kIfAXv7x+5K8tp6jnXznG6COsjbxf7Zt3nXouyled+oKr7muhGBDi5ul1r3W9IM=
=p8bq
-----END PGP SIGNATURE-----
