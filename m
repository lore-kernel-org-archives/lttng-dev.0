From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Force static_alloc setup to be written into
 memory
Date: Fri, 14 Feb 2014 15:12:20 +0000 (UTC)
Message-ID: <2045992488.25011.1392390740537.JavaMail.zimbra__15590.3063052849$1392390805$gmane$org@efficios.com>
References: <alpine.LNX.2.00.1402141420420.24828@monopod.intra.ispras.ru>
	<1392385505-13405-1-git-send-email-paul_woegerer@mentor.com>
	<alpine.LNX.2.00.1402141816441.24828@monopod.intra.ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WEKRE-0003mw-39
	for lttng-dev@lists.lttng.org; Fri, 14 Feb 2014 10:12:29 -0500
In-Reply-To: <alpine.LNX.2.00.1402141816441.24828@monopod.intra.ispras.ru>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexander Monakov <amonakov@ispras.ru>
Cc: stefan seefeld <stefan_seefeld@mentor.com>, lttng-dev@lists.lttng.org, paulmck@linux.vnet.ibm.com
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Alexander Monakov" <amonakov@ispras.ru>
> To: "Paul Woegerer" <paul_woegerer@mentor.com>
> Cc: lttng-dev@lists.lttng.org, "mathieu desnoyers" <mathieu.desnoyers@efficios.com>, "stefan seefeld"
> <stefan_seefeld@mentor.com>, paulmck@linux.vnet.ibm.com
> Sent: Friday, February 14, 2014 9:23:19 AM
> Subject: Re: [lttng-dev] [PATCH] Force static_alloc setup to be written into memory
> 
> 
> 
> On Fri, 14 Feb 2014, Paul Woegerer wrote:
> 
> > As explained by Alexander Monakov, dlsym() is defined to be pure, thus the
> > compiler is allowed to assume that there is no need to write the changes
> > performed by setup_static_allocator() into memory prior to calling dlsym().
> > The added cmm_barrier() forces the compiler to write the changes into
> > memory.
> > 
> > For more details refer to:
> > http://lists.lttng.org/pipermail/lttng-dev/2014-February/022389.html
> 
> If everyone here agrees that this is a workaround for a glibc bug, please add
> a note to that effect in the patch and please notify glibc upstream (again).
> 
> FWIW, when toying with a similar code I implemented a different workaround
> along the lines of
> 
> #define dlsym glibc_dlsym_proto_lies_about_leafness
> #include <dlfcn.h>
> #undef dlsym
> 
> extern void *dlsym(void *, const char *);
> 
> 
> Thus avoiding the need to sprinkle unneeded compiler memory barriers in code.

Good idea, this is what I did in the final fix.

It's pushed as:

commit f02baefb3ba4d5493816d63f65625ba4269224d2
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Fri Feb 14 10:02:51 2014 -0500

    Fix: work-around glibc lying about dlsym()/dlerror() leafness
    
    Especially in the LTTng-UST malloc instrumentation, we run into the
    following situation:
    
    1) Our calloc wrapper is called,
    2) we setup the static allocator,
    3) we call dlsym() to lookup the symbol of the real allocator,
    4) dlsym() calls into calloc(), which is overridden by our own wrapper.
       Our calloc does not see that the static allocator has been set,
       because the stores setting up the static allocator have been optimized
       away by gcc-4.8 (in O2), because the dlsym() prototype declares it
       with the "leaf" attribute, and thus we end up doing an infinite
       recursion, and eventually a segmentation fault.
    
    Thanks to Alexander Monakov for pointing out the culprit of this glibc
    bug.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks for your input !!

Mathieu

> 
> HTH
> Alexander
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
