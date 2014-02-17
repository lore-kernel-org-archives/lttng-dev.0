From: Karim Yaghmour <karim.yaghmour@opersys.com>
Subject: Re: [RFC PATCH lttng-modules] LTTng logger ABI
Date: Mon, 17 Feb 2014 10:09:37 -0500
Message-ID: <53022631.90209__30644.3808753558$1392649852$gmane$org@opersys.com>
References: <1392502096-1900-1-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <karim.yaghmour@opersys.com>) id 1WFPpI-0002nb-Gu
	for lttng-dev@lists.lttng.org; Mon, 17 Feb 2014 10:09:50 -0500
Received: by mail-qc0-f180.google.com with SMTP id i17so24320555qcy.11
	for <lttng-dev@lists.lttng.org>; Mon, 17 Feb 2014 07:09:39 -0800 (PST)
In-Reply-To: <1392502096-1900-1-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


That was quick :)

On 14-02-15 05:08 PM, Mathieu Desnoyers wrote:
> Add a user-space ABI (new file /proc/lttng-logger) to lttng-modules
> which can be written into by any user on the system. The content is
> saved into the kernel trace stream into the "lttng_logger" kernel event.

Nice. I think this would do for the use-case we discussed (i.e. feedback
Android's "ATRACE" events into lttng instead of ftrace's "trace_marker"
file.)

> The content of a single write is written into an lttng_logger event,
> provided the packet size is large enough to store the content. If it is
> not large enough, it won't be logged. However we cannot return any error
> to the caller, since there may be more than one trace session listening
> to this event.

Can we just truncate instead of dropping if the event is too large?

-- 
Karim Yaghmour
CEO - Opersys inc. / www.opersys.com
http://twitter.com/karimyaghmour
