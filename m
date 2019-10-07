From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: two tracepoints header files of one provider
Date: Mon, 7 Oct 2019 12:22:19 -0400 (EDT)
Message-ID: <625499791.2728.1570465339442.JavaMail.zimbra__10335.7583911688$1570465355$gmane$org@efficios.com>
References: <CACJEY85GRrq=dHRfbnvuRqAgP_cF-ErWn4k3vK=DtCH6QvxSdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 46n5NX3QgLz17H0
 for <lttng-dev@lists.lttng.org>; Mon,  7 Oct 2019 12:22:20 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 00F4924638E
 for <lttng-dev@lists.lttng.org>; Mon,  7 Oct 2019 12:22:20 -0400 (EDT)
In-Reply-To: <CACJEY85GRrq=dHRfbnvuRqAgP_cF-ErWn4k3vK=DtCH6QvxSdQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yonghong Yan <yanyh15@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org



----- On Oct 7, 2019, at 9:59 AM, Yonghong Yan yanyh15@gmail.com wrote:

> For lttng-ust, can I put the tracepoint definition in two files, but they use
> the same provider.

Based on the terminology here: https://lttng.org/docs/v2.10/#doc-tracing-your-own-user-application

You need to have at most one instance of your tracepoint provider where
the header is included with TRACEPOINT_CREATE_PROBES, and exactly one
instance where TRACEPOINT_DEFINE is defined. (both can end up being within
the same object if you wish).

Then you can include your tracepoint provider header file at will across
other compile units in your program. Just make sure none of 
TRACEPOINT_CREATE_PROBES nor TRACEPOINT_DEFINE are defined in those other
compile units. You can therefore call tracepoints from a given probe from
various compile units in your program.

Hoping this helps clarifying things,

Mathieu

> Thank you.
> Yonghong

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
