From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3 lttng-ust 1/2] Introduce vtracef
Date: Wed, 26 Feb 2020 16:10:55 -0500 (EST)
Message-ID: <453716307.9064.1582751455324.JavaMail.zimbra@efficios.com>
References: <20200224173455.15900-1-maxime.roussinbelanger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 48ST3z5kXJzydG
 for <lttng-dev@lists.lttng.org>; Wed, 26 Feb 2020 16:10:55 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 98CAF26FB29
 for <lttng-dev@lists.lttng.org>; Wed, 26 Feb 2020 16:10:55 -0500 (EST)
In-Reply-To: <20200224173455.15900-1-maxime.roussinbelanger@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Feb 24, 2020, at 12:34 PM, Maxime Roussin-Belanger maxime.roussinbelanger@gmail.com wrote:

> diff --git a/doc/examples/demo-tracef/demo-vtracef.c
> b/doc/examples/demo-tracef/demo-vtracef.c
> new file mode 100644
> index 00000000..224e9292
> --- /dev/null
> +++ b/doc/examples/demo-tracef/demo-vtracef.c
> @@ -0,0 +1,59 @@
> +/*
> + * Copyright (C) 2020  Maxime Roussin-Belanger
> <maxime.roussinbelanger@gmail.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; version 2.1 of
> + * the License.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
> USA
> + */
> +
> +#include <stdarg.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +
> +#include <lttng/tracef.h>
> +
> +

Remove one whiteline here.

> +void print_debug(const char* msg, ...)
> +{
> +	va_list ap;
> +	va_start(ap, msg);
> +
> +	vtracef(msg, ap);
> +
> +	va_end(ap);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int i;
> +	int delay = 0;
> +	const char *str = "mystring test";
> +	long l = 0x42;
> +
> +	if (argc == 2)

Should handle cases where argc > 2 as well.

> +		delay = atoi(argv[1]);
> +
> +	fprintf(stderr, "Demo program starting.\n");
> +
> +	sleep(delay);
> +
> +	fprintf(stderr, "Tracing... ");
> +
> +	for (i = 0; i < 5; i++) {
> +		print_debug("This is a \"%s\" formatted %d event %lx", str, i, l);
> +	}
> +
> +	fprintf(stderr, " done.\n");
> +	return 0;
> +}

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
