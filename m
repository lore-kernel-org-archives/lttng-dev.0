From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: split UST per
	UID/PID	default values
Date: Tue, 7 May 2013 15:24:55 -0400
Message-ID: <20130507192455.GA8394__5219.63762953437$1367954733$gmane$org@Krystal>
References: <1367953750-7731-1-git-send-email-dgoulet@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UZnVS-0004v7-B4
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 15:24:58 -0400
Content-Disposition: inline
In-Reply-To: <1367953750-7731-1-git-send-email-dgoulet@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* David Goulet (dgoulet@efficios.com) wrote:
> The default per UID subbuffer size are changed from 4096 bytes to 131072
> bytes (128k). The rest have the same values as before.
> =

> Some DEFAULT_CHANNEL_* macros are prefixed with an underscore making
> sure they are not used elsewhere in the code base and only domain
> specific values are used.

Looks good, except for one small question: the metadata defaults (e.g.
DEFAULT_METADATA_SWITCH_TIMER) don't seem to appear anywhere in the
help/manpage. Any idea on how we could fix that ?

Thanks,

Mathieu


> =

> Fixes #524
> =

> Signed-off-by: David Goulet <dgoulet@efficios.com>
> ---
>  doc/man/lttng.1                          |   15 ++++--
>  src/bin/lttng-sessiond/channel.c         |   59 ++++++++++++++-------
>  src/bin/lttng-sessiond/channel.h         |    3 +-
>  src/bin/lttng-sessiond/cmd.c             |   14 +++--
>  src/bin/lttng-sessiond/trace-ust.c       |    4 +-
>  src/bin/lttng-sessiond/ust-app.c         |    4 +-
>  src/bin/lttng/commands/enable_channels.c |   32 ++++++++----
>  src/common/defaults.c                    |   11 ++--
>  src/common/defaults.h                    |   84 +++++++++++++++++-------=
------
>  src/lib/lttng-ctl/lttng-ctl.c            |   36 ++++++++-----
>  tests/unit/test_ust_data.c               |    4 +-
>  11 files changed, 168 insertions(+), 98 deletions(-)
> =

> diff --git a/doc/man/lttng.1 b/doc/man/lttng.1
> index 37c2063..aa98990 100644
> --- a/doc/man/lttng.1
> +++ b/doc/man/lttng.1
> @@ -327,17 +327,21 @@ same type.
>  \-\-overwrite
>          Flight recorder mode : overwrites events when subbuffers are full
>  \-\-subbuf-size SIZE
> -        Subbuffer size in bytes {+k,+M,+G} (default: 4096, kernel defaul=
t: 262144)
> +        Subbuffer size in bytes {+k,+M,+G}
> +        (default UST uid: 131072, UST pid: 4096, kernel: 262144)
>          Rounded up to the next power of 2.
>  \-\-num-subbuf NUM
> -        Number of subbuffers (default: 4)
> +        Number of subbuffers. (default UST uid: 4, UST pid: 4, kernel: 4)
>          Rounded up to the next power of 2.
>  \-\-switch-timer USEC
> -        Switch subbuffer timer interval in =B5sec (default: 0)
> +        Switch subbuffer timer interval in =B5sec.
> +        (default UST uid: 0, UST pid: 0, kernel: 0)
>  \-\-read-timer USEC
> -        Read timer interval in =B5sec (UST default: 0, kernel default: 2=
00000)
> +        Read timer interval in =B5sec.
> +        (default UST uid: 0, UST pid: 0, kernel: 200000)
>  \-\-output TYPE
>          Channel output type. Possible values: mmap, splice
> +        (default UST uid: mmap, UST pid: mmap, kernel: splice)
>  \-\-buffers-uid
>          Use per UID buffer (\-u only). Buffers are shared between applic=
ations
>          that have the same UID.
> @@ -347,9 +351,10 @@ same type.
>          Use shared buffer for the whole system (\-k only)
>  \-C, \-\-tracefile-size SIZE
>          Maximum size of each tracefile within a stream (in bytes).
> +		0 means unlimited. (default: 0)
>  \-W, \-\-tracefile-count COUNT
>          Used in conjunction with \-C option, this will limit the number
> -        of files created to the specified count.
> +        of files created to the specified count. 0 means unlimited. (def=
ault: 0)
>  =

>  .B EXAMPLES:
>  =

> diff --git a/src/bin/lttng-sessiond/channel.c b/src/bin/lttng-sessiond/ch=
annel.c
> index ff2db69..8f835fd 100644
> --- a/src/bin/lttng-sessiond/channel.c
> +++ b/src/bin/lttng-sessiond/channel.c
> @@ -33,7 +33,8 @@
>  /*
>   * Return allocated channel attributes.
>   */
> -struct lttng_channel *channel_new_default_attr(int dom)
> +struct lttng_channel *channel_new_default_attr(int dom,
> +		enum lttng_buffer_type type)
>  {
>  	struct lttng_channel *chan;
>  =

> @@ -49,10 +50,14 @@ struct lttng_channel *channel_new_default_attr(int do=
m)
>  		goto error;
>  	}
>  =

