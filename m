From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: events injection / merging traces
Date: Thu, 4 Jul 2019 10:52:26 -0400
Message-ID: <20190704145226.GB9334__36228.5551776708$1562252017$gmane$org@joraj-alpa>
References: <ed6a7951-d2eb-71ff-be87-dcdb07be7881@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45fgtn5z6tz10Bv
 for <lttng-dev@lists.lttng.org>; Thu,  4 Jul 2019 10:52:33 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 06F6C265771
 for <lttng-dev@lists.lttng.org>; Thu,  4 Jul 2019 10:52:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <ed6a7951-d2eb-71ff-be87-dcdb07be7881@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Carlo Caione <carlo.caione@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Carlo,

On Wed, Jul 03, 2019 at 01:30:58PM +0100, Carlo Caione wrote:
> Hi,
> is there an easy way to "inject" new events in a LLTng trace? (you can also
> read that as: is there an easy way to merge two LLTng traces?).

Injecting would be possible using a plugin (C or python) in babeltrace 2.

> 
> I see that I can use [python] babeltrace.TraceCollection() + add_trace() to
> merge multiple traces, but it seems that I cannot output the resultant
> merged trace again as CTF.

Babelrace 2 does have a default plugin for outputting to CTF but the result
might not be the one you expect. If you have two CTF traces as sources, two CTF
traces will be outputted by the current CTF sink. This is done for multiple
reasons.

The major one is that there is multiple places where clashes (stream class,
event) can happen (IDs etc.). The easy solution would be to generate new IDs but
it might lead to confusion as to why the IDs of an input trace are not found in
a resulting merge of traces or at least not the "expected" one.

There is a special case where all input traces are chunk of the same tracing
session (lttng-tools 2.11 rotation feature) since we have a guaranteed to have
no clash.

People who are more familiar with CTF,please do not restrain yourself on correcting me
here.

From what I understand, not much would prevent someone that knows the tradeoff
to implement such merging plugin. It simply does not exists today.

It also depends on what you mean by a single CTF trace.

This leads to, as always, whats is the end goal here?

Cheers
-- 
Jonathan Rajotte-Julien
EfficiOS
