From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: Re: lttng-ust under the hood
Date: Fri, 23 May 2014 18:09:29 +0200
Message-ID: <537F72B9.9030904__17879.6096276075$1400861456$gmane$org@keymile.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD359ADFFC@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-de.keymile.com ([195.8.104.250])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=0220114882=gerlando.falauto@keymile.com>)
 id 1Wns2U-0002v6-5k
 for lttng-dev@lists.lttng.org; Fri, 23 May 2014 12:09:51 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD359ADFFC@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 05/23/2014 05:11 PM, Thibault, Daniel wrote:
> ----------------------------------------------------------------------
> Date: Thu, 22 May 2014 18:21:29 +0200
> From: Gerlando Falauto <gerlando.falauto@keymile.com>
>
>> I'm still struggling to figure out why, depending on how I compile and link my application, I can get either custom tracepoint providers
>> OR tracef() to work, but not both at the same time.
>>
>> Is there any documentation explaining how lttng-ust is roughly supposed to work?
>> (i.e. linking trickeries, libraries needed in LD_PRELOAD, _LGPL_SOURCE, tracepoints, probes and so on...)
>>
>> Gerlando
>
>     It's all a matter of choice.  Tracepoint providers can be in the app (statically linked in) or dynamically linked to it.  In the latter case, the linking can be mandatory (so the app will fail to launch if it cannot find the tracepoint provider .so) or optional.  With optional linking, failure to find the .so means the app isn't traceable but otherwise runs normally.

Could you elaborate more on this optional linking? Perhaps it's the kind 
of problem I'm running into.

> LD_PRELOAD is generally used to provide the app with the tracepoint provider .so when tracing is desired.

>
>     Extensive documentation (in PDF) is currently undergoing editorial review, and the plan is to move said documentation to DocBook format so it can be included in the LTTng distribution.

Would it be possible to have a copy of this doc?

>    Since tracef() depends on liblttng-ust just like ordinary UST, I'm not sure which problem you're running into.  Could you give us a simplified makefile that showcases the issue?

main.c:
#include <lttng/tracef.h>

int main() {
    tracef("Hello world");
    return 0;
}

gcc main.c -lttlng-ust -ldl -I.

There, I don't get my tracef().
This happens on top of an ELDK 5.4, on top of which I configured & 
compiled one of the latest releases of userspace-rc, lttng-ust, and 
lttng-tools.

I tried either with native compiling on the target, or with 
cross-compiling. Same result.

Notice how I used the same configure/compile/install script to compile 
on a pristine ch-rooted rootfs on the x86_64 host, and there everything 
works fine.

I suspect my ELDK (so my rootfs) has some spurious LTTNG files (or other 
.so), since it already contains an older version of LTTNG, which confuse 
the linker. I tried rm'ing the existing /usr/lib/{liblttng-*,liburcu*} 
prior to configuring, but still no luck.

Any clue?

Thank you,
Gerlando
