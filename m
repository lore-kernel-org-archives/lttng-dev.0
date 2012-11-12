From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PATCH 2/2] Use the new functions for default
	subbuf sizes.
Date: Sun, 11 Nov 2012 20:36:33 -0800
Message-ID: <CAFXXi0=xiHpZCrd+cP0-6E4tcnRDVTKcRwRjo6vH8TwpLmoQRA__40946.1514479064$1352695089$gmane$org@mail.gmail.com>
References: <1352694514-25027-1-git-send-email-simon.marchi@polymtl.ca>
	<1352694514-25027-2-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1TXlll-00088T-8F
	for lttng-dev@lists.lttng.org; Sun, 11 Nov 2012 23:37:09 -0500
Received: by mail-pa0-f48.google.com with SMTP id kp12so4079205pab.35
	for <lttng-dev@lists.lttng.org>; Sun, 11 Nov 2012 20:37:03 -0800 (PST)
In-Reply-To: <1352694514-25027-2-git-send-email-simon.marchi@polymtl.ca>
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

Forgot to remove the dot at the end of the title...

On Sun, Nov 11, 2012 at 8:28 PM, Simon Marchi <simon.marchi@polymtl.ca> wrote:
> Use the functions added by the previous commit. All the occurences of
> the previous defines were replaced.
>
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  src/bin/lttng-sessiond/channel.c         |    4 ++--
>  src/bin/lttng-sessiond/trace-kernel.c    |    2 +-
>  src/bin/lttng-sessiond/trace-ust.c       |    2 +-
>  src/bin/lttng/commands/enable_channels.c |    6 +++---
>  src/lib/lttng-ctl/lttng-ctl.c            |    4 ++--
>  tests/tools/Makefile.am                  |    2 +-
>  tests/tools/test_kernel_data_trace.c     |    2 +-
>  tests/tools/test_ust_data_trace.c        |    2 +-
>  8 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/src/bin/lttng-sessiond/channel.c b/src/bin/lttng-sessiond/channel.c
> index 8b9adfb..a942ff5 100644
> --- a/src/bin/lttng-sessiond/channel.c
> +++ b/src/bin/lttng-sessiond/channel.c
> @@ -54,7 +54,7 @@ struct lttng_channel *channel_new_default_attr(int dom)
>
>         switch (dom) {
>         case LTTNG_DOMAIN_KERNEL:
> -               chan->attr.subbuf_size = DEFAULT_KERNEL_CHANNEL_SUBBUF_SIZE;
> +               chan->attr.subbuf_size = default_get_kernel_channel_subbuf_size();
>                 chan->attr.num_subbuf = DEFAULT_KERNEL_CHANNEL_SUBBUF_NUM;
>                 chan->attr.output = DEFAULT_KERNEL_CHANNEL_OUTPUT;
>                 break;
> @@ -64,7 +64,7 @@ struct lttng_channel *channel_new_default_attr(int dom)
>         case LTTNG_DOMAIN_UST_PID_FOLLOW_CHILDREN:
>         case LTTNG_DOMAIN_UST_EXEC_NAME:
>  #endif
> -               chan->attr.subbuf_size = DEFAULT_UST_CHANNEL_SUBBUF_SIZE;
> +               chan->attr.subbuf_size = default_get_ust_channel_subbuf_size();
>                 chan->attr.num_subbuf = DEFAULT_UST_CHANNEL_SUBBUF_NUM;
>                 chan->attr.output = DEFAULT_UST_CHANNEL_OUTPUT;
>                 break;
> diff --git a/src/bin/lttng-sessiond/trace-kernel.c b/src/bin/lttng-sessiond/trace-kernel.c
> index 7748b89..4d2870a 100644
> --- a/src/bin/lttng-sessiond/trace-kernel.c
> +++ b/src/bin/lttng-sessiond/trace-kernel.c
> @@ -272,7 +272,7 @@ struct ltt_kernel_metadata *trace_kernel_create_metadata(void)
>
>         /* Set default attributes */
>         chan->attr.overwrite = DEFAULT_CHANNEL_OVERWRITE;
> -       chan->attr.subbuf_size = DEFAULT_METADATA_SUBBUF_SIZE;
> +       chan->attr.subbuf_size = default_get_metadata_subbuf_size();
>         chan->attr.num_subbuf = DEFAULT_METADATA_SUBBUF_NUM;
>         chan->attr.switch_timer_interval = DEFAULT_CHANNEL_SWITCH_TIMER;
>         chan->attr.read_timer_interval = DEFAULT_CHANNEL_READ_TIMER;
> diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/trace-ust.c
> index 864a4b0..2dcc7c2 100644
> --- a/src/bin/lttng-sessiond/trace-ust.c
> +++ b/src/bin/lttng-sessiond/trace-ust.c
> @@ -311,7 +311,7 @@ struct ltt_ust_metadata *trace_ust_create_metadata(char *path)
>
>         /* Set default attributes */
>         lum->attr.overwrite = DEFAULT_CHANNEL_OVERWRITE;
> -       lum->attr.subbuf_size = DEFAULT_METADATA_SUBBUF_SIZE;
> +       lum->attr.subbuf_size = default_get_metadata_subbuf_size();
>         lum->attr.num_subbuf = DEFAULT_METADATA_SUBBUF_NUM;
>         lum->attr.switch_timer_interval = DEFAULT_CHANNEL_SWITCH_TIMER;
>         lum->attr.read_timer_interval = DEFAULT_CHANNEL_READ_TIMER;
> diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/commands/enable_channels.c
> index 1857477..d9a3b02 100644
> --- a/src/bin/lttng/commands/enable_channels.c
> +++ b/src/bin/lttng/commands/enable_channels.c
> @@ -101,9 +101,9 @@ static void usage(FILE *ofp)
>         fprintf(ofp, "      --overwrite          Flight recorder mode%s\n",
>                 DEFAULT_CHANNEL_OVERWRITE ? " (default)" : "");
>         fprintf(ofp, "      --subbuf-size SIZE   Subbuffer size in bytes\n");
> -       fprintf(ofp, "                               (default: %u, kernel default: %u)\n",
> -               DEFAULT_CHANNEL_SUBBUF_SIZE,
> -               DEFAULT_KERNEL_CHANNEL_SUBBUF_SIZE);
> +       fprintf(ofp, "                               (default: %zu, kernel default: %zu)\n",
> +               default_get_channel_subbuf_size(),
> +               default_get_kernel_channel_subbuf_size());
>         fprintf(ofp, "                               Needs to be a power of 2 for\n");
>          fprintf(ofp, "                               kernel and ust tracers\n");
>         fprintf(ofp, "      --num-subbuf NUM     Number of subbufers\n");
> diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
> index 46338fb..20bb8c6 100644
> --- a/src/lib/lttng-ctl/lttng-ctl.c
> +++ b/src/lib/lttng-ctl/lttng-ctl.c
> @@ -1344,7 +1344,7 @@ void lttng_channel_set_default_attr(struct lttng_domain *domain,
>                 attr->switch_timer_interval = DEFAULT_CHANNEL_SWITCH_TIMER;
>                 attr->read_timer_interval = DEFAULT_CHANNEL_READ_TIMER;
>
> -               attr->subbuf_size = DEFAULT_KERNEL_CHANNEL_SUBBUF_SIZE;
> +               attr->subbuf_size = default_get_kernel_channel_subbuf_size();
>                 attr->num_subbuf = DEFAULT_KERNEL_CHANNEL_SUBBUF_NUM;
>                 attr->output = DEFAULT_KERNEL_CHANNEL_OUTPUT;
>                 break;
> @@ -1358,7 +1358,7 @@ void lttng_channel_set_default_attr(struct lttng_domain *domain,
>                 attr->switch_timer_interval = DEFAULT_CHANNEL_SWITCH_TIMER;
>                 attr->read_timer_interval = DEFAULT_CHANNEL_READ_TIMER;
>
> -               attr->subbuf_size = DEFAULT_UST_CHANNEL_SUBBUF_SIZE;
> +               attr->subbuf_size = default_get_ust_channel_subbuf_size();
>                 attr->num_subbuf = DEFAULT_UST_CHANNEL_SUBBUF_NUM;
>                 attr->output = DEFAULT_UST_CHANNEL_OUTPUT;
>                 break;
> diff --git a/tests/tools/Makefile.am b/tests/tools/Makefile.am
> index cd7ff32..4fe494c 100644
> --- a/tests/tools/Makefile.am
> +++ b/tests/tools/Makefile.am
> @@ -27,7 +27,7 @@ test_sessions_LDADD = $(COMMON) $(HASHTABLE) $(SESSIOND_COMM)
>
>  # Kernel trace data unit tests
>  test_kernel_data_trace_SOURCES = test_kernel_data_trace.c $(UTILS) $(KERN_DATA_TRACE)
> -test_kernel_data_trace_LDADD = $(SESSIOND_COMM) $(HASHTABLE)
> +test_kernel_data_trace_LDADD = $(COMMON) $(SESSIOND_COMM) $(HASHTABLE)
>
>  if HAVE_LIBLTTNG_UST_CTL
>  noinst_PROGRAMS += test_ust_data_trace
> diff --git a/tests/tools/test_kernel_data_trace.c b/tests/tools/test_kernel_data_trace.c
> index c49d7ce..1edd20d 100644
> --- a/tests/tools/test_kernel_data_trace.c
> +++ b/tests/tools/test_kernel_data_trace.c
> @@ -99,7 +99,7 @@ static void create_kernel_metadata(void)
>         assert(kern->metadata->conf->attr.overwrite
>                         == DEFAULT_CHANNEL_OVERWRITE);
>         assert(kern->metadata->conf->attr.subbuf_size
> -                       == DEFAULT_METADATA_SUBBUF_SIZE);
> +                       == default_get_metadata_subbuf_size());
>         assert(kern->metadata->conf->attr.num_subbuf
>                         == DEFAULT_METADATA_SUBBUF_NUM);
>         assert(kern->metadata->conf->attr.switch_timer_interval
> diff --git a/tests/tools/test_ust_data_trace.c b/tests/tools/test_ust_data_trace.c
> index 459520d..69a73b2 100644
> --- a/tests/tools/test_ust_data_trace.c
> +++ b/tests/tools/test_ust_data_trace.c
> @@ -107,7 +107,7 @@ static void create_ust_metadata(void)
>         assert(metadata->attr.overwrite
>                         == DEFAULT_CHANNEL_OVERWRITE);
>         assert(metadata->attr.subbuf_size
> -                       == DEFAULT_METADATA_SUBBUF_SIZE);
> +                       == default_get_metadata_subbuf_size());
>         assert(metadata->attr.num_subbuf
>                         == DEFAULT_METADATA_SUBBUF_NUM);
>         assert(metadata->attr.switch_timer_interval
> --
> 1.7.1
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
