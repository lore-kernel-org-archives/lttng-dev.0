From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Add trace support for calloc
	and	realloc.
Date: Fri, 2 Aug 2013 21:18:41 -0400
Message-ID: <20130803011841.GE9033__35180.1737132066$1375492779$gmane$org@Krystal>
References: <51F3585E.20705@mentor.com>
	<CA+jJMxtn-DsBjzunLNE3_7KS4RCqAFLJfPL7fVkH3z62r0jPxw@mail.gmail.com>
	<51F82C45.6020502@mentor.com>
	<CA+jJMxtMH5Ajgoszg8pO8dq-KsrTg9NwS2YcYOz=FbLr0ijaEQ@mail.gmail.com>
	<alpine.LNX.2.00.1308012013380.9574@monopod.intra.ispras.ru>
	<51FA8DAE.3070409@mentor.com>
	<alpine.LNX.2.00.1308012045570.9574@monopod.intra.ispras.ru>
	<alpine.LNX.2.00.1308012115300.9574@monopod.intra.ispras.ru>
	<51FA9AD8.4010502@mentor.com>
	<CABtfrpDg_NOi+yP5GABmjBv6G9Zj+rvTwc1OdQ1s_9DM7uzeZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V5QUX-0003JC-4m
	for lttng-dev@lists.lttng.org; Fri, 02 Aug 2013 21:18:49 -0400
Content-Disposition: inline
In-Reply-To: <CABtfrpDg_NOi+yP5GABmjBv6G9Zj+rvTwc1OdQ1s_9DM7uzeZg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Stefan Seefeld <stefan_seefeld@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Alexander Monakov (amonakov@ispras.ru) wrote:
> On Thu, Aug 1, 2013 at 9:28 PM, Stefan Seefeld
> <stefan_seefeld@mentor.com> wrote:
> > I don't think any of this works. The ultimate problem is the one J=E9r=
=E9mie
> > reported initially: dlsym will eventually call free() on the memory
> > calloc() returned, so my calloc fallback needs to return something that
> > can actually be freed.
> =

> I pointed out how free() will be safe specifically:
> =

> >> dlsym stores pointer to calloc'ed buffer, overwriting the pointer to m=
map'ed
> >> buffer, completing initialization for the second time and making the
> >> subsequent free() safe.
> =

> Besides, you're intercepting free() in your LD_PRELOAD module as well,
> so you can just catch attempts to free your mmap'ed buffers there and
> munmap them safely.

Hello!

I'm now back from vacation :)

Please have a look at my implementation of quick and dirty malloc/free
tracker here:

https://github.com/efficios/memleak-finder

file: memleak-finder.c

Implementing a work-around for calloc vs dlsym was indeed tricky. The
solution I got there works fine so far (static array used for this
special-case). I think we might get the free() case to be more solid by
checking if the address being freed is in the static buffer range.

If you could submit a patch that improves memleak-finder.c to get this
right, it would be very much appreciated.

Then, I recommend porting the code from memleak-finder.c to UST
liblttng-ust-libc-wrapper. The approach I used in memleak-finder.c seems
to work quite well, and is clearly more complete that what we find in
liblttng-ust-libc-wrapper currently.

Thanks!

Mathieu =


> =

> Alexander
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