> +	/* Same for all domains. */
>  	chan->attr.overwrite =3D DEFAULT_CHANNEL_OVERWRITE;
> +	chan->attr.tracefile_size =3D DEFAULT_CHANNEL_TRACEFILE_SIZE;
> +	chan->attr.tracefile_count =3D DEFAULT_CHANNEL_TRACEFILE_COUNT;
>  =

>  	switch (dom) {
>  	case LTTNG_DOMAIN_KERNEL:
> +		assert(type =3D=3D LTTNG_BUFFER_GLOBAL);
>  		chan->attr.subbuf_size =3D
>  			default_get_kernel_channel_subbuf_size();
>  		chan->attr.num_subbuf =3D DEFAULT_KERNEL_CHANNEL_SUBBUF_NUM;
> @@ -61,16 +66,27 @@ struct lttng_channel *channel_new_default_attr(int do=
m)
>  		chan->attr.read_timer_interval =3D DEFAULT_KERNEL_CHANNEL_READ_TIMER;
>  		break;
>  	case LTTNG_DOMAIN_UST:
> -#if 0
> -	case LTTNG_DOMAIN_UST_PID:
> -	case LTTNG_DOMAIN_UST_PID_FOLLOW_CHILDREN:
> -	case LTTNG_DOMAIN_UST_EXEC_NAME:
> -#endif
> -		chan->attr.subbuf_size =3D default_get_ust_channel_subbuf_size();
> -		chan->attr.num_subbuf =3D DEFAULT_UST_CHANNEL_SUBBUF_NUM;
> -		chan->attr.output =3D DEFAULT_UST_CHANNEL_OUTPUT;
> -		chan->attr.switch_timer_interval =3D DEFAULT_UST_CHANNEL_SWITCH_TIMER;
> -		chan->attr.read_timer_interval =3D DEFAULT_UST_CHANNEL_READ_TIMER;
> +		switch (type) {
> +		case LTTNG_BUFFER_PER_UID:
> +			chan->attr.subbuf_size =3D default_get_ust_uid_channel_subbuf_size();
> +			chan->attr.num_subbuf =3D DEFAULT_UST_UID_CHANNEL_SUBBUF_NUM;
> +			chan->attr.output =3D DEFAULT_UST_UID_CHANNEL_OUTPUT;
> +			chan->attr.switch_timer_interval =3D
> +				DEFAULT_UST_UID_CHANNEL_SWITCH_TIMER;
> +			chan->attr.read_timer_interval =3D
> +				DEFAULT_UST_UID_CHANNEL_READ_TIMER;
> +			break;
> +		case LTTNG_BUFFER_PER_PID:
> +		default:
> +			chan->attr.subbuf_size =3D default_get_ust_pid_channel_subbuf_size();
> +			chan->attr.num_subbuf =3D DEFAULT_UST_PID_CHANNEL_SUBBUF_NUM;
> +			chan->attr.output =3D DEFAULT_UST_PID_CHANNEL_OUTPUT;
> +			chan->attr.switch_timer_interval =3D
> +				DEFAULT_UST_PID_CHANNEL_SWITCH_TIMER;
> +			chan->attr.read_timer_interval =3D
> +				DEFAULT_UST_PID_CHANNEL_READ_TIMER;
> +			break;
> +		}
>  		break;
>  	default:
>  		goto error;	/* Not implemented */
> @@ -158,7 +174,8 @@ int channel_kernel_create(struct ltt_kernel_session *=
ksession,
>  =

>  	/* Creating channel attributes if needed */
>  	if (attr =3D=3D NULL) {
> -		defattr =3D channel_new_default_attr(LTTNG_DOMAIN_KERNEL);
> +		defattr =3D channel_new_default_attr(LTTNG_DOMAIN_KERNEL,
> +				LTTNG_BUFFER_GLOBAL);
>  		if (defattr =3D=3D NULL) {
>  			ret =3D LTTNG_ERR_FATAL;
>  			goto error;
> @@ -237,7 +254,7 @@ int channel_ust_create(struct ltt_ust_session *usess,
>  =

>  	/* Creating channel attributes if needed */
>  	if (attr =3D=3D NULL) {
> -		defattr =3D channel_new_default_attr(LTTNG_DOMAIN_UST);
> +		defattr =3D channel_new_default_attr(LTTNG_DOMAIN_UST, type);
>  		if (defattr =3D=3D NULL) {
>  			ret =3D LTTNG_ERR_FATAL;
>  			goto error;
> @@ -245,11 +262,6 @@ int channel_ust_create(struct ltt_ust_session *usess,
>  		attr =3D defattr;
>  	}
>  =

> -	if (attr->attr.subbuf_size < DEFAULT_UST_CHANNEL_SUBBUF_SIZE) {
> -		ret =3D LTTNG_ERR_INVALID;
> -		goto error;
> -	}
> -
>  	/*
>  	 * Validate UST buffer size and number of buffers: must both be power o=
f 2
>  	 * and nonzero. We validate right here for UST, because applications wi=
ll
> @@ -285,7 +297,18 @@ int channel_ust_create(struct ltt_ust_session *usess,
>  	/* Validate buffer type. */
>  	switch (type) {
>  	case LTTNG_BUFFER_PER_PID:
> +		if (attr->attr.subbuf_size <
> +				default_get_ust_pid_channel_subbuf_size()) {
> +			ret =3D LTTNG_ERR_INVALID;
> +			goto error;
> +		}
> +		break;
>  	case LTTNG_BUFFER_PER_UID:
> +		if (attr->attr.subbuf_size <
> +				default_get_ust_uid_channel_subbuf_size()) {
> +			ret =3D LTTNG_ERR_INVALID;
> +			goto error;
> +		}
>  		break;
>  	default:
>  		ret =3D LTTNG_ERR_BUFFER_NOT_SUPPORTED;
> diff --git a/src/bin/lttng-sessiond/channel.h b/src/bin/lttng-sessiond/ch=
annel.h
> index 7fbbb4c..15cabea 100644
> --- a/src/bin/lttng-sessiond/channel.h
> +++ b/src/bin/lttng-sessiond/channel.h
> @@ -30,7 +30,8 @@ int channel_kernel_enable(struct ltt_kernel_session *ks=
ession,
>  int channel_kernel_create(struct ltt_kernel_session *ksession,
>  		struct lttng_channel *chan, int kernel_pipe);
>  =

> -struct lttng_channel *channel_new_default_attr(int domain);
> +struct lttng_channel *channel_new_default_attr(int domain,
> +		enum lttng_buffer_type type);
>  =

>  int channel_ust_create(struct ltt_ust_session *usess,
>  		struct lttng_channel *attr, enum lttng_buffer_type type);
> diff --git a/src/bin/lttng-sessiond/cmd.c b/src/bin/lttng-sessiond/cmd.c
> index 5d2cba1..528665a 100644
> --- a/src/bin/lttng-sessiond/cmd.c
> +++ b/src/bin/lttng-sessiond/cmd.c
> @@ -1106,7 +1106,7 @@ int cmd_add_context(struct ltt_session *session, in=
t domain,
>  		if (chan_count =3D=3D 0) {
>  			struct lttng_channel *attr;
>  			/* Create default channel */
> -			attr =3D channel_new_default_attr(domain);
> +			attr =3D channel_new_default_attr(domain, usess->buffer_type);
>  			if (attr =3D=3D NULL) {
>  				ret =3D LTTNG_ERR_FATAL;
>  				goto error;
> @@ -1166,7 +1166,8 @@ int cmd_enable_event(struct ltt_session *session, s=
truct lttng_domain *domain,
>  		kchan =3D trace_kernel_get_channel_by_name(channel_name,
>  				session->kernel_session);
>  		if (kchan =3D=3D NULL) {
> -			attr =3D channel_new_default_attr(LTTNG_DOMAIN_KERNEL);
> +			attr =3D channel_new_default_attr(LTTNG_DOMAIN_KERNEL,
> +					LTTNG_BUFFER_GLOBAL);
>  			if (attr =3D=3D NULL) {
>  				ret =3D LTTNG_ERR_FATAL;
>  				goto error;
> @@ -1216,7 +1217,8 @@ int cmd_enable_event(struct ltt_session *session, s=
truct lttng_domain *domain,
>  				channel_name);
>  		if (uchan =3D=3D NULL) {
>  			/* Create default channel */
> -			attr =3D channel_new_default_attr(LTTNG_DOMAIN_UST);
> +			attr =3D channel_new_default_attr(LTTNG_DOMAIN_UST,
> +					usess->buffer_type);
>  			if (attr =3D=3D NULL) {
>  				ret =3D LTTNG_ERR_FATAL;
>  				goto error;
> @@ -1286,7 +1288,8 @@ int cmd_enable_event_all(struct ltt_session *sessio=
n,
>  				session->kernel_session);
>  		if (kchan =3D=3D NULL) {
>  			/* Create default channel */
> -			attr =3D channel_new_default_attr(LTTNG_DOMAIN_KERNEL);
> +			attr =3D channel_new_default_attr(LTTNG_DOMAIN_KERNEL,
> +					LTTNG_BUFFER_GLOBAL);
>  			if (attr =3D=3D NULL) {
>  				ret =3D LTTNG_ERR_FATAL;
>  				goto error;
> @@ -1350,7 +1353,8 @@ int cmd_enable_event_all(struct ltt_session *sessio=
n,
>  				channel_name);
>  		if (uchan =3D=3D NULL) {
>  			/* Create default channel */
> -			attr =3D channel_new_default_attr(LTTNG_DOMAIN_UST);
> +			attr =3D channel_new_default_attr(LTTNG_DOMAIN_UST,
> +					usess->buffer_type);
>  			if (attr =3D=3D NULL) {
>  				ret =3D LTTNG_ERR_FATAL;
>  				goto error;
> diff --git a/src/bin/lttng-sessiond/trace-ust.c b/src/bin/lttng-sessiond/=
trace-ust.c
> index 7592d77..8fb685c 100644
> --- a/src/bin/lttng-sessiond/trace-ust.c
> +++ b/src/bin/lttng-sessiond/trace-ust.c
> @@ -384,8 +384,8 @@ struct ltt_ust_metadata *trace_ust_create_metadata(ch=
ar *path)
>  	lum->attr.overwrite =3D DEFAULT_CHANNEL_OVERWRITE;
>  	lum->attr.subbuf_size =3D default_get_metadata_subbuf_size();
>  	lum->attr.num_subbuf =3D DEFAULT_METADATA_SUBBUF_NUM;
> -	lum->attr.switch_timer_interval =3D DEFAULT_UST_CHANNEL_SWITCH_TIMER;
> -	lum->attr.read_timer_interval =3D DEFAULT_UST_CHANNEL_READ_TIMER;
> +	lum->attr.switch_timer_interval =3D DEFAULT_METADATA_SWITCH_TIMER;
> +	lum->attr.read_timer_interval =3D DEFAULT_METADATA_READ_TIMER;
>  	lum->attr.output =3D LTTNG_UST_MMAP;
>  =

>  	lum->handle =3D -1;
> diff --git a/src/bin/lttng-sessiond/ust-app.c b/src/bin/lttng-sessiond/us=
t-app.c
> index e362381..5710226 100644
> --- a/src/bin/lttng-sessiond/ust-app.c
> +++ b/src/bin/lttng-sessiond/ust-app.c
> @@ -2527,8 +2527,8 @@ static int create_ust_app_metadata(struct ust_app_s=
ession *ua_sess,
>  		metadata->attr.overwrite =3D DEFAULT_CHANNEL_OVERWRITE;
>  		metadata->attr.subbuf_size =3D default_get_metadata_subbuf_size();
>  		metadata->attr.num_subbuf =3D DEFAULT_METADATA_SUBBUF_NUM;
> -		metadata->attr.switch_timer_interval =3D DEFAULT_UST_CHANNEL_SWITCH_TI=
MER;
> -		metadata->attr.read_timer_interval =3D DEFAULT_UST_CHANNEL_READ_TIMER;
> +		metadata->attr.switch_timer_interval =3D DEFAULT_METADATA_SWITCH_TIMER;
> +		metadata->attr.read_timer_interval =3D DEFAULT_METADATA_READ_TIMER;
>  		metadata->attr.output =3D LTTNG_UST_MMAP;
>  		metadata->attr.type =3D LTTNG_UST_CHAN_METADATA;
>  	} else {
> diff --git a/src/bin/lttng/commands/enable_channels.c b/src/bin/lttng/com=
mands/enable_channels.c
> index 4816d62..c7bbca1 100644
> --- a/src/bin/lttng/commands/enable_channels.c
> +++ b/src/bin/lttng/commands/enable_channels.c
> @@ -104,28 +104,40 @@ static void usage(FILE *ofp)
>  	fprintf(ofp, "      --overwrite          Flight recorder mode%s\n",
>  		DEFAULT_CHANNEL_OVERWRITE ? " (default)" : "");
>  	fprintf(ofp, "      --subbuf-size SIZE   Subbuffer size in bytes {+k,+M=
,+G}\n");
> -	fprintf(ofp, "                               (default: %zu, kernel defa=
ult: %zu)\n",
> -		default_get_channel_subbuf_size(),
> +	fprintf(ofp, "                               (default UST uid: %zu, UST=
 pid: %zu, kernel: %zu)\n",
> +		default_get_ust_uid_channel_subbuf_size(),
> +		default_get_ust_pid_channel_subbuf_size(),
>  		default_get_kernel_channel_subbuf_size());
>  	fprintf(ofp, "                               Rounded up to the next pow=
er of 2.\n");
>  	fprintf(ofp, "      --num-subbuf NUM     Number of subbufers\n");
> -	fprintf(ofp, "                               (default: %u)\n",
> -		DEFAULT_CHANNEL_SUBBUF_NUM);
> +	fprintf(ofp, "                               (default UST uid: %u, UST =
pid: %u, kernel: %u)\n",
> +		DEFAULT_UST_UID_CHANNEL_SUBBUF_NUM, DEFAULT_UST_PID_CHANNEL_SUBBUF_NUM,
> +		DEFAULT_KERNEL_CHANNEL_SUBBUF_NUM);
>  	fprintf(ofp, "                               Rounded up to the next pow=
er of 2.\n");
> -	fprintf(ofp, "      --switch-timer USEC  Switch timer interval in usec =
(default: %u)\n",
> -		DEFAULT_CHANNEL_SWITCH_TIMER);
> -	fprintf(ofp, "      --read-timer USEC    Read timer interval in usec (U=
ST default: %u, kernel default: %u)\n",
> -		DEFAULT_UST_CHANNEL_READ_TIMER, DEFAULT_KERNEL_CHANNEL_READ_TIMER);
> +	fprintf(ofp, "      --switch-timer USEC  Switch timer interval in usec\=
n");
> +	fprintf(ofp, "                               (default UST uid: %u, UST =
pid: %u, kernel: %u)\n",
> +		DEFAULT_UST_UID_CHANNEL_SWITCH_TIMER, DEFAULT_UST_PID_CHANNEL_SWITCH_T=
IMER,
> +		DEFAULT_KERNEL_CHANNEL_SWITCH_TIMER);
> +	fprintf(ofp, "      --read-timer USEC    Read timer interval in usec.\n=
");
> +	fprintf(ofp, "                               (default UST uid: %u, UST =
pid: %u, kernel: %u)\n",
> +		DEFAULT_UST_UID_CHANNEL_READ_TIMER, DEFAULT_UST_UID_CHANNEL_READ_TIMER,
> +		DEFAULT_KERNEL_CHANNEL_READ_TIMER);
>  	fprintf(ofp, "      --output TYPE        Channel output type (Values: %=
s, %s)\n",
>  			output_mmap, output_splice);
> +	fprintf(ofp, "                               (default UST uid: %s, UST =
pid: %s, kernel: %s)\n",
> +			DEFAULT_UST_UID_CHANNEL_OUTPUT =3D=3D LTTNG_EVENT_MMAP ? output_mmap =
: output_splice,
> +			DEFAULT_UST_PID_CHANNEL_OUTPUT =3D=3D LTTNG_EVENT_MMAP ? output_mmap =
: output_splice,
> +			DEFAULT_KERNEL_CHANNEL_OUTPUT =3D=3D LTTNG_EVENT_MMAP ? output_mmap :=
 output_splice);
>  	fprintf(ofp, "      --buffers-uid        Use per UID buffer (-u only)\n=
");
>  	fprintf(ofp, "      --buffers-pid        Use per PID buffer (-u only)\n=
");
>  	fprintf(ofp, "      --buffers-global     Use shared buffer for the whol=
e system (-k only)\n");
>  	fprintf(ofp, "  -C, --tracefile-size SIZE\n");
> -	fprintf(ofp, "                           Maximum size of each tracefile=
 within a stream (in bytes).\n");
> +	fprintf(ofp, "                           Maximum size of each tracefile=
 within a stream (in bytes). 0 means unlimited.\n");
> +	fprintf(ofp, "                               (default: %u)\n", DEFAULT_=
CHANNEL_TRACEFILE_SIZE);
>  	fprintf(ofp, "  -W, --tracefile-count COUNT\n");
>  	fprintf(ofp, "                           Used in conjunction with -C op=
tion, this will limit the number\n");
> -	fprintf(ofp, "                           of files created to the specif=
ied count.\n");
> +	fprintf(ofp, "                           of files created to the specif=
ied count. 0 means unlimited.\n");
> +	fprintf(ofp, "                               (default: %u)\n", DEFAULT_=
CHANNEL_TRACEFILE_COUNT);
>  	fprintf(ofp, "\n");
>  }
>  =

> diff --git a/src/common/defaults.c b/src/common/defaults.c
> index ccdbaf4..d74a42b 100644
> --- a/src/common/defaults.c
> +++ b/src/common/defaults.c
> @@ -24,7 +24,8 @@
>  size_t default_channel_subbuf_size;
>  size_t default_metadata_subbuf_size;
>  size_t default_kernel_channel_subbuf_size;
> -size_t default_ust_channel_subbuf_size;
> +size_t default_ust_pid_channel_subbuf_size;
> +size_t default_ust_uid_channel_subbuf_size;
>  =

>  static void __attribute__((constructor)) init_defaults(void)
>  {
> @@ -39,11 +40,13 @@ static void __attribute__((constructor)) init_default=
s(void)
>  	}
>  =

>  	default_channel_subbuf_size =3D
> -		max(DEFAULT_CHANNEL_SUBBUF_SIZE, page_size);
> +		max(_DEFAULT_CHANNEL_SUBBUF_SIZE, page_size);
>  	default_metadata_subbuf_size =3D
>  		max(DEFAULT_METADATA_SUBBUF_SIZE, page_size);
>  	default_kernel_channel_subbuf_size =3D
>  		max(DEFAULT_KERNEL_CHANNEL_SUBBUF_SIZE, page_size);
> -	default_ust_channel_subbuf_size =3D
> -		max(DEFAULT_UST_CHANNEL_SUBBUF_SIZE, page_size);
> +	default_ust_pid_channel_subbuf_size =3D
> +		max(DEFAULT_UST_PID_CHANNEL_SUBBUF_SIZE, page_size);
> +	default_ust_uid_channel_subbuf_size =3D
> +		max(DEFAULT_UST_UID_CHANNEL_SUBBUF_SIZE, page_size);
>  }
> diff --git a/src/common/defaults.h b/src/common/defaults.h
> index fb6a975..2c73277 100644
> --- a/src/common/defaults.h
> +++ b/src/common/defaults.h
> @@ -112,55 +112,57 @@
>  =

>  /* Default channel attributes */
>  #define DEFAULT_CHANNEL_NAME            "channel0"
> -#define DEFAULT_CHANNEL_OVERWRITE       0       /* usec */
> -/* DEFAULT_CHANNEL_SUBBUF_SIZE must always be a power of 2 */
> -#define DEFAULT_CHANNEL_SUBBUF_SIZE     4096    /* bytes */
> -/* DEFAULT_CHANNEL_SUBBUF_NUM must always be a power of 2 */
> -#define DEFAULT_CHANNEL_SUBBUF_NUM      4
> -#define DEFAULT_CHANNEL_SWITCH_TIMER    0       /* usec */
> -#define DEFAULT_CHANNEL_READ_TIMER      200000  /* usec */
> -#define DEFAULT_CHANNEL_OUTPUT          LTTNG_EVENT_MMAP
> -
> +#define DEFAULT_CHANNEL_OVERWRITE       0
> +#define DEFAULT_CHANNEL_TRACEFILE_SIZE  0
> +#define DEFAULT_CHANNEL_TRACEFILE_COUNT 0
> +
> +/* Must always be a power of 2 */
> +#define _DEFAULT_CHANNEL_SUBBUF_SIZE	4096    /* bytes */
> +/* Must always be a power of 2 */
> +#define _DEFAULT_CHANNEL_SUBBUF_NUM		4
> +#define _DEFAULT_CHANNEL_SWITCH_TIMER	0       /* usec */
> +#define _DEFAULT_CHANNEL_READ_TIMER		200000  /* usec */
> +#define _DEFAULT_CHANNEL_OUTPUT			LTTNG_EVENT_MMAP
> +
> +/* Metadata channel defaults. */
>  #define DEFAULT_METADATA_SUBBUF_SIZE    4096
>  #define DEFAULT_METADATA_SUBBUF_NUM     2
>  #define DEFAULT_METADATA_CACHE_SIZE     4096
> +#define DEFAULT_METADATA_SWITCH_TIMER	_DEFAULT_CHANNEL_SWITCH_TIMER
> +#define DEFAULT_METADATA_READ_TIMER		_DEFAULT_CHANNEL_READ_TIMER
> +#define DEFAULT_METADATA_OUTPUT			_DEFAULT_CHANNEL_OUTPUT
>  =

>  /* Kernel has different defaults */
>  =

>  /* DEFAULT_KERNEL_CHANNEL_SUBBUF_SIZE must always be a power of 2 */
> -#define DEFAULT_KERNEL_CHANNEL_SUBBUF_SIZE  262144    /* bytes */
> +#define DEFAULT_KERNEL_CHANNEL_SUBBUF_SIZE		262144    /* bytes */
>  /*
>   * DEFAULT_KERNEL_CHANNEL_SUBBUF_NUM must always be a power of 2.
>   * Update help manually if override.
>   */
> -#define DEFAULT_KERNEL_CHANNEL_SUBBUF_NUM   DEFAULT_CHANNEL_SUBBUF_NUM
> +#define DEFAULT_KERNEL_CHANNEL_SUBBUF_NUM		_DEFAULT_CHANNEL_SUBBUF_NUM
>  /* See lttng-kernel.h enum lttng_kernel_output for channel output */
> -#define DEFAULT_KERNEL_CHANNEL_OUTPUT       LTTNG_EVENT_SPLICE
> -/* By default, unlimited tracefile size */
> -#define DEFAULT_KERNEL_CHANNEL_TRACEFILE_SIZE  0
> -/* By default, unlimited tracefile count */
> -#define DEFAULT_KERNEL_CHANNEL_TRACEFILE_COUNT 0
> -
> -#define DEFAULT_KERNEL_CHANNEL_SWITCH_TIMER	\
> -		DEFAULT_CHANNEL_SWITCH_TIMER
> -#define DEFAULT_KERNEL_CHANNEL_READ_TIMER      200000  /* usec */
> +#define DEFAULT_KERNEL_CHANNEL_OUTPUT			LTTNG_EVENT_SPLICE
> +#define DEFAULT_KERNEL_CHANNEL_SWITCH_TIMER		_DEFAULT_CHANNEL_SWITCH_TIM=
ER
> +#define DEFAULT_KERNEL_CHANNEL_READ_TIMER		_DEFAULT_CHANNEL_READ_TIMER
>  =

>  /* User space defaults */
>  =

>  /* Must be a power of 2 */
> -#define DEFAULT_UST_CHANNEL_SUBBUF_SIZE     4096    /* bytes */
> +#define DEFAULT_UST_PID_CHANNEL_SUBBUF_SIZE		_DEFAULT_CHANNEL_SUBBUF_SIZE
> +#define DEFAULT_UST_UID_CHANNEL_SUBBUF_SIZE		131072  /* bytes */
>  /* Must be a power of 2. Update help manuall if override. */
> -#define DEFAULT_UST_CHANNEL_SUBBUF_NUM      DEFAULT_CHANNEL_SUBBUF_NUM
> +#define DEFAULT_UST_PID_CHANNEL_SUBBUF_NUM		_DEFAULT_CHANNEL_SUBBUF_NUM
> +#define DEFAULT_UST_UID_CHANNEL_SUBBUF_NUM		_DEFAULT_CHANNEL_SUBBUF_NUM
>  /* See lttng-ust.h enum lttng_ust_output */
> -#define DEFAULT_UST_CHANNEL_OUTPUT          LTTNG_EVENT_MMAP
> -/* By default, unlimited tracefile size */
> -#define DEFAULT_UST_CHANNEL_TRACEFILE_SIZE  0
> -/* By default, unlimited tracefile count */
> -#define DEFAULT_UST_CHANNEL_TRACEFILE_COUNT 0
> +#define DEFAULT_UST_PID_CHANNEL_OUTPUT			_DEFAULT_CHANNEL_OUTPUT
> +#define DEFAULT_UST_UID_CHANNEL_OUTPUT			_DEFAULT_CHANNEL_OUTPUT
> +/* Timers in usec. */
> +#define DEFAULT_UST_PID_CHANNEL_SWITCH_TIMER	_DEFAULT_CHANNEL_SWITCH_TIM=
ER
> +#define DEFAULT_UST_UID_CHANNEL_SWITCH_TIMER	_DEFAULT_CHANNEL_SWITCH_TIM=
ER
>  =

> -#define DEFAULT_UST_CHANNEL_SWITCH_TIMER	\
> -		DEFAULT_CHANNEL_SWITCH_TIMER
> -#define DEFAULT_UST_CHANNEL_READ_TIMER      0  /* usec */
> +#define DEFAULT_UST_PID_CHANNEL_READ_TIMER      0  /* usec */
> +#define DEFAULT_UST_UID_CHANNEL_READ_TIMER      0  /* usec */
>  =

>  /*
>   * Default timeout value for the sem_timedwait() call. Blocking forever =
is not
> @@ -202,10 +204,10 @@
>  =

>  extern size_t default_channel_subbuf_size;
>  extern size_t default_metadata_subbuf_size;
> -extern size_t default_ust_channel_subbuf_size;
> +extern size_t default_ust_pid_channel_subbuf_size;
> +extern size_t default_ust_uid_channel_subbuf_size;
>  extern size_t default_kernel_channel_subbuf_size;
>  =

> -
>  /*
>   * Returns the default subbuf size.
>   *
> @@ -243,15 +245,27 @@ size_t default_get_kernel_channel_subbuf_size(void)
>  }
>  =

>  /*
> - * Returns the default subbuf size for the UST domain.
> + * Returns the default subbuf size for the UST domain per PID.
> + *
> + * This function depends on a value that is set at constructor time, so =
it is
> + * unsafe to call it from another constructor.
> + */
> +static inline
> +size_t default_get_ust_pid_channel_subbuf_size(void)
> +{
> +	return default_ust_pid_channel_subbuf_size;
> +}
> +
> +/*
> + * Returns the default subbuf size for the UST domain per UID.
>   *
>   * This function depends on a value that is set at constructor time, so =
it is
>   * unsafe to call it from another constructor.
>   */
>  static inline
> -size_t default_get_ust_channel_subbuf_size(void)
> +size_t default_get_ust_uid_channel_subbuf_size(void)
>  {
> -	return default_ust_channel_subbuf_size;
> +	return default_ust_uid_channel_subbuf_size;
>  }
>  =

>  #endif /* _DEFAULTS_H */
> diff --git a/src/lib/lttng-ctl/lttng-ctl.c b/src/lib/lttng-ctl/lttng-ctl.c
> index 3787e29..a7328eb 100644
> --- a/src/lib/lttng-ctl/lttng-ctl.c
> +++ b/src/lib/lttng-ctl/lttng-ctl.c
> @@ -1386,29 +1386,37 @@ void lttng_channel_set_default_attr(struct lttng_=
domain *domain,
>  =

>  	memset(attr, 0, sizeof(struct lttng_channel_attr));
>  =

> +	/* Same for all domains. */
> +	attr->overwrite =3D DEFAULT_CHANNEL_OVERWRITE;
> +	attr->tracefile_size =3D DEFAULT_CHANNEL_TRACEFILE_SIZE;
> +	attr->tracefile_count =3D DEFAULT_CHANNEL_TRACEFILE_COUNT;
> +
>  	switch (domain->type) {
>  	case LTTNG_DOMAIN_KERNEL:
> -		attr->overwrite =3D DEFAULT_CHANNEL_OVERWRITE;
>  		attr->switch_timer_interval =3D DEFAULT_KERNEL_CHANNEL_SWITCH_TIMER;
>  		attr->read_timer_interval =3D DEFAULT_KERNEL_CHANNEL_READ_TIMER;
> -
>  		attr->subbuf_size =3D default_get_kernel_channel_subbuf_size();
>  		attr->num_subbuf =3D DEFAULT_KERNEL_CHANNEL_SUBBUF_NUM;
>  		attr->output =3D DEFAULT_KERNEL_CHANNEL_OUTPUT;
> -		attr->tracefile_size =3D DEFAULT_KERNEL_CHANNEL_TRACEFILE_SIZE;
> -		attr->tracefile_count =3D DEFAULT_KERNEL_CHANNEL_TRACEFILE_COUNT;
>  		break;
>  	case LTTNG_DOMAIN_UST:
> -		attr->overwrite =3D DEFAULT_CHANNEL_OVERWRITE;
> -		attr->switch_timer_interval =3D DEFAULT_UST_CHANNEL_SWITCH_TIMER;
> -		attr->read_timer_interval =3D DEFAULT_UST_CHANNEL_READ_TIMER;
> -
> -		attr->subbuf_size =3D default_get_ust_channel_subbuf_size();
> -		attr->num_subbuf =3D DEFAULT_UST_CHANNEL_SUBBUF_NUM;
> -		attr->output =3D DEFAULT_UST_CHANNEL_OUTPUT;
> -		attr->tracefile_size =3D DEFAULT_UST_CHANNEL_TRACEFILE_SIZE;
> -		attr->tracefile_count =3D DEFAULT_UST_CHANNEL_TRACEFILE_COUNT;
> -		break;
> +		switch (domain->buf_type) {
> +		case LTTNG_BUFFER_PER_UID:
> +			attr->subbuf_size =3D default_get_ust_uid_channel_subbuf_size();
> +			attr->num_subbuf =3D DEFAULT_UST_UID_CHANNEL_SUBBUF_NUM;
> +			attr->output =3D DEFAULT_UST_UID_CHANNEL_OUTPUT;
> +			attr->switch_timer_interval =3D DEFAULT_UST_UID_CHANNEL_SWITCH_TIMER;
> +			attr->read_timer_interval =3D DEFAULT_UST_UID_CHANNEL_READ_TIMER;
> +			break;
> +		case LTTNG_BUFFER_PER_PID:
> +		default:
> +			attr->subbuf_size =3D default_get_ust_pid_channel_subbuf_size();
> +			attr->num_subbuf =3D DEFAULT_UST_PID_CHANNEL_SUBBUF_NUM;
> +			attr->output =3D DEFAULT_UST_PID_CHANNEL_OUTPUT;
> +			attr->switch_timer_interval =3D DEFAULT_UST_PID_CHANNEL_SWITCH_TIMER;
> +			attr->read_timer_interval =3D DEFAULT_UST_PID_CHANNEL_READ_TIMER;
> +			break;
> +		}
>  	default:
>  		/* Default behavior: leave set to 0. */
>  		break;
> diff --git a/tests/unit/test_ust_data.c b/tests/unit/test_ust_data.c
> index a79e2eb..c79dbf6 100644
> --- a/tests/unit/test_ust_data.c
> +++ b/tests/unit/test_ust_data.c
> @@ -111,9 +111,9 @@ static void test_create_ust_metadata(void)
>  	   metadata->attr.num_subbuf
>  			=3D=3D DEFAULT_METADATA_SUBBUF_NUM &&
>  	   metadata->attr.switch_timer_interval
> -			=3D=3D DEFAULT_UST_CHANNEL_SWITCH_TIMER &&
> +			=3D=3D DEFAULT_METADATA_SWITCH_TIMER &&
>  	   metadata->attr.read_timer_interval
> -			=3D=3D DEFAULT_UST_CHANNEL_READ_TIMER &&
> +			=3D=3D DEFAULT_METADATA_READ_TIMER &&
>  	   metadata->attr.output =3D=3D LTTNG_UST_MMAP,
>  	   "Validate UST session metadata");
>  =

> -- =

> 1.7.10.4
> =

> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
