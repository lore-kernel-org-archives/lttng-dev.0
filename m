From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [LTTNG-TOOLS 2.4 RFC PATCH] Kernel consumer
	generate indexes
Date: Fri, 9 Aug 2013 11:45:31 -0400
Message-ID: <20130809154531.GD13969__12494.7108132348$1376063411$gmane$org@Krystal>
References: <1376061469-30350-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V7ose-00076D-Ad
	for lttng-dev@lists.lttng.org; Fri, 09 Aug 2013 11:45:37 -0400
Content-Disposition: inline
In-Reply-To: <1376061469-30350-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Julien Desfossez (jdesfossez@efficios.com) wrote:
> Some code will be refactored to share between kernel and UST, but
> before going further, I'd like to gather some feedbacks to make
> sure this design is acceptable.
> 
> Thanks,
> 
> Julien
> 
> Signed-off-by: Julien Desfossez <jdesfossez@efficios.com>
> ---
>  include/lttng/lttng-index.h                  |   44 ++++++++++
>  src/common/consumer.c                        |    1 +
>  src/common/consumer.h                        |    4 +
>  src/common/kernel-consumer/kernel-consumer.c |  112 ++++++++++++++++++++++++++
>  src/common/kernel-ctl/kernel-ctl.c           |   36 +++++++++
>  src/common/kernel-ctl/kernel-ctl.h           |    8 ++
>  src/common/kernel-ctl/kernel-ioctl.h         |   13 +++
>  7 files changed, 218 insertions(+)
>  create mode 100644 include/lttng/lttng-index.h
> 
> diff --git a/include/lttng/lttng-index.h b/include/lttng/lttng-index.h
> new file mode 100644
> index 0000000..56f325a
> --- /dev/null
> +++ b/include/lttng/lttng-index.h
> @@ -0,0 +1,44 @@
> +/*
> + * Copyright (C) 2013 - Julien Desfossez <jdesfossez@efficios.com>
> + *                      David Goulet <dgoulet@efficios.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2 only,
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write to the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + */
> +
> +#ifndef LTTNG_INDEX_H
> +#define LTTNG_INDEX_H
> +
> +#include <limits.h>
> +
> +#define INDEX_MAGIC "CTFIDX"
> +#define INDEX_MAJOR 1
> +#define INDEX_MINOR 0
> +
> +struct lttng_packet_index_file_hdr {
> +	char magic[6];
> +	uint32_t index_major;
> +	uint32_t index_minor;
> +} __attribute__((__packed__));
> +
> +struct lttng_packet_index {
> +	uint64_t offset;		/* offset of the packet in the file, in bytes */
> +	uint64_t packet_size;		/* packet size, in bits */
> +	uint64_t content_size;		/* content size, in bits */
> +	uint64_t timestamp_begin;
> +	uint64_t timestamp_end;
> +	uint64_t events_discarded;
> +	uint64_t stream_id;
> +} __attribute__((__packed__));
> +

Please document the endianness of those structures in the header.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
