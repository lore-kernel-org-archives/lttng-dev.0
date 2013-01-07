From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: Reading cache misses in Userspace?
Date: Mon, 07 Jan 2013 13:15:20 -0500
Message-ID: <50EB10B8.80703__11200.3075810664$1357582583$gmane$org@gmail.com>
References: <50E8834D.1010802@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1TsHEO-0001av-4X
	for lttng-dev@lists.lttng.org; Mon, 07 Jan 2013 13:15:28 -0500
Received: by mail-ob0-f173.google.com with SMTP id xn12so17981277obc.32
	for <lttng-dev@lists.lttng.org>; Mon, 07 Jan 2013 10:15:22 -0800 (PST)
In-Reply-To: <50E8834D.1010802@gmx.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexander Kampmann <alexander.kampmann@gmx.de>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 2013-01-05 14:47, Alexander Kampmann wrote:
> hey,
>
> I would like to find out which part of my application causes most
> cache misses. So I tried to add userspace events to my application. I
> hoped LTTng would give me some mean of determining between which
> tracepoints the most cache misses occur.
>
> I started a session like that:
>
> sudo lttng create session
> sudo lttng enable-event -a -u
> sudo lttng add-context -u -t perf:LLC-load-misses -t
> perf:LLC-store-misses -t perf:LLC-prefetch-misses
>
> I get:
>
> Error: perf:LLC-prefetch-misses: UST invalid context
> Error: perf:LLC-store-misses: UST invalid context
> Error: perf:LLC-load-misses: UST invalid context
>
> Does this mean I can not add perf:LLC-* context to my userspace
> events? Is there any way to figure out which part of my application
> causes cache misses?
>
> If I use
>
> sudo lttng add-context -k -t perf:LLC-load-misses -t
> perf:LLC-store-misses -t perf:LLC-prefetch-misses
>
> instead, I don't get an error, but the babeltrace output does not
> contain any cache miss counts as well.

This context will be added to kernel events only, so you will need to
active some kernel event to see them.
sudo lttng enable-event -a -k would do the trick. You can also only
activate some events to reduce the size of the trace. The sched* events
and maybe the syscall would be interesting to place the perf counter to
some specific place of the application.

Yannick
