From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-modules] LTTng logger ABI
Date: Mon, 17 Feb 2014 16:08:44 +0000 (UTC)
Message-ID: <1718413437.26031.1392653324422.JavaMail.zimbra__11748.0289809921$1392653436$gmane$org@efficios.com>
References: <1392502096-1900-1-git-send-email-mathieu.desnoyers@efficios.com>
	<53022631.90209@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WFQkW-0003HO-UC
	for lttng-dev@lists.lttng.org; Mon, 17 Feb 2014 11:08:59 -0500
In-Reply-To: <53022631.90209@opersys.com>
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
> Sent: Monday, February 17, 2014 10:09:37 AM
> Subject: Re: [RFC PATCH lttng-modules] LTTng logger ABI
> 
> 
> That was quick :)
> 
> On 14-02-15 05:08 PM, Mathieu Desnoyers wrote:
> > Add a user-space ABI (new file /proc/lttng-logger) to lttng-modules
> > which can be written into by any user on the system. The content is
> > saved into the kernel trace stream into the "lttng_logger" kernel event.
> 
> Nice. I think this would do for the use-case we discussed (i.e. feedback
> Android's "ATRACE" events into lttng instead of ftrace's "trace_marker"
> file.)

Great!

> 
> > The content of a single write is written into an lttng_logger event,
> > provided the packet size is large enough to store the content. If it is
> > not large enough, it won't be logged. However we cannot return any error
> > to the caller, since there may be more than one trace session listening
> > to this event.
> 
> Can we just truncate instead of dropping if the event is too large?

I'd be tempted to ask: is that the behavior of ftrace when receiving an
event larger than a page through trace_marker ?

We could indeed truncate the event, but it would increase complexity
compared to the current patch. So I'm tempted to wait a bit before doing so.

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
