From: Norbert Lange <nolange79@gmail.com>
Subject: Re: [RFC PATCH liburcu] urcu-bp: introduce
 urcu_bp_disable_sys_membarrier()
Date: Fri, 22 Nov 2019 19:37:33 +0100
Message-ID: <CADYdroNm8E6O2dWMzSsBPh3Hg12KO66kMPhqkyBWoAjgraFexg__32985.6366313592$1574447881$gmane$org@mail.gmail.com>
References: <20191122170040.23250-1-mathieu.desnoyers@efficios.com>
 <173739689.937.1574442178071.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 by lists.lttng.org (Postfix) with ESMTPS id 47KQCY3tGkz1S6H
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 13:37:45 -0500 (EST)
Received: by mail-il1-x142.google.com with SMTP id s75so7876944ilc.3
 for <lttng-dev@lists.lttng.org>; Fri, 22 Nov 2019 10:37:45 -0800 (PST)
In-Reply-To: <173739689.937.1574442178071.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, lttng-dev <lttng-dev@lists.lttng.org>, paulmck <paulmck@kernel.org>
List-Id: lttng-dev@lists.lttng.org

I still would like to propose having a compile time "off switch",
cant see how this would work with preloaded libraries for one
(lttng itself whips with multiple)

Cant tell for sure now, but a setup where "bulletproof Xenomai"
libraries are used seems to better than special setup magic.
If you have to do do alot measurements for finding rare hiccups,
the last thing you want it figuring out you forget one config.

Thanks for the speedy support, Norbert
