From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix cross-compile
Date: Wed, 7 Nov 2012 15:28:18 -0500
Message-ID: <20121107202818.GA31867__29088.6209033944$1352320133$gmane$org@Krystal>
References: <20121107201321.GA31570@Krystal> <509AC1D9.5050704@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TWCEW-0004FN-7l
	for lttng-dev@lists.lttng.org; Wed, 07 Nov 2012 15:28:20 -0500
Content-Disposition: inline
In-Reply-To: <509AC1D9.5050704@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
> Merged.
> 
> Thanks!

Following up our IRC discussion, this patch should be reverted. --host
is appropriate for projects, --target should be used when building
cross-compilers.

Thanks,

Mathieu

> 
> Mathieu Desnoyers:
> > configure.ac should use --target, not --host to get the target info we
> > want to compile for. --host is for the host that does the build.
> > 
> > Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > ---
> > diff --git a/configure.ac b/configure.ac
> > index a3120fc..49d324e 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -313,7 +313,7 @@ AS_ECHO("$version_description")
> >  AS_ECHO()
> >  
> >  # Target architecture we're building for
> > -target_arch=$host_cpu
> > +target_arch=$target_cpu
> >  [
> >  for f in $CFLAGS; do
> >          if test $f = "-m32"; then
> > 
> > 

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
