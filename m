From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng-track by process/thread name
Date: Thu, 21 Mar 2019 13:24:28 -0400 (EDT)
Message-ID: <1605809789.5592.1553189068794.JavaMail.zimbra__7339.07678384043$1553189090$gmane$org@efficios.com>
References: <2888384.MPZEDsI9Ek@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44QDDZ5cKZz18WC
 for <lttng-dev@lists.lttng.org>; Thu, 21 Mar 2019 13:24:30 -0400 (EDT)
In-Reply-To: <2888384.MPZEDsI9Ek@milian-kdab2>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Mar 21, 2019, at 12:21 PM, lttng-dev lttng-dev@lists.lttng.org wrote:

> Hey all,
> 
> I stumbled upon lttng-track which sounds quite useful when one wants to
> concentrate on the events of a single process. But how is one supposed to use
> this? Usually, I start lttng before I start my application - I thus don't know
> the PID yet. Is there a trick that I'm not aware of, or can it really only be
> used to track after starting an application?

At the moment, you need to know which PID you want to track.

I have a prototype using ptrace to do something similar to

strace --follow-children /path/to/executable

but I only had time to do the underlying plumbing. All the user interface
needs to be designed and implemented. If you are interested to look into this
I could dig out my prototype branch.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
