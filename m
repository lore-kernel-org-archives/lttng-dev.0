From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [OE-core] [PATCH v2] lttng-modules: Backport
 patches to fix compilation failures since kernel v5.1
Date: Wed, 12 Jun 2019 06:58:22 -0400 (EDT)
Message-ID: <1859381600.42862.1560337102909.JavaMail.zimbra__39059.522845649$1560337121$gmane$org@efficios.com>
References: <1560243834-266906-1-git-send-email-zhe.he@windriver.com>
 <be27377cd254f6b314185702300d051d20fb7c28.camel@linuxfoundation.org>
 <20190612105114.GA23143@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45P3km6J1Rz114m
 for <lttng-dev@lists.lttng.org>; Wed, 12 Jun 2019 06:58:24 -0400 (EDT)
In-Reply-To: <20190612105114.GA23143@localhost>
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
Cc: Jeremie Galarneau <jgalar@efficios.com>, lttng-dev <lttng-dev@lists.lttng.org>, Richard Purdie <richard.purdie@linuxfoundation.org>, zhe he <zhe.he@windriver.com>, openembedded-core <openembedded-core@lists.openembedded.org>
List-Id: lttng-dev@lists.lttng.org

----- On Jun 12, 2019, at 12:51 PM, Adrian Bunk bunk@stusta.de wrote:

> On Tue, Jun 11, 2019 at 11:49:34PM +0100, Richard Purdie wrote:
>> On Tue, 2019-06-11 at 17:03 +0800, zhe.he@windriver.com wrote:
>> > From: He Zhe <zhe.he@windriver.com>
>> > 
>> > For the moment,
>> > 0001~0004 are on master branch only.
>> > 0005~0007 are on stable-2.11 branch, but v2.11 has not been released
>> > yet.
>> > 
>> > Signed-off-by: He Zhe <zhe.he@windriver.com>
>> > ---
>> > v2: Correct a typo in SOB for 0001*.patch
>> 
>> I just discussed this with lttng upstream maintainers a little. We're
>> going to have continual tension between keeping lttng-modules up to
>> date and new kernel versions.
>> 
>> How about we also have a git version of this particular recipe which
>> has a DEFAULT_PREFERENCE = "-1" but people can opt into with a
>> PREFERRED_VERSION when using newer kernels?
> 
> Yocto stable series will ship a _git AUTOREV recipe?
> 
>> That should keep people using very recent kernels happy, let us use a
>> stable release version and avoid us adding/removing large patchsets on
>> a semi regular basis?
>>...
> 
> The semi regular basis is only slightly moved, or how and when will
> replacing the already EOL kernel 5.0 with 5.1 in Yocto be handled?
> 
> IMHO it would be better to acknowledge that this is a case where staying
> at stable release versions is sometimes not the best option, and upgrade
> the normal recipe to -rc releases or even a git snapshot from a more
> recent stable branch when necessary.
> 
> E.g. right now it seems clear that the next Yocto release will have
> to use lttng-modules >= 2.11 in any case for kernel 5.2, so upgrading
> from 2.10.9 to 2.11.0-rc5 would be logical.

Please don't base distributions on -rc tags. They are not meant for this.

We always integrate support for newer kernel versions instrumentation back
into our current stable release. So as soon as 5.2 final comes out, we will
release a 2.10.x version including support for it in lttng-modules.

The current 2.10.10 has commits to support the currently known 5.2-rc
instrumentation changes.

Thanks,

Mathieu


> 
>> Cheers,
>> 
>> Richard
> 
> cu
> Adrian
> 
> --
> 
>       "Is there not promise of rain?" Ling Tan asked suddenly out
>        of the darkness. There had been need of rain for many days.
>       "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
