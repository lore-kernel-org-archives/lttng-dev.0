From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [OE-core] [PATCH v2] lttng-modules: Backport
 patches to fix compilation failures since kernel v5.1
Date: Wed, 12 Jun 2019 09:33:01 -0400 (EDT)
Message-ID: <1075062100.42992.1560346381924.JavaMail.zimbra__41441.362390627$1560346399$gmane$org@efficios.com>
References: <1560243834-266906-1-git-send-email-zhe.he@windriver.com>
 <be27377cd254f6b314185702300d051d20fb7c28.camel@linuxfoundation.org>
 <20190612105114.GA23143@localhost>
 <1859381600.42862.1560337102909.JavaMail.zimbra@efficios.com>
 <20190612132741.GB23143@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45P79B713dz11Ns
 for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2019 09:33:02 -0400 (EDT)
In-Reply-To: <20190612132741.GB23143@localhost>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>, openembedded-core <openembedded-core@lists.openembedded.org>
List-Id: lttng-dev@lists.lttng.org

----- On Jun 12, 2019, at 3:27 PM, Adrian Bunk bunk@stusta.de wrote:

> On Wed, Jun 12, 2019 at 06:58:22AM -0400, Mathieu Desnoyers wrote:
>>...
>> We always integrate support for newer kernel versions instrumentation back
>> into our current stable release. So as soon as 5.2 final comes out, we will
>> release a 2.10.x version including support for it in lttng-modules.
>>...
> 
> Did something go wrong with that for 5.1?

Only failure to do a timely release on my end, sorry about it. Don't
hesitate to ping me when this happens. The patches were cherry-picked
into the stable-2.10 branch quickly after 5.1 was released (or while in
5.1-rc cycle), but Jonathan reminded me just yesterday that I was overdue
for a release.

> 
> This discussion started with patches on top of 2.10.9 for 5.1 support.
> If the missing release was just a one-time problem for 5.1,
> then the whole problem is usually confined to -rc kernels.

Indeed, I'll try to release stable tags more proactively after a kernel
version comes out in the future.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
