From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] LTTng logger ABI
Date: Tue, 18 Feb 2014 00:22:39 +0000 (UTC)
Message-ID: <200800140.26414.1392682959643.JavaMail.zimbra__12564.6044304178$1392683013$gmane$org@efficios.com>
References: <1392671512-9136-1-git-send-email-mathieu.desnoyers@efficios.com>
	<5302A3F1.6090508@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WFYSP-00077N-Fz
	for lttng-dev@lists.lttng.org; Mon, 17 Feb 2014 19:22:49 -0500
In-Reply-To: <5302A3F1.6090508@opersys.com>
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
> From: "Karim Yaghmour" <karim.yaghmour@opersys.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Monday, February 17, 2014 7:06:09 PM
> Subject: Re: [PATCH] LTTng logger ABI
> 
> 
> On 14-02-17 04:11 PM, Mathieu Desnoyers wrote:
> > Add a user-space ABI (new file /proc/lttng-logger) to lttng-modules
> > which can be written into by any user on the system. The content is
> > saved into the kernel trace stream into the "lttng_logger" kernel event.
> > 
> > The content of a single write is written into an lttng_logger event.
> > The write count is truncated to 1024 bytes (if larger), which is much
> > smaller than the smallest subbuffer size available (4096 bytes). This
> > ensures all written data makes it into the active tracing buffers.
> 
> Very nice. Let me know when this is in so that I can schedule giving it
> a try on Android.

I plan to merge it into master right after LTTng 2.4 final is released, which
should be in a matter of days. Stay tuned! :)

Thanks,

Mathieu

> 
> --
> Karim Yaghmour
> CEO - Opersys inc. / www.opersys.com
> http://twitter.com/karimyaghmour
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
