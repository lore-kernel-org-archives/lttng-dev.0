From: David Goulet <dgoulet@efficios.com>
Subject: Re: [RFC lttng-tools] Snapshot
Date: Thu, 11 Apr 2013 12:14:34 -0400
Message-ID: <5166E16A.2070107__14965.1293097579$1365696905$gmane$org@efficios.com>
References: <5166D3DB.1000904@efficios.com> <5166D9BC.6050201@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UQK8y-0000iC-Tr
	for lttng-dev@lists.lttng.org; Thu, 11 Apr 2013 12:14:37 -0400
In-Reply-To: <5166D9BC.6050201@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


Julien Desfossez:
> Hi,
> 
>> Hi everyone,
>>
>> This is the initial RFC for snapshot in lttng-tools. Once accepted, it
>> will be available in "doc/proposals/0006-lttng-snapshot.txt".
>>
>> Any questions, comments or fixes are VERY welcome. There are probably
>> English mistakes so feel free to point it out to me.
> 
> It looks good, just a few comments :
> 
> For the add-output command, I think we discussed adding the --max-size
> parameter as well to limit the size of the snapshots written to this output.

Yup I forgot to add it.

> 
> For the "lttng snapshot record", I think the options should allow to
> specify -C/-D also since we can specify an URL.

Yup!

> 
> "This is a blocking call meaning that it will return only if the
> snapshot is completed" --> "only when the snapshot is completed or an
> error is returned"

Fixed

> 
> "For now, no-wait is not supported by we keep" --> "but we"

Fixed

> 
> Since it will block the caller, should we add a timeout parameter to
> lttng_snapshot_record ?

That would probably be a timer on the session daemon side and the health
check would be the thing to use to monitor if the session daemon is stuck.

On the client side, the problem is that we have NO way of knowing what
will be the duration of the operation

I'll send the second version soon with jgalar fixes.

Thanks!
David

> 
> Thanks,
> 
> Julien
