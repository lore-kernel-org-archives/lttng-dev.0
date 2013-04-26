From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Changed scheduling when using lttng
Date: Fri, 26 Apr 2013 11:38:20 -0400
Message-ID: <20130426153819.GA3026__8405.96428975022$1366990726$gmane$org@Krystal>
References: <CA+xJJ18hL16P3gvowveWVfg+ZNh=cjEFOoPisznU0y28YfCdbw@mail.gmail.com>
	<20130425151213.GC7970@Krystal>
	<CA+xJJ1-U_Y0DuLNJ+xwBLPLF+5LyS=mO4f7onpquEHSrbyOUAQ@mail.gmail.com>
	<20130426132639.GA1468@Krystal>
	<CA+xJJ19OE=nrfpEoOEib-7=GrP9hD-RV7bc=aY7nqDwB59auXQ@mail.gmail.com>
	<20130426151444.GA2260@Krystal>
	<CA+xJJ199oic8pmnKM4c674Zf_NJe3AR1YxFtBTjLryv3S67nkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UVkj7-00048o-8R
	for lttng-dev@lists.lttng.org; Fri, 26 Apr 2013 11:38:21 -0400
Content-Disposition: inline
In-Reply-To: <CA+xJJ199oic8pmnKM4c674Zf_NJe3AR1YxFtBTjLryv3S67nkQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mats Liljegren <liljegren.mats2@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Mats Liljegren (liljegren.mats2@gmail.com) wrote:
> >> >> I tried number 1 using --read-timer 0, but "lttng stop" hanged at
> >> >> "Waiting for data availability", producing lots of dots...
> >> >
> >> > As I said, we'd need to implement RING_BUFFER_WAKEUP_BY_WRITER when
> >> > read-timer is set to 0. It's not implemented currently.
> >> >
> >> >>
> >> >> Would it be possible to let some other (not using nohz mode) CPU to
> >> >> flush the buffers?
> >> >
> >> > I guess that would be option 3) :
> >> >
> >> > Another option would be to let a single thread in the consumer handle
> >> > the read-timer for all streams of the channel, like we do for UST.
> >>
> >> Ehm, well, you did say something about implement... Sorry for missing that.
> >>
> >> I guess now the question is which option that gives best
> >> characteristics for least amount of work... Without knowing the design
> >> of lttng-module, I'd believe that simply having the timer on another
> >> CPU should be a good candidate. Is there anything to watch out for
> >> with this solution?
> >>
> >> Are there any documents describing lttng-module design, or is it "join
> >> the force, use the source"? I've seen some high-level description
> >> showing how tools/libs/modules fit together, but I haven't found
> >> anything that describes how lttng-modules is designed.
> >
> > Papers on the ring buffer design exist, but not on lttng-modules per se.
> >
> > I think the best solution in the shortest amount of time would be (2):
> > using deferrable timers. It's just flags to pass to timer creation.
> 
> Doesn't that require that the system is idle from time to time? My
> application will occupy 100% CPU until finished, and expects there are
> no ticks during that time.

AFAIU, your initial question was about not preventing the CPU from going
to low power mode when tracing. The deferred timers should do just that.

Indeed, the timers will fire on CPUs that are active.

I guess what you want there is no intrusiveness for CPU shielding.
Indeed, for this kind of use-case, you may need to centralise the timer
handling into lttng-consumerd.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
