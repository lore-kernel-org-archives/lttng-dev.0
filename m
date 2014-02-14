From: Alexander Monakov <amonakov@ispras.ru>
Subject: Re: [PATCH] Force static_alloc setup to be written into
 memory
Date: Fri, 14 Feb 2014 18:23:19 +0400 (MSK)
Message-ID: <alpine.LNX.2.00.1402141816441.24828__29992.272044956$1392387931$gmane$org@monopod.intra.ispras.ru>
References: <alpine.LNX.2.00.1402141420420.24828@monopod.intra.ispras.ru>
	<1392385505-13405-1-git-send-email-paul_woegerer@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ispras.ru ([83.149.199.79])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <amonakov@ispras.ru>) id 1WEJgu-0003LO-5R
	for lttng-dev@lists.lttng.org; Fri, 14 Feb 2014 09:24:37 -0500
In-Reply-To: <1392385505-13405-1-git-send-email-paul_woegerer@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Woegerer <paul_woegerer@mentor.com>
Cc: stefan_seefeld@mentor.com, lttng-dev@lists.lttng.org, paulmck@linux.vnet.ibm.com
List-Id: lttng-dev@lists.lttng.org



On Fri, 14 Feb 2014, Paul Woegerer wrote:

> As explained by Alexander Monakov, dlsym() is defined to be pure, thus the
> compiler is allowed to assume that there is no need to write the changes
> performed by setup_static_allocator() into memory prior to calling dlsym().
> The added cmm_barrier() forces the compiler to write the changes into memory.
> 
> For more details refer to:
> http://lists.lttng.org/pipermail/lttng-dev/2014-February/022389.html

If everyone here agrees that this is a workaround for a glibc bug, please add
a note to that effect in the patch and please notify glibc upstream (again).

FWIW, when toying with a similar code I implemented a different workaround
along the lines of

#define dlsym glibc_dlsym_proto_lies_about_leafness
#include <dlfcn.h>
#undef dlsym

extern void *dlsym(void *, const char *);


Thus avoiding the need to sprinkle unneeded compiler memory barriers in code.

HTH
Alexander
