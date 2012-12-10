From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/3] urcu: avoid "expression result
	unused"	from clang
Date: Mon, 10 Dec 2012 09:09:31 -0500
Message-ID: <20121210140930.GA32034__40621.9977107414$1355148615$gmane$org@Krystal>
References: <1354872295-32371-1-git-send-email-laijs@cn.fujitsu.com>
	<20121207165848.GB12338@Krystal>
	<CACvQF53+x_PDd+aOtM0k2wN0BJZXRMkB3pjXxfvsV=HkdknM=Q@mail.gmail.com>
	<CACvQF514yxBjppYFKJEqX=n31LdU6dTqBg9-7kn5AoTy0i7=Lw@mail.gmail.com>
	<20121208150023.GA16943@Krystal> <50C54A07.20101@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Ti432-0000Bj-Gx
	for lttng-dev@lists.lttng.org; Mon, 10 Dec 2012 09:09:32 -0500
Content-Disposition: inline
In-Reply-To: <50C54A07.20101@cn.fujitsu.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Lai Jiangshan <eag0628@gmail.com>
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> On 12/08/2012 11:00 PM, Mathieu Desnoyers wrote:
> > * Lai Jiangshan (eag0628@gmail.com) wrote:
> >> How about the one in yy.diff?
> >>
> >> xx.diff fixes the one what I had sent in 1/3 patch, but it may still
> >> cause warning in future if the complier become more strict.
> > 
> > Hrm. In any cases, I think that even with the 2 patches you propose, the
> > warning "unused expression return" would still be valid (because we end
> > up not using the result of the outer statement-expression). 
> 
> The one in yy.diff:
> 
> 1 ? _v : statement_which_has_side_affect;
> 
> The compiler should not warn for it. "?:" can be used for control flow,
> the complier should only warn if both branches are warning.

In the case of yy.diff, whether the warning will appear or not would
depend on the phase at which the compiler generates the warning, no ?
For instance, it it chooses to check for unused return values after
eliminating dead code (considering branches that cannot be taken), then
we would be in the same situation as we are today, even if we have a
statement with side effect.

I am more and more enclined to try asking their opinion to the clang
community about this.

Thanks,

Mathieu

> 
> 
> We might
> > want to consider simpler approaches:
> > 
> > 1 - Add the missing (void) casts before each CMM_STORE_SHARED() in the
> >     code. I don't like this because it makes the CMM_STORE_SHARED common
> >     case more cumbersome to use.
> > 2 - Change the CMM_STORE_SHARED() API so it does not return anything.
> >     I think most use-cases don't involve using its return value anyway.
> > 
> > Thoughts ?
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> >>
> >> On Sat, Dec 8, 2012 at 1:27 AM, Lai Jiangshan <eag0628@gmail.com> wrote:
> >>>
> >>>
> >>> On Saturday, December 8, 2012, Mathieu Desnoyers wrote:
> >>>>
> >>>> * Lai Jiangshan (laijs@cn.fujitsu.com) wrote:
> >>>>> The last expression result is unused and clang will complain.
> >>>>> The trick in the patch supresses the complaint
> >>>>
> >>>> Hrm, but with this patch, gcc complains:
> >>>>
> >>>> rculfhash.c:1921:3: warning: variable '_w' set but not used
> >>>> [-Wunused-but-set-variable]
> >>>>
> >>>> using
> >>>>
> >>>> gcc version 4.7.2 (Debian 4.7.2-4)
> >>>
> >>>
> >>> Ouch, my gcc is too old
> >>>
> >>>
> >>>>
> >>>>
> >>>> Thoughts ?
> >>>>
> >>>> Thanks,
> >>>>
> >>>> Mathieu
> >>>>
> >>>>>
> >>>>> Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
> >>>>> ---
> >>>>>  urcu/system.h        |    5 ++++-
> >>>>>  2 files changed, 4 insertions(+), 1 deletions(-)
> >>>>>
> >>>>> diff --git a/urcu/system.h b/urcu/system.h
> >>>>> index 2a45f22..6b7b0af 100644
> >>>>> --- a/urcu/system.h
> >>>>> +++ b/urcu/system.h
> >>>>> @@ -46,12 +46,15 @@
> >>>>>  /*
> >>>>>   * Store v into x, where x is located in shared memory. Performs the
> >>>>>   * required cache flush after writing. Returns v.
> >>>>> + * "_w" here avoids the warning from clang:
> >>>>> + *   warning: expression result unused [-Wunused-value]
> >>>>>   */
> >>>>>  #define CMM_STORE_SHARED(x, v)               \
> >>>>>       ({                              \
> >>>>>               __typeof__(x) _v = _CMM_STORE_SHARED(x, v);     \
> >>>>> +             __typeof__(x) _w;       \
> >>>>>               cmm_smp_wmc();          \
> >>>>> -             _v;                     \
> >>>>> +             _w = _v;                \
> >>>>>       })
> >>>>>
> >>>>>  #endif /* _URCU_SYSTEM_H */
> >>>>> --
> >>>>> 1.7.4.4
> >>>>>
> >>>>>
> >>>>> _______________________________________________
> >>>>> lttng-dev mailing list
> >>>>> lttng-dev@lists.lttng.org
> >>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>>>
> >>>>
> >>>> --
> >>>> Mathieu Desnoyers
> >>>> Operating System Efficiency R&D Consultant
> >>>> EfficiOS Inc.
> >>>> http://www.efficios.com
> >>>>
> >>>> _______________________________________________
> >>>> lttng-dev mailing list
> >>>> lttng-dev@lists.lttng.org
> >>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > 
> > 
> > 
> > 
> 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
