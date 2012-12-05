From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng-dev] Request change name of function lookup_enum in	libbabeltrace to make GDB use this lib
Date: Wed, 5 Dec 2012 07:08:45 -0500
Message-ID: <20121205120845.GA31696@Krystal>
References: <CANFwon2s-eJoCrhzJmxhoGx9G2NeOAFf-FDFk1SoxD1OhPxWsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <gdb-return-41617-gdb-gdb=m.gmane.org@sourceware.org>
Content-Disposition: inline
In-Reply-To: <CANFwon2s-eJoCrhzJmxhoGx9G2NeOAFf-FDFk1SoxD1OhPxWsg@mail.gmail.com>
List-Unsubscribe: <mailto:gdb-unsubscribe-gdb-gdb=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:gdb-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/gdb/>
List-Post: <mailto:gdb@sourceware.org>
List-Help: <mailto:gdb-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: gdb-owner@sourceware.org
To: Hui Zhu <teawater@gmail.com>, Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Tom Tromey <tromey@redhat.com>, gdb@sourceware.org
List-Id: lttng-dev@lists.lttng.org

* Hui Zhu (teawater@gmail.com) wrote:
> Hi,
> 
> I am working on add CTF support to GDB.  You can see my patch review threads in:
> http://sourceware.org/ml/gdb-patches/2012-11/msg00552.html
> http://sourceware.org/ml/gdb-patches/2012-11/msg00554.html
> http://sourceware.org/ml/gdb-patches/2012-11/msg00553.html
> http://sourceware.org/ml/gdb-patches/2012-11/msg00555.html
> http://sourceware.org/ml/gdb-patches/2012-11/msg00556.html
> 
> To make GDB support CTF read, I use libbabeltrace with GDB.  You can
> see the patch in
> http://sourceware.org/ml/gdb-patches/2012-11/msg00555.html.
> I have a issue is  libbabeltrace have a function called lookup_enum
> that is same with a GDB function.
> I change the function name of GDB to handle this issue in my patch.
> 
> But Tom said let libbabeltrace to change function name is better.
> So I send this mail to ask do you mind change the function name of
> lookup_enum?   If you can change the function name that will be really
> helpful for us.  Thanks a lot.
> And I post a patch about change the function name in libbabeltrace.

I'm CCing Julien Desfossez on this one. From what I see,
include/babeltrace/types.h is not included into the system, so it should
not be considered to be a public header of libbabeltrace.

Julien, is there an publically exposed babeltrace API that performs
something similar to the internal lookup_enum() ?

Hui, are you using other functions from include/babeltrace/types.h ?

Thanks,

Mathieu

> 
> Thanks,
> Hui
> 
> --- a/formats/ctf/ctf.c
> +++ b/formats/ctf/ctf.c
> @@ -423,7 +423,7 @@ int ctf_read_event(struct stream_pos *pp
>  		} else {
>  			struct definition_enum *enum_definition;
> 
> -			enum_definition = lookup_enum(&stream->stream_event_header->p, "id", FALSE);
> +			enum_definition = ctf_lookup_enum(&stream->stream_event_header->p,
> "id", FALSE);
>  			if (enum_definition) {
>  				id = enum_definition->integer->value._unsigned;
>  			}
> --- a/include/babeltrace/types.h
> +++ b/include/babeltrace/types.h
> @@ -513,7 +513,7 @@ struct definition *lookup_definition(con
>  struct definition_integer *lookup_integer(const struct definition *definition,
>  					  const char *field_name,
>  					  int signedness);
> -struct definition_enum *lookup_enum(const struct definition *definition,
> +struct definition_enum *ctf_lookup_enum(const struct definition *definition,
>  				    const char *field_name,
>  				    int signedness);
>  struct definition *lookup_variant(const struct definition *definition,
> --- a/types/types.c
> +++ b/types/types.c
> @@ -634,7 +634,7 @@ struct definition_integer *lookup_intege
>  	return lookup_integer;
>  }
> 
> -struct definition_enum *lookup_enum(const struct definition *definition,
> +struct definition_enum *ctf_lookup_enum(const struct definition *definition,
>  				    const char *field_name,
>  				    int signedness)
>  {
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
