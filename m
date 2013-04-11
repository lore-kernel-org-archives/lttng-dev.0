From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: [RFC lttng-tools] Snapshot
Date: Thu, 11 Apr 2013 11:41:48 -0400
Message-ID: <5166D9BC.6050201__14234.8043773838$1365694945$gmane$org@efficios.com>
References: <5166D3DB.1000904@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([194.250.102.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1UQJdN-0000PK-PQ
	for lttng-dev@lists.lttng.org; Thu, 11 Apr 2013 11:41:57 -0400
In-Reply-To: <5166D3DB.1000904@efficios.com>
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

Hi,

> Hi everyone,
> 
> This is the initial RFC for snapshot in lttng-tools. Once accepted, it
> will be available in "doc/proposals/0006-lttng-snapshot.txt".
> 
> Any questions, comments or fixes are VERY welcome. There are probably
> English mistakes so feel free to point it out to me.

It looks good, just a few comments :

For the add-output command, I think we discussed adding the --max-size
parameter as well to limit the size of the snapshots written to this output.

For the "lttng snapshot record", I think the options should allow to
specify -C/-D also since we can specify an URL.

"This is a blocking call meaning that it will return only if the
snapshot is completed" --> "only when the snapshot is completed or an
error is returned"

"For now, no-wait is not supported by we keep" --> "but we"

Since it will block the caller, should we add a timeout parameter to
lttng_snapshot_record ?

Thanks,

Julien
