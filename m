From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Add bt_stream_pos
	to	bt_trace_descriptor
Date: Tue, 28 May 2013 13:28:24 -0400
Message-ID: <20130528172823.GA20859__15287.7740948044$1369762145$gmane$org@Krystal>
References: <1369712328-17921-1-git-send-email-jeremie.galarneau@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UhNhB-00034l-Iu
	for lttng-dev@lists.lttng.org; Tue, 28 May 2013 13:28:25 -0400
Content-Disposition: inline
In-Reply-To: <1369712328-17921-1-git-send-email-jeremie.galarneau@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* J=E9r=E9mie Galarneau (jeremie.galarneau@efficios.com) wrote:
> This is intended to provide a generic way to access the bt_stream_pos API
> without having to make assumptions about the output format's descriptor l=
ayout.
> =

> Renamed format-internal.h to trace-descriptor-internal.h to make it more
> representative of the interface it really contains.
> =

> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
[...]
> --- /dev/null
> +++ b/include/babeltrace/trace-descriptor.h
> @@ -0,0 +1,53 @@
> +#ifndef _BABELTRACE_TRACE_DESCRIPTOR_H
> +#define _BABELTRACE_TRACE_DESCRIPTOR_H
> +
> +/*
> + * BabelTrace
> + *
> + * Trace Descriptor Header
> + *
> + * Copyright 2013 EfficiOS Inc. and Linux Foundation
> + *
> + * Author: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL THE
> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN THE
> + * SOFTWARE.
> + */
> +
> +#include <glib.h>

babeltrace/trace-descriptor.h is part of the public API. We don't want
to expose glib dependency unless utterly necessary.

> +
> +struct bt_trace_descriptor;
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/*
> + * bt_trace_descriptor_get_stream_pos: Get the stream_pos array associat=
ed
> + * with descriptor's trace
> + *
> + * Return: Array of pointers to struct bt_stream_pos
> + */
> +extern const GPtrArray *bt_trace_descriptor_get_stream_pos(
> +	const struct bt_trace_descriptor *descriptor);

Rather than just doing a "getter" to an internal structure, we should
provide an appropriate API that abstracts this.

Thanks,

Mathieu

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
