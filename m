From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Support for large files
Date: Sat, 30 Jun 2012 14:13:13 -0400
Message-ID: <20120630181313.GA30747__11626.4937482358$1341080038$gmane$org@Krystal>
References: <524C960C5DFC794E82BE548D825F05CF28348826@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Sl2AV-0004Ql-Se
	for lttng-dev@lists.lttng.org; Sat, 30 Jun 2012 14:13:15 -0400
Content-Disposition: inline
In-Reply-To: <524C960C5DFC794E82BE548D825F05CF28348826@EU-MBX-01.mgc.mentorg.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Oestman, Fredrik" <Fredrik_Oestman@mentor.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Oestman, Fredrik (Fredrik_Oestman@mentor.com) wrote:
> Hi,
> =

> We've run into a problem when attempting to produce large traces on a 32-=
bit machine. =

> =

> This is the console output:
> =

> Session met-2012-06-15_16-09-25 created.
> Traces will be written in /home/nasir/lttng-traces/met-2012-06-15_16-09-2=
5-20120615-160925
> UST channel met_tools enabled for session met-2012-06-15_16-09-25
> UST event met_func:* created in channel met_tools
> UST event met_call:* created in channel met_tools
> Tracing started for session met-2012-06-15_16-09-25
> Ackermann: Jun 15 2012 16:01:06
> Error: Error writing to tracefile
> Tracing stopped for session met-2012-06-15_16-09-25
> Session met-2012-06-15_16-09-25 destroyed
> =

> This is the trace directory (from another, identical run):
> =

> -rwxrwxrwx 1 nasir nasir       4096 2012-06-18 18:38 metadata*
> -rwxrwxrwx 1 nasir nasir          0 2012-06-18 18:38 met_tools_0*
> -rwxrwxrwx 1 nasir nasir          0 2012-06-18 18:38 met_tools_1*
> -rwxrwxrwx 1 nasir nasir 2147483647 2012-06-18 18:40 met_tools_2*
> -rwxrwxrwx 1 nasir nasir          0 2012-06-18 18:38 met_tools_3*
> =

> That the application runs on one core only is expected. The file size is =
2 GiB - 1, which
> is the limit for 32-bit file offset variables.
> =

> On 64-bit machines, the problem doesn't occur.
> =

> Is this problem known?

Good catch. I guess we did not test enough on 32-bit. It's fixed on the
lttng-tools master branch by commit:

commit c72b7d965eb65a9f49a5615cac731cec3082aa7f
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri Jun 29 12:40:30 2012 +0200

    Fix: support large files on 32-bit systems
    =

    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

it should make its way into stable-2.0 branch soon.

By the way, babeltrace has the same issue, but we need to switch from
fts.h back to ftw.h to fix that, since fts.h does not support LFS.

Thanks,

Mathieu

> =

> We are using lttng-ust 2.0.1 and userspace-rcu 0.6.7.
> =

> =

> Cheers,
> =

> Fredrik =D6stman
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
