From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [BABELTRACE PATCH] Namespace the lookup_enum function
Date: Sun, 13 Jan 2013 12:57:54 -0500
Message-ID: <20130113175754.GA3917__35832.2076769129$1358099918$gmane$org@Krystal>
References: <20130107211855.GB3678@Krystal> <1357760893-11961-1-git-send-email-jdesfossez@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <gdb-return-41729-gdb-gdb=m.gmane.org@sourceware.org>
Content-Disposition: inline
In-Reply-To: <1357760893-11961-1-git-send-email-jdesfossez@efficios.com>
List-Unsubscribe: <mailto:gdb-unsubscribe-gdb-gdb=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:gdb-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/gdb/>
List-Post: <mailto:gdb@sourceware.org>
List-Help: <mailto:gdb-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: gdb-owner@sourceware.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: teawater@gmail.com, lttng-dev@lists.lttng.org, gdb@sourceware.org, tromey@redhat.com, palves@redhat.com
List-Id: lttng-dev@lists.lttng.org

* Julien Desfossez (jdesfossez@efficios.com) wrote:
> This patch namespaces the lookup_enum function because it causes problem
> with the integration in gdb even though it is not exported.
> Hui, can you try this patch and confirm it solves the current problem ?
> After that we will continue the internal namespacing.

Hi Julien,

Since we know these changes are needed, can you provide patches with
proper changelogs, and I'll pull them.

Thanks,

Mathieu

> 
> Thanks,
> 
> Julien
> ---
>  formats/ctf/ctf.c          |    2 +-
>  include/babeltrace/types.h |    2 +-
>  types/types.c              |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/formats/ctf/ctf.c b/formats/ctf/ctf.c
> index 18a5601..a8f8408 100644
> --- a/formats/ctf/ctf.c
> +++ b/formats/ctf/ctf.c
> @@ -431,7 +431,7 @@ int ctf_read_event(struct stream_pos *ppos, struct ctf_stream_definition *stream
>  		} else {
>  			struct definition_enum *enum_definition;
>  
> -			enum_definition = lookup_enum(&stream->stream_event_header->p, "id", FALSE);
> +			enum_definition = bt_lookup_enum(&stream->stream_event_header->p, "id", FALSE);
>  			if (enum_definition) {
>  				id = enum_definition->integer->value._unsigned;
>  			}
> diff --git a/include/babeltrace/types.h b/include/babeltrace/types.h
> index b42ba03..00c928b 100644
> --- a/include/babeltrace/types.h
> +++ b/include/babeltrace/types.h
> @@ -521,7 +521,7 @@ struct definition *lookup_definition(const struct definition *definition,
>  struct definition_integer *lookup_integer(const struct definition *definition,
>  					  const char *field_name,
>  					  int signedness);
> -struct definition_enum *lookup_enum(const struct definition *definition,
> +struct definition_enum *bt_lookup_enum(const struct definition *definition,
>  				    const char *field_name,
>  				    int signedness);
>  struct definition *lookup_variant(const struct definition *definition,
> diff --git a/types/types.c b/types/types.c
> index 5599027..139e318 100644
> --- a/types/types.c
> +++ b/types/types.c
> @@ -642,7 +642,7 @@ struct definition_integer *lookup_integer(const struct definition *definition,
>  	return lookup_integer;
>  }
>  
> -struct definition_enum *lookup_enum(const struct definition *definition,
> +struct definition_enum *bt_lookup_enum(const struct definition *definition,
>  				    const char *field_name,
>  				    int signedness)
>  {
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
