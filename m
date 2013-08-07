From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Add trace instrumentation
	for	some pthread functions.
Date: Wed, 7 Aug 2013 12:12:41 -0400
Message-ID: <20130807161241.GB1336__18667.8651175045$1375892020$gmane$org@Krystal>
References: <51FFAAD7.3000705@seefeld.name> <20130807013159.GG19407@Krystal>
	<5202482B.2010705@mentor.com> <52025427.5080002@mentor.com>
	<20130807143346.GA542@Krystal> <520262E8.5010106@mentor.com>
	<20130807151903.GA1035@Krystal> <52026AD7.7000103@mentor.com>
	<20130807155228.GC1035@Krystal> <52026F42.4050005@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V76Lq-00009E-NW
	for lttng-dev@lists.lttng.org; Wed, 07 Aug 2013 12:12:48 -0400
Content-Disposition: inline
In-Reply-To: <52026F42.4050005@mentor.com>
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

* Stefan Seefeld (stefan_seefeld@mentor.com) wrote:
> On 08/07/2013 11:52 AM, Mathieu Desnoyers wrote:
> > * Stefan Seefeld (stefan_seefeld@mentor.com) wrote:
> >> Sorry for the incomplete patch. Here is a corrected one.
> >>
> >> 	Stefan
> > You can add my
> >
> > Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >
> > To you patch changelog.
> >
> > Can you keep it around and resubmit after we release 2.3-final in a few
> > weeks ?
> 
> Why can't this be comitted to a devel branch, if it isn't fit to go into
> master ?

Because master is currently in feature freeze for the 2.3-rc cycle, and
as a maintainer I'm not keeping any devel/staging branch: this
responsibility currently belongs to the contributors. The new features
flow into master between the end of the release candidate cycle (final
version) and the start of the next rc cycle. See the recent discussion
on the release process on lttng-dev for more details. Feedback is
welcome.

> (Also, does this imply that the malloc patch made it into the
> 2.3 release ?)

Yes, the malloc patch made it into the 2.3 release mainly because it's
fixing incomplete coverage of the already existing malloc/free-related
instrumentation.

The difference with pthread instrumentation is that it's really a new
feature in every possible sense of the term: new kind of library
functions are instrumented, new problems may arise, new files are added,
new shared objects are added. This is exactly what we don't want to add
during rc.

Please note that as soon as you get my acked-by, you can consider this
patch accepted. It's just that we don't have the staging branches to
keep them around, nor the manpower to maintain a 3rd branch in parallel
with the current stable+rc.

Thoughts ?

Thanks,

Mathieu

> 
>     Stefan
> 
> 
> -- 
> Stefan Seefeld
> CodeSourcery / Mentor Graphics
> http://www.mentor.com/embedded-software/
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
