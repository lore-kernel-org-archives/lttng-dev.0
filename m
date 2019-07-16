From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re:
 =?utf-8?b?5Zue5aSNOlJlOiAgUHJvcyBhbmQgQ29ucyBvZiBM?=
 =?utf-8?q?TTng?=
Date: Tue, 16 Jul 2019 11:30:57 -0400
Message-ID: <20190716153057.GC20789__5980.75229661248$1563291081$gmane$org@joraj-alpa>
References: <tencent_512CCCEA391C638F165F4530@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45p49h3DS1z17Kx
 for <lttng-dev@lists.lttng.org>; Tue, 16 Jul 2019 11:31:04 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id AB03F2A7F0F
 for <lttng-dev@lists.lttng.org>; Tue, 16 Jul 2019 11:30:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <tencent_512CCCEA391C638F165F4530@qq.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: =?utf-8?B?5p2o5rW3?= <hai.yang@magic-shield.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> From somewhere, I saw CPU cycles % with LTTng is even 1-2% lower than vanilla.

You might be referring to section 5.3 of [1], last paragraph.

[1] https://www.dorsal.polymtl.ca/en/system/files/desnoyers.pdf

In any cases, there is always an overhead when actively tracing (recording to
disk, network or even in flight recorder mode).

> Is it contributed by dynamic branch prediction or other instruction level
> optimization?

Note that these numbers were for a 2.6.30 kernel. Things might have changed a bit
since. As far as I know, the performance of an instrumented kernel is
independent from lttng since instrumentation of the kernel is a not only used by
lttng but by multiple projects. But it might help system engineers to accept to
turn on instrumentation for their kernel.

Anyhow, the speedup was attributed to the modification to the instruction and
data cache layout.

>In that way, the kernel or at least key libraries like libc is
> kind of re-compiled, right?

lttng-modules does not require any kernel recompilation. It uses kernel modules
to function.

Instrumenting libc directly might not ideal due to its nature. You can use
LD_PRELOAD and lttng-ust to shim and instrument libc function you are interested
in. For example, we already ship a shim for some libc functions [1] that you can
LD_PRELOAD.

[1] https://github.com/lttng/lttng-ust/tree/9d4d2a639afc19a1bd705ea560782917ac892596/liblttng-ust-libc-wrapper

Hope this helps.

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
