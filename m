From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [lttng-ust] duplicated struct
 ustctl_consumer_channel_attr
Date: Fri, 10 May 2019 16:31:20 -0400
Message-ID: <20190510203120.GA12097__23529.407305044$1557520309$gmane$org@joraj-alpa>
References: <46193ce3-1320-a982-2cb2-7f5d11596195@gydle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45121B12b1z1KNf
 for <lttng-dev@lists.lttng.org>; Fri, 10 May 2019 16:31:25 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 6D0971E33B1
 for <lttng-dev@lists.lttng.org>; Fri, 10 May 2019 16:31:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46193ce3-1320-a982-2cb2-7f5d11596195@gydle.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Sebastien Boisvert <sboisvert@gydle.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Fri, May 10, 2019 at 03:35:38PM -0400, Sebastien Boisvert wrote:
> Hello,
> 
> As suggested by Jonathan [1], I should start a new email thread.
> 
> Why are there 2 identical declarations of struct ustctl_consumer_channel_attr
> (one in lttng-ust, one in lttng-tools) instead of just one ?
> 

If I remember correctly it is to allow scenario where you want to use
lttng-sessiond as a kernel orchestrator only.

./configure --without-lttng-ust

From src/bin/lttng-sessiond/ust-ctl.h:

/*
 * FIXME: temporary workaround: we use a lttng-tools local version of
 * lttng-ust-abi.h if UST is not found. Eventually, we should use our
 * own internal structures within lttng-tools instead of relying on the
 * UST ABI.
 */
#ifdef HAVE_LIBLTTNG_UST_CTL

#include <lttng/ust-ctl.h>
#include <lttng/ust-abi.h>
#include <lttng/ust-error.h>

int ust_app_release_object(struct ust_app *app, struct lttng_ust_object_data *data);

#else /* HAVE_LIBLTTNG_UST_CTL */

#include "lttng-ust-ctl.h"
#include "lttng-ust-abi.h"
#include "lttng-ust-error.h"

static inline
int ust_app_release_object(struct ust_app *app, struct lttng_ust_object_data *data)
{
	return 0;
}

#endif /* HAVE_LIBLTTNG_UST_CTL */

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
