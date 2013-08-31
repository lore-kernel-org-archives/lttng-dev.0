From: Francis Giraldeau <francis.giraldeau@gmail.com>
Subject: Re: [RFC] User space stack trace on system calls
Date: Fri, 30 Aug 2013 23:59:59 -0400
Message-ID: <52216A3F.8000200__27260.7979168699$1377921652$gmane$org@gmail.com>
References: <52216536.40709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f41.google.com ([209.85.128.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <francis.giraldeau@gmail.com>) id 1VFcM6-0004jK-9v
	for lttng-dev@lists.lttng.org; Sat, 31 Aug 2013 00:00:14 -0400
Received: by mail-qe0-f41.google.com with SMTP id ff1so1706792qeb.28
	for <lttng-dev@lists.lttng.org>; Fri, 30 Aug 2013 21:00:04 -0700 (PDT)
In-Reply-To: <52216536.40709@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 2013-08-30 23:38, Francis Giraldeau wrote :
> We actually
> found a way to insert code inside the probe with code blocks that
> returns a value. Thanks to Simon Marchi for this C trick!

Well, it turns out that the function save_stack_trace_user() is called
even when the tracepoint is not enabled, so this is a major issue.
Hum... Then why does it work for UST tracepoint macro?

Cheers,

Francis
