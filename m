From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [rp] [RFC] Userspace RCU library internal error
 handling
Date: Fri, 22 Jun 2012 12:55:48 -0700
Message-ID: <20120622195548.GB18467__23064.5213545815$1340394993$gmane$org@leaf>
References: <20120621164113.GA21197@Krystal> <20120621185941.GC26361@leaf>
	<20120621190306.GB24179@Krystal> <20120621192824.GE26361@leaf>
	<20120621194838.GB25571@Krystal> <20120621212102.GF26361@leaf>
	<20120622152231.GA10788@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <josh@joshtriplett.org>) id 1Si9xY-0003gv-EZ
	for lttng-dev@lists.lttng.org; Fri, 22 Jun 2012 15:56:00 -0400
Content-Disposition: inline
In-Reply-To: <20120622152231.GA10788@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, rp@svcs.cs.pdx.edu
List-Id: lttng-dev@lists.lttng.org

On Fri, Jun 22, 2012 at 11:22:31AM -0400, Mathieu Desnoyers wrote:
> * Josh Triplett (josh@joshtriplett.org) wrote:
> > #undef NDEBUG
> > #include <assert.h>
> > 
> > Or if you don't consider that sufficient for some reason, you could
> > define your own assert(), but that seems like an odd thing to not count
> > on.  Nonetheless, if you define your own assert, I'd still suggest
> > making it look as much like assert() as possible, including the call to
> > abort().
> 
> #undef NDEBUG is unwanted, due to its side-effects. We use "assert()" in
> other locations of the code, for which we want the assertion check to be
> disabled if NDEBUG is defined in production.

Ah, fair enough.

> I agree with you that calling "abort()" is exactly what we want, and
> it's much more standard that sending a signal chosen with a fair roll of
> dices. How about the following ?
> 
> [...]
> diff --git a/urcu-die.h b/urcu-die.h
> new file mode 100644
> index 0000000..227c8dc
> --- /dev/null
> +++ b/urcu-die.h
> @@ -0,0 +1,37 @@
> +#ifndef _URCU_DIE_H
> +#define _URCU_DIE_H
> +
> +/*
> + * urcu-die.h
> + *
> + * Userspace RCU library unrecoverable error handling
> + *
> + * Copyright (c) 2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <string.h>
> +
> +#define urcu_die(cause)								\
> +do {										\
> +	fprintf(stderr, "(" __FILE__ ":%s@%u) Unrecoverable error: %s\n",	\
> +		__func__, __LINE__, strerror(cause));				\
> +	abort();								\
> +} while (0)
> +
> +#endif /* _URCU_DIE_H */
> [...]

That looks reasonable; you've effectively recreated assert, but in a
form that will always have the same effect regardless of NDEBUG.

- Josh Triplett
