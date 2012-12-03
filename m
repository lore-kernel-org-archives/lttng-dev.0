From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Link test utilities
	against	urcu-bp
Date: Mon, 3 Dec 2012 09:03:04 -0500
Message-ID: <20121203140304.GA3546__3330.67891556329$1354543437$gmane$org@Krystal>
References: <20121128151359.GA2051@quintessa> <50B64AB6.6080904@efficios.com>
	<20121128210845.GA30284@quintessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TfWbx-00060K-Lu
	for lttng-dev@lists.lttng.org; Mon, 03 Dec 2012 09:03:05 -0500
Content-Disposition: inline
In-Reply-To: <20121128210845.GA30284@quintessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Jon Bernard (jbernard@debian.org) wrote:
> * David Goulet <dgoulet@efficios.com> wrote:
> > Hi Jon,
> > 
> > Can you enlighten us on what setup are you using?
> > 
> > This symbol is used by lttng-ust which is linked with -lurcu-bp so
> > lttng-tools should not have an issue here.
> > 
> > Are you cross-compiling ?
> 
> Nothing unusual, I'm building lttng-tools (version 2.1.8~rc8) from source
> against URCU version 0.7.5 and UST version 2.1.0~rc2.  During compilation
> (configure with no additional parameters), I see the following:
> 
>     make[3]: Entering directory `tests/tools/streaming'
>     CC     unit_tests.o
>     CCLD   unit_tests
>     CC     gen-ust-events.o
>     CC     tp.o
>     CCLD   gen-ust-events
>     /usr/bin/ld: tp.o: undefined reference to symbol 'rcu_dereference_sym'
> 
> This link error occurs on each of the gen-events targets as there is no explicit
> link against urcu-bp.  I must have something different, as I'm sure you'd have
> noticed this earlier.  What additional information might you need?

Hi Jon,

It looks like something we already fixed in lttng-ust, but maybe the fix
needs to be ported to tools also.

See lttng-ust:

commit faebb41808b9deda5ef5dfea0c035077407e7f9f
Author: Christian Babeux <christian.babeux@efficios.com>
Date:   Thu Aug 2 18:55:11 2012 -0400

    Fix: Libtool fails to find dependent libraries when cross-compiling lttng-ust
    
    This problem arise when cross compiling and linking libraries with
    indirect libraries dependencies (such as liblttng-ust). This "bug" is
    caused by an upstream modification in the libtool package on Debian
    system. The libtool "link_all_deplibs" flag is set to "no" by default
    on linux targets (AFAIK, other distros set it to "unknown").
    
    The chosen solution is to detect such cases via the configure script
    and automagically patch the libtool.m4 by forcing the "link_all_deplibs"
    to "unknown".
    
    This fixup can be disabled with the appropriate configure flag:
    
    ./configure --disable-libtool-linkdep-fixup
    
    Sample configure output on affected systems:
    
    checking for occurence(s) of link_all_deplibs = no in
             ./config/libtool.m4... 3
    configure: WARNING: the detected libtool will not link all
               dependencies, forcing link_all_deplibs = unknown
    
    Fixes: #321
    
    Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thoughts ?

Thanks,

Mathieu


> 
> Cheers
> 
> -- 
> Jon
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
