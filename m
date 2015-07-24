From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 lttng-ust 2/2] Doc: add
 LTTNG_UST_CLOCK_PLUGIN to man page
Date: Fri, 24 Jul 2015 02:22:37 +0000 (UTC)
Message-ID: <945101272.2595.1437704557575.JavaMail.zimbra__45444.6220108823$1437704612$gmane$org@efficios.com>
References: <1437674396-13934-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <1437681771-7495-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <1437681771-7495-2-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZISdH-0008LY-4x
 for lttng-dev@lists.lttng.org; Thu, 23 Jul 2015 22:22:44 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 366863402CC
 for <lttng-dev@lists.lttng.org>; Fri, 24 Jul 2015 02:22:39 +0000 (UTC)
In-Reply-To: <1437681771-7495-2-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged those 2 patches, with a small modification:

"An example can be found in the lttng-ust documentation under
examples/getcpu-override ."

and

"An example can be found in the lttng-ust documentation under
doc/examples/clock-override ."

Otherwise we end up with an installed manpage that points to
subdirectories within the source tree, which is weird. The
examples files are installed too (see e.g.
/usr/local/share/doc/lttng-ust/examples/).

Thanks,

Mathieu

----- On Jul 23, 2015, at 4:02 PM, Jonathan Rajotte jonathan.rajotte-julien@efficios.com wrote:

> Also add indications on how to use the plugin with lttng-tools.
> 
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
> doc/examples/clock-override/README | 4 ++++
> doc/man/lttng-ust.3                | 5 +++++
> 2 files changed, 9 insertions(+)
> 
> diff --git a/doc/examples/clock-override/README
> b/doc/examples/clock-override/README
> index e3ddf22..aabbee2 100644
> --- a/doc/examples/clock-override/README
> +++ b/doc/examples/clock-override/README
> @@ -2,3 +2,7 @@ This clock override example shows how to implement and load a
> clock
> override plugin for LTTng-UST. This can be useful in cases where direct
> hardware access is available for architecture-specific clocks, and where
> it should be used rather than the Linux kernel Monotonic clock.
> +
> +When using LTTng-tools keep in mind that lttng-sessiond uses lttng-ust's clock
> +definition and functions. Thus LTTNG_UST_CLOCK_PLUGIN needs to be defined when
> +launching lttng-sessiond.
> diff --git a/doc/man/lttng-ust.3 b/doc/man/lttng-ust.3
> index e66ab88..8b399aa 100644
> --- a/doc/man/lttng-ust.3
> +++ b/doc/man/lttng-ust.3
> @@ -502,6 +502,11 @@ Used by the getcpu override plugin system. The environment
> variable
> provides the path to the shared object which will act as the getcpu override
> plugin. An example can be found under doc/examples/getcpu-override .
> .PP
> +.IP "LTTNG_UST_CLOCK_PLUGIN"
> +Used by the clock override plugin system. The environment variable
> +provides the path to the shared object wich will act as the clock override
> +plugin. An example can be found under doc/examples/clock-override .
> +.PP
> 
> .SH "SEE ALSO"
> 
> --
> 2.1.4

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
