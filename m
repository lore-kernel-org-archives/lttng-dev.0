From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: state tracking and missing statedump end
Date: Fri, 15 May 2015 20:05:18 +0000 (UTC)
Message-ID: <681973618.2393.1431720318705.JavaMail.zimbra__17608.353161677$1431720378$gmane$org@efficios.com>
References: <1361850761.1447.1431642954186.JavaMail.zimbra@efficios.com>
 <55564EDF.2070201@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YtLrB-0007sO-F8
 for lttng-dev@lists.lttng.org; Fri, 15 May 2015 16:05:21 -0400
In-Reply-To: <55564EDF.2070201@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> Hi Mathieu,
> 
> Thanks for the info, good to know!
> 
> However, we (in Trace Compass) don't actually make use of the
> "statedump_end" event. Should we?

Yes, you should.

> 
> For now, we only use the "lttng_statedump_process_state" events in our
> state model. The information contained in these events is applied to the
> state of the involved process. This state becomes valid starting at the
> timestamp of each statedump event.
> 
> What type of information does the "lttng_statedump_end" event implies?

There is some info about the state of processes active at
trace start, or interrupt handlers active at trace start, which
could be impractical to fetch by the statedump events per se. Rather,
we use a rendez-vous which implies that a known kernel thread has been
scheduled on each CPU before we issue the statedump end event.
Having this quiescent state allows to fixup some unknown state
that might still be unknown at statedump end.

I recommend you look at lttv state.c fix_process().

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
