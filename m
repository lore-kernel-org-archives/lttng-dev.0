From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-modules] LTTng logger ABI
Date: Mon, 17 Feb 2014 16:40:35 +0000 (UTC)
Message-ID: <1299774859.26113.1392655235092.JavaMail.zimbra__44195.4327318401$1392655308$gmane$org@efficios.com>
References: <1392502096-1900-1-git-send-email-mathieu.desnoyers@efficios.com>
	<53022631.90209@opersys.com>
	<1718413437.26031.1392653324422.JavaMail.zimbra@efficios.com>
	<53023536.9050007@opersys.com>
	<1098265448.26099.1392654107038.JavaMail.zimbra@efficios.com>
	<53023832.6010005@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WFRFG-0003aa-Cx
	for lttng-dev@lists.lttng.org; Mon, 17 Feb 2014 11:40:44 -0500
In-Reply-To: <53023832.6010005@opersys.com>
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
> Sent: Monday, February 17, 2014 11:26:26 AM
> Subject: Re: [RFC PATCH lttng-modules] LTTng logger ABI
> 
> 
> On 14-02-17 11:21 AM, Mathieu Desnoyers wrote:
> > I'm seeing here that the event in trace_marker is limited to 1 page (it can
> > cross a page boundary, so ftrace deals with 2 pages at most). It makes
> > sense,
> > since Ftrace's buffers are split into pages.
> > 
> > Its truncation happens here:
> > 
> >         if (cnt > TRACE_BUF_SIZE)
> >                 cnt = TRACE_BUF_SIZE;
> 
> Good to know. So at least we know ftrace truncates by default.
> 
> > The minimum size of sub-buffers (trace packets) LTTng can allocate is a
> > page.
> > However, the available space for event records is slightly less, since we
> > have
> > a packet header at the beginning of the packet. Since the packet header can
> > be extended between LTTng versions, it's hard to say. The space can be
> > slightly less if event contexts are enabled (this can be done dynamically
> > at runtime, per-buffer).
> > 
> > Thoughts ?
> 
> I'd be tempted to say that anything that big should be good enough. But
> from the sounds of it, even doing strlen's in user-space wouldn't be
> good enough to ensure that the data fits in lttng buffer. I can't say
> that I have a good solution here. Ideally there should be some form of
> automatic truncation somewhere without having to go through the expense
> of strlens or the likes.

trace.h:#define TRACE_BUF_SIZE		1024

so actually, ftrace truncates at 1024 bytes. We could very well do the same
within the lttng-logger write() op.

Thoughts ?

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
