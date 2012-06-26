From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [UST PATCH] Add a multi-thread version of
	the	'hello' test program
Date: Tue, 26 Jun 2012 09:52:07 -0400
Message-ID: <20120626135207.GA18658__23544.3148216747$1340718753$gmane$org@Krystal>
References: <1340667760-28686-1-git-send-email-alexmonthy@voxpopuli.im>
	<20120626060356.GC11445@Krystal> <4FE960A2.7080109@voxpopuli.im>
	<20120626120222.GA17072@Krystal>
	<CAEzWAe+EcAhOHrAekc1pQi4Q=Ns7v_XdUU3odt1+9H0e4QcnCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1SjWBc-0001Sk-Sp
	for lttng-dev@lists.lttng.org; Tue, 26 Jun 2012 09:52:08 -0400
Content-Disposition: inline
In-Reply-To: <CAEzWAe+EcAhOHrAekc1pQi4Q=Ns7v_XdUU3odt1+9H0e4QcnCQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Brosseau, Yannick" <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Brosseau, Yannick (yannick.brosseau@gmail.com) wrote:
> On Tue, Jun 26, 2012 at 8:02 AM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> > * Alexandre Montplaisir (alexmonthy@voxpopuli.im) wrote:
> >> On 12-06-26 02:03 AM, Mathieu Desnoyers wrote:
> >> > * Alexandre Montplaisir (alexmonthy@voxpopuli.im) wrote:
> >> >> [...]
> >> >> diff --git a/tests/hello-mt/README b/tests/hello-mt/README
> >> >> new file mode 100644
> >> >> index 0000000..0584dca
> >> >> --- /dev/null
> >> >> +++ b/tests/hello-mt/README
> 
> I was wondering if naming the directement hello-openmp would be more
> appropriate? (The test is kinda specific tot he use of openmp)

good point, makes sense !

Alexandre, can you respin your hello-mp patch and change it to
hello-openmp ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
