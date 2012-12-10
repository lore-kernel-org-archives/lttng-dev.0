From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/3] urcu: avoid "expression result
	unused"	from clang
Date: Mon, 10 Dec 2012 09:10:22 -0500
Message-ID: <20121210141022.GB32034__6216.98324471271$1355148662$gmane$org@Krystal>
References: <1354872295-32371-1-git-send-email-laijs@cn.fujitsu.com>
	<20121207165848.GB12338@Krystal>
	<CACvQF53+x_PDd+aOtM0k2wN0BJZXRMkB3pjXxfvsV=HkdknM=Q@mail.gmail.com>
	<CACvQF514yxBjppYFKJEqX=n31LdU6dTqBg9-7kn5AoTy0i7=Lw@mail.gmail.com>
	<20121208150023.GA16943@Krystal>
	<CACvQF53-yf90t5o2-s6vjVvUotvVogrBgu4LM7FrsbWgEa1+ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Ti43r-0000D7-It
	for lttng-dev@lists.lttng.org; Mon, 10 Dec 2012 09:10:23 -0500
Content-Disposition: inline
In-Reply-To: <CACvQF53-yf90t5o2-s6vjVvUotvVogrBgu4LM7FrsbWgEa1+ng@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Lai Jiangshan <eag0628@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Lai Jiangshan (eag0628@gmail.com) wrote:
> On Saturday, December 8, 2012, Mathieu Desnoyers wrote:
> 
> > * Lai Jiangshan (eag0628@gmail.com <javascript:;>) wrote:
> > > How about the one in yy.diff?
> > >
> > > xx.diff fixes the one what I had sent in 1/3 patch, but it may still
> > > cause warning in future if the complier become more strict.
> >
> > Hrm. In any cases, I think that even with the 2 patches you propose, the
> > warning "unused expression return" would still be valid (because we end
> > up not using the result of the outer statement-expression). We might
> > want to consider simpler approaches:
> >
> > 1 - Add the missing (void) casts before each CMM_STORE_SHARED() in the
> >     code. I don't like this because it makes the CMM_STORE_SHARED common
> >     case more cumbersome to use.
> 
> 
> I don't like it either, it is not friendly.
> 
> 
> > 2 - Change the CMM_STORE_SHARED() API so it does not return anything.
> >     I think most use-cases don't involve using its return value anyway.
> 
> 
> 
> It will break the original goal:
> CMM_STORE_SHARED() can be used as chained assignment:
> tmp = CMM_STORE_SHARED(x, v)
> CMM_STORE_SHARED(y, CMM_STORE_SHARED(x, v))
> func(CMM_STORE_SHARED(x,v))

Indeed, I'd hate to have to change this semantic.

Thanks,

Mathieu

> 
> 
> 
> > Thoughts ?
> >
> > Thanks,
> >
> > Mathieu
> >
> > >
> > > On Sat, Dec 8, 2012 at 1:27 AM, Lai Jiangshan <eag0628@gmail.com<javascript:;>>
> > wrote:
> > > >
> > > >
> > > > On Saturday, December 8, 2012, Mathieu Desnoyers wrote:
> > > >>
> > > >> * Lai Jiangshan (laijs@cn.fujitsu.com <javascript:;>) wrote:
> > > >> > The last expression result is unused and clang will complain.
> > > >> > The trick in the patch supresses the complaint
> > > >>
> > > >> Hrm, but with this patch, gcc complains:
> > > >>
> > > >> rculfhash.c:1921:3: warning: variable '_w' set but not used
> > > >> [-Wunused-but-set-variable]
> > > >>
> > > >> using
> > > >>
> > > >> gcc version 4.7.2 (Debian 4.7.2-4)
> > > >
> > > >
> > > > Ouch, my gcc is too old
> > > >
> > > >
> > > >>
> > > >>
> > > >> Thoughts ?
> > > >>
> > > >> Thanks,
> > > >>
> > > >> Mathieu
> > > >>
> > > >> >
> > > >> > Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com <javascript:;>>
> > > >> > ---
> > > >> >  urcu/system.h        |    5 ++++-
> > > >> >  2 files changed, 4 insertions(+), 1 deletions(-)
> > > >> >
> > > >> > diff --git a/urcu/system.h b/urcu/system.h
> > > >> > index 2a45f22..6b7b0af 100644
> > > >> > --- a/urcu/system.h
> > > >> > +++ b/urcu/system.h
> > > >> > @@ -46,12 +46,15 @@
> > > >> >  /*
> > > >> >   * Store v into x, where x is located in shared memory. Performs
> > the
> > > >> >   * required cache flush after writing. Returns v.
> > > >> > + * "_w" here avoids the warning from clang:
> > > >> > + *   warning: expression result unused [-Wunused-value]
> > > >> >   */
> > > >> >  #define CMM_STORE_SHARED(x, v)               \
> > > >> >       ({                              \
> > > >> >               __typeof__(x) _v = _CMM_STORE_SHARED(x, v);     \
> > > >> > +             __typeof__(x) _w;       \
> > > >> >               cmm_smp_wmc();          \
> > > >> > -             _v;                     \
> > > >> > +             _w = _v;                \
> > > >> >       })
> > > >> >
> > > >> >  #endif /* _URCU_SYSTEM_H */
> > > >> > --
> > > >> > 1.7.4.4
> > > >> >
> > > >> >
> > > >> > _______________________________________________
> > > >> > lttng-dev mailing list
> > > >> > lttng-dev@lists.lttng.org <javascript:;>
> > > >> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > > >>
> > > >>
> > > >> --
> > > >> Mathieu Desnoyers
> > > >> Operating System Efficiency R&D Consultant
> > > >> EfficiOS Inc.
> > > >> http://www.efficios.com
> > > >>
> > > >> _______________________________________________
> > > >> lttng-dev mailing list
> > > >> lttng-dev@lists.lttng.org <javascript:;>
> > > >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> >
> >
> >
> > --
> > Mathieu Desnoyers
> > Operating System Efficiency R&D Consultant
> > EfficiOS Inc.
> > http://www.efficios.com
> >

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
