From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Questions about CTF format
Date: Thu, 2 May 2013 16:27:58 -0400
Message-ID: <20130502202758.GE15675__20868.9194209457$1367526511$gmane$org@Krystal>
References: <CAEBwSh_OkCZiWJXQrUO3fnLnka3MfTJpa8z0HqxxVFd7CtPqOg@mail.gmail.com>
	<20120705142052.GA23162@Krystal>
	<CAEBwSh8vqVr9LsPPRxx_c9da7M3spcMwrHTkSX+bWE1_UQVXbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UY06i-0006Ou-5v
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 16:28:00 -0400
Content-Disposition: inline
In-Reply-To: <CAEBwSh8vqVr9LsPPRxx_c9da7M3spcMwrHTkSX+bWE1_UQVXbw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Diego Dompe <ddompe@gmail.com>
Cc: lttng-dev@lists.lttng.org, tiwg@multicore-association.org
List-Id: lttng-dev@lists.lttng.org

* Diego Dompe (ddompe@gmail.com) wrote:
> Hi Mathieu,
> 
> Thanks for the help. Here is my list of details:
> 
> - Clocks: the spec doesn't explain properly that timestamps are an offset
> from the base time of the clock they refer to. Since I was using 64bit
> timestamps I somehow assumed that I was using absolute timestamps from the
> epoch (although the spec doesn't says it either).

Not sure if it was there when you wrote your comment, but the CTF spec
currently has:

"The "offset_s" and "offset" fields indicate the offset from POSIX.1
Epoch, 1970-01-01 00:00:00 +0000 (UTC), to the zero of value of the
clock."

> - I saw that the lttng-generated traces for metadata are always a multiple
> of 4k in size (at least the ones I generate for either kernel or user
> space). I can't find where in the spec it mentions requirements regarding
> metadata packet padding. I was generating metadata packets that ended up
> right after my TSDL and eclipse wasn't happy about it (although I didn't
> try babeltrace). Also I found that the lttng-generated traces have a
> "empty" metadata packet after the metadata containing the TSDL, I didn't
> find either any documentation regarding this.

Babeltrace had a limitation on not accepting packets smaller than 4kB
(page size actually), but it is now fixed.

Thanks,

Mathieu

> 
> Regards,
> 
> Diego
> 
> On Thu, Jul 5, 2012 at 8:20 AM, Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
> 
> > * Diego Dompe (ddompe@gmail.com) wrote:
> > > Hi,
> > >
> > > I'm developing a custom tracer for an embedded product that will generate
> > > CTF format. I was able to generate generic traces that can be interpreted
> > > properly with babeltrace (but not with eclipse, I already file a bug for
> > > that), but I found the CTF specification lacking in some aspects (I had
> > to
> > > peek into lttng-generated CTF traces to figure out some details). I was
> > > wondering what is the proper mailing list to clear my questions and
> > provide
> > > feedback on the CTF specification for improvement in the areas where the
> > > documentation is not detailed yet. I don't see any CTF-specific mailing
> > > list, it's OK to discuss it here? Or maybe directly with a developer(s)?
> >
> > Hi Diego,
> >
> > Yes, this mailing list would be the proper place, along maybe with
> > adding the MCA tiwg mailing list in CC, which I'm doing here.
> >
> > Thanks,
> >
> > Mathieu
> >
> > --
> > Mathieu Desnoyers
> > Operating System Efficiency R&D Consultant
> > EfficiOS Inc.
> > http://www.efficios.com
> >

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
