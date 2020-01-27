From: Alex Xu via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: [PATCH 2/2] Use _umtx_op for futex on FreeBSD
Date: Mon, 27 Jan 2020 19:43:12 +0000
Message-ID: <158015419247.63624.10811906339754275924@pink>
References: <20200127182526.22881-1-alex_y_xu@yahoo.ca>
 <20200127182526.22881-2-alex_y_xu@yahoo.ca>
 <1117636152.600695.1580150904852.JavaMail.zimbra@efficios.com>
Reply-To: Alex Xu <alex_y_xu@yahoo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from sonic309-21.consmr.mail.gq1.yahoo.com
 (sonic309-21.consmr.mail.gq1.yahoo.com [98.137.65.147])
 by lists.lttng.org (Postfix) with ESMTPS id 4860Xl5LHgz1xYF
 for <lttng-dev@lists.lttng.org>; Mon, 27 Jan 2020 14:43:19 -0500 (EST)
In-Reply-To: <1117636152.600695.1580150904852.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Quoting Mathieu Desnoyers (2020-01-27 18:48:24)
> Please move the futex_noasync definition after futex_async, considering that
> futex_noasync uses futex_async().

Oops. Fixed that when testing but didn't copy it back to my local copy.

> Also, do you have a link to the API documentation of _umtx_op() ?
> I would like to double-check that all its return values are
> expected by the callers.

https://www.freebsd.org/cgi/man.cgi?query=_umtx_op

I took a look at the man page, the only "interesting" one is EINTR, but
that's the same as Linux.

https://gitlab.freedesktop.org/mesa/mesa/blob/master/src/util/futex.h
doesn't adjust the errno, but it does fiddle with the timeout. I will
add that in the next version.
