From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Add trace instrumentation
	for	some pthread functions.
Date: Wed, 7 Aug 2013 12:31:53 -0400
Message-ID: <20130807163153.GA2194__13406.8465944894$1375893176$gmane$org@Krystal>
References: <5202482B.2010705@mentor.com> <52025427.5080002@mentor.com>
	<20130807143346.GA542@Krystal> <520262E8.5010106@mentor.com>
	<20130807151903.GA1035@Krystal> <52026AD7.7000103@mentor.com>
	<20130807155228.GC1035@Krystal> <52026F42.4050005@mentor.com>
	<20130807161241.GB1336@Krystal> <520274F3.3080505@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V76eT-0001Fy-0G
	for lttng-dev@lists.lttng.org; Wed, 07 Aug 2013 12:32:02 -0400
Content-Disposition: inline
In-Reply-To: <520274F3.3080505@mentor.com>
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
> On 08/07/2013 12:12 PM, Mathieu Desnoyers wrote:
> 
> > The difference with pthread instrumentation is that it's really a new
> > feature in every possible sense of the term: new kind of library
> > functions are instrumented, new problems may arise, new files are added,
> > new shared objects are added. This is exactly what we don't want to add
> > during rc.
> 
> I fully agree.
> 
> > Please note that as soon as you get my acked-by, you can consider this
> > patch accepted. It's just that we don't have the staging branches to
> > keep them around, nor the manpower to maintain a 3rd branch in parallel
> > with the current stable+rc.
> > 
> > Thoughts ?
> 
> I understand if it makes things easier for you as maintainer if you ask
> contributors to do the rebase before their (approved) patches are to be
> merged. But your wording seemed to suggest that I should resend the
> actual patch, not regenerate it after rebasing to a future master, which
> confused me as in that case I'd need to keep around a free-floating
> patch that is neither version-controlled nor archived.

I'm OK with contributors rebasing a patch before resubmission, of
course. However, if the rebase required any change at all to the patch,
the "acked-by" tags should be removed, and the fact that it's been
accepted and then rebased (with changes) should be pointed out in the
changelog, ideally with a quick summary of the changes required for the
rebase. This should make the merge process quick and straightforward,
without risks of us missing an issue introduced by the rebase.

Does it make sense ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
