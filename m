From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: instrumenting "tutorial" and RTAI
Date: Wed, 26 Nov 2014 13:35:36 -0500
Message-ID: <CAB4xu_0O3WBpfjmjBUqC5qhC0APgrH4TdQAGG0=-9bYd1jwrGg__30305.213519796$1417027016$gmane$org@mail.gmail.com>
References: <20141126165911.Horde.4rlxIiNzywrWTD0eXzfFsQ1@secure.et-inf.fho-emden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f51.google.com ([209.85.215.51])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1XthRk-0002NV-KM
 for lttng-dev@lists.lttng.org; Wed, 26 Nov 2014 13:36:15 -0500
Received: by mail-la0-f51.google.com with SMTP id ms9so2920842lab.24
 for <lttng-dev@lists.lttng.org>; Wed, 26 Nov 2014 10:36:06 -0800 (PST)
In-Reply-To: <20141126165911.Horde.4rlxIiNzywrWTD0eXzfFsQ1@secure.et-inf.fho-emden.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: fmahn@technik-emden.de
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Wed, Nov 26, 2014 at 11:59 AM,  <fmahn@technik-emden.de> wrote:
>
> Hello, right now I am reading the LTTng documentation and I am at the point
> with the "tutorial" for adding a tracepoint to the usb_probe_device(). I
> updated the files as instructed, rebuilt the kernel and bootet it, but the
> "/sys/kernel/debug/tracing/events/hello" directory wasnt created. It exists
> up to the debug directory, but the directory itself is empty. What could
> have gone wrong? Is this directory necessary? I still followed the other
> instructions and I was able to trace the USB event but I am curios about the
> directory.

No, this directory is not needed for LTTng to work, as you noticed yourself.
It's only a simple way to confirm your kernel TRACE_EVENT() tracepoints
exist using Ftrace. My guess is that debugfs is not mounted (usually mounted
at /sys/kernel/debug) on your system. But do not waste your time fixing
this, as you're able to record USB events with LTTng.

> Furthermore, I am planning to instrument an RTAI kernel (for my
> Bachelorthesis), so I can trace it with LTTng. Is it even possible with
> these methods?

I'll let others answer this as I never had the chance to have fun with RTAI ;-)

>
> Thank you for your time!
>
> PS:
> I am using an RTAI patched 2.6.38.8 linux kernel with debian
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
