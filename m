From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] LTTng logger ABI
Date: Tue, 11 Mar 2014 01:28:35 +0000 (UTC)
Message-ID: <495653591.35195.1394501315562.JavaMail.zimbra__10901.8426658169$1394501360$gmane$org@efficios.com>
References: <1392671512-9136-1-git-send-email-mathieu.desnoyers@efficios.com>
	<5302A3F1.6090508@opersys.com>
	<200800140.26414.1392682959643.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WNBUh-0006Ca-HD
	for lttng-dev@lists.lttng.org; Mon, 10 Mar 2014 21:28:36 -0400
In-Reply-To: <200800140.26414.1392682959643.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Karim Yaghmour <karim.yaghmour@opersys.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org



----- Original Message -----
> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> To: "Karim Yaghmour" <karim.yaghmour@opersys.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Monday, February 17, 2014 7:22:39 PM
> Subject: Re: [lttng-dev] [PATCH] LTTng logger ABI
> 
> ----- Original Message -----
> > From: "Karim Yaghmour" <karim.yaghmour@opersys.com>
> > To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> > Cc: lttng-dev@lists.lttng.org
> > Sent: Monday, February 17, 2014 7:06:09 PM
> > Subject: Re: [PATCH] LTTng logger ABI
> > 
> > 
> > On 14-02-17 04:11 PM, Mathieu Desnoyers wrote:
> > > Add a user-space ABI (new file /proc/lttng-logger) to lttng-modules
> > > which can be written into by any user on the system. The content is
> > > saved into the kernel trace stream into the "lttng_logger" kernel event.
> > > 
> > > The content of a single write is written into an lttng_logger event.
> > > The write count is truncated to 1024 bytes (if larger), which is much
> > > smaller than the smallest subbuffer size available (4096 bytes). This
> > > ensures all written data makes it into the active tracing buffers.
> > 
> > Very nice. Let me know when this is in so that I can schedule giving it
> > a try on Android.
> 
> I plan to merge it into master right after LTTng 2.4 final is released, which
> should be in a matter of days. Stay tuned! :)

The feature is now pushed into the master branch:

commit 0c95667685cf8612eb0d231883874c173b7bb5a1
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Sat Feb 15 16:59:09 2014 -0500

    LTTng logger ABI

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
> > 
> > --
> > Karim Yaghmour
> > CEO - Opersys inc. / www.opersys.com
> > http://twitter.com/karimyaghmour
> > 
> > 
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
