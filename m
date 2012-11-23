From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Add
	file:	lttng-kernel-version.h
Date: Fri, 23 Nov 2012 15:06:55 -0500
Message-ID: <20121123200655.GA11335__10695.9597360857$1353701249$gmane$org@Krystal>
References: <1353700865-32009-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TbzWb-0001MK-Dv
	for lttng-dev@lists.lttng.org; Fri, 23 Nov 2012 15:06:57 -0500
Content-Disposition: inline
In-Reply-To: <1353700865-32009-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> It contains a macro to help checking for kernel version ranges.

Merged with small cosmetic changes,

Oh damn, I forgot the --author. Sorry, it appears From: me.

Thanks,

Mathieu

> 
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  lttng-kernel-version.h |   36 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)
>  create mode 100644 lttng-kernel-version.h
> 
> diff --git a/lttng-kernel-version.h b/lttng-kernel-version.h
> new file mode 100644
> index 0000000..cb5c4dd
> --- /dev/null
> +++ b/lttng-kernel-version.h
> @@ -0,0 +1,36 @@
> +#ifndef _LTTNG_KERNEL_VERSION_H
> +#define _LTTNG_KERNEL_VERSION_H
> +
> +/*
> + * lttng-events.h
> + *
> + * Contains helpers to check more complex kernel version conditions.
> + *
> + * Copyright (C) 2012 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; only
> + * version 2.1 of the License.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + */
> +
> +#include <linux/version.h>
> +
> +/*
> + * This macro checks if the kernel version is between the two specified
> + * versions.
> + */
> +#define LTTNG_KERNEL_RANGE(a_low, b_low, c_low, a_high, b_high, c_high) \
> +	(LINUX_VERSION_CODE >= KERNEL_VERSION(a_low, b_low, c_low) && \
> +	 LINUX_VERSION_CODE <= KERNEL_VERSION(a_high, b_high, c_high))
> +
> +#endif /* _LTTNG_KERNEL_VERSION_H */
> -- 
> 1.7.1
> 
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
