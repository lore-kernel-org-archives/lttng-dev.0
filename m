From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: tracepoint_enabled returns true for disabled
 provider, event
Date: Mon, 16 Sep 2019 16:48:52 -0400
Message-ID: <20190916204852.GA143064__451.05424230627$1568666953$gmane$org@joraj-alpa>
References: <CACU0Kcsfzct94bxY06DoQ4x=H+fuKN5JGi6og94YYptOCmz5FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46XJHs3hM8zqfV
 for <lttng-dev@lists.lttng.org>; Mon, 16 Sep 2019 16:48:57 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id C94372BB4F2
 for <lttng-dev@lists.lttng.org>; Mon, 16 Sep 2019 16:48:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CACU0Kcsfzct94bxY06DoQ4x=H+fuKN5JGi6og94YYptOCmz5FQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Anders Johansson <epkboan@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

In the end this was a problem involving automatic session creation
(configuration) behind the back of Anders.

A "lttng list" helped figure out the problem.

lttng behave as expected.

Cheers

On Sat, Sep 07, 2019 at 02:42:22PM +0200, Anders Johansson wrote:
> Hi
> 
> I troubleshooting a huge application where i experience the problem that
> even if tracepoint_enabled is used i get the huge overhead of formatting
> the output even if then the message is not sent to the lttng buffers.
> 
> The tracepoint loglevel is set to TRACE_INFO using the TRACEPOINT_LOGLEVEL
> macro. I managed to rebuild the application setting the level to
> TRACE_DEBUG instead and then i could print continuously that the
> tracepoint_enabled returned false. If i flip it back to TRACE_INFO
> tracepoint_enabled always returns true, hence do lots of string building
> but then no trace is actually sent off to lttng (which is correct since i
> haven't enabled the tracepoint). Even if i explicitly do disable event on
> the provider and tracepoint the TRACE_INFO tracepoints returns true in
> tracepoint_enabled
> 
> Is this by design that tracepoint_enabled always returns true for
> TRACE_INFO and lower values or is this configurable in any way?
> 
> I am using this inside a docker image running Wind River Linux
> bash-4.3# lttng --version
> lttng (LTTng Trace Control) 2.10.6 - KeKriek - v2.10.6-11-g8fcbf96
> bash-4.3#
> 
> Any advice are welcome!
> //Anders

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Jonathan Rajotte-Julien
EfficiOS
