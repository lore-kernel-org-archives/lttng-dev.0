From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH liburcu] urcu-bp: introduce
 urcu_bp_disable_sys_membarrier()
Date: Fri, 22 Nov 2019 14:05:07 -0500 (EST)
Message-ID: <833314385.1100.1574449507763.JavaMail.zimbra__30108.6577515647$1574449524$gmane$org@efficios.com>
References: <20191122170040.23250-1-mathieu.desnoyers@efficios.com>
 <173739689.937.1574442178071.JavaMail.zimbra@efficios.com>
 <CADYdroNm8E6O2dWMzSsBPh3Hg12KO66kMPhqkyBWoAjgraFexg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 47KQq83l6vz1SBp
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 14:05:08 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 418D0411EC3
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 14:05:08 -0500 (EST)
In-Reply-To: <CADYdroNm8E6O2dWMzSsBPh3Hg12KO66kMPhqkyBWoAjgraFexg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Norbert Lange <nolange79@gmail.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>
List-Id: lttng-dev@lists.lttng.org

----- On Nov 22, 2019, at 1:37 PM, Norbert Lange nolange79@gmail.com wrote:

> I still would like to propose having a compile time "off switch",
> cant see how this would work with preloaded libraries for one
> (lttng itself whips with multiple)

One option would be to introduce an environment variable that would
control this.

> 
> Cant tell for sure now, but a setup where "bulletproof Xenomai"
> libraries are used seems to better than special setup magic.
> If you have to do do alot measurements for finding rare hiccups,
> the last thing you want it figuring out you forget one config.

Indeed. I'm not sure what's the best way forward however.

Thanks,

Mathieu

> 
> Thanks for the speedy support, Norbert

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
