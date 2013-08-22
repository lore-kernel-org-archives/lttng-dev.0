From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] Add the CFLAGS for an "out of
	system"	building of the gen-tp example files.
Date: Thu, 22 Aug 2013 08:57:56 -0400
Message-ID: <20130822125756.GD26852__22889.8946931169$1377176317$gmane$org@Krystal>
References: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<1377160051-12449-3-git-send-email-jimmy.durand.wesolowski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1VCUSc-0006iS-6T
	for lttng-dev@lists.lttng.org; Thu, 22 Aug 2013 08:57:58 -0400
Content-Disposition: inline
In-Reply-To: <1377160051-12449-3-git-send-email-jimmy.durand.wesolowski@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jimmy Durand Wesolowski <jimmy.durand.wesolowski@gmail.com>
Cc: Jimmy Durand Wesolowski <jimmy.durand-wesolowski-ext@oneaccess-net.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Jimmy Durand Wesolowski (jimmy.durand.wesolowski@gmail.com) wrote:
> From: Jimmy Durand Wesolowski <jimmy.durand-wesolowski-ext@oneaccess-net.com>
> 
> ---
>  doc/examples/Makefile.am     |    2 +-
>  doc/examples/gen-tp/Makefile |    9 ++++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/examples/Makefile.am b/doc/examples/Makefile.am
> index 8c4901b..303a11e 100644
> --- a/doc/examples/Makefile.am
> +++ b/doc/examples/Makefile.am
> @@ -45,7 +45,7 @@ all-local:
>  		done; \
>  	fi
>  	for subdir in $(SUBDIRS_PROXY); do \
> -		cd $$subdir && $(MAKE) AM_CPPFLAGS="-I../../../include/" AM_LDFLAGS='-L../../../liblttng-ust/.libs/ -Wl,-rpath="$(PWD)/../../liblttng-ust/.libs/"' LTTNG_GEN_TP_PATH="../../../tools/" $(AM_MAKEFLAGS) all; cd ..; \
> +		cd $$subdir && $(MAKE) AM_CPPFLAGS="${CPPFLAGS} -I../../../include/" AM_LDFLAGS='${LDFLAGS} -L../../../liblttng-ust/.libs/ -Wl,-rpath="$(PWD)/../../liblttng-ust/.libs/"' LTTNG_GEN_TP_PATH="../../../tools/" $(AM_MAKEFLAGS) all; cd ..; \
>  	done
>  
>  clean-local:
> diff --git a/doc/examples/gen-tp/Makefile b/doc/examples/gen-tp/Makefile
> index e5e3cd3..c2dd05d 100644
> --- a/doc/examples/gen-tp/Makefile
> +++ b/doc/examples/gen-tp/Makefile
> @@ -1,6 +1,8 @@
>  # Copyright (C) 2011-2012  Matthew Khouzam <matthew.khouzam@ericsson.com>
>  # Copyright (C) 2012  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>  # Copyright (C) 2012  Yannick Brosseau <yannick.brosseau@gmail.com>
> +# Copyright (C) 2013  Jimmy Durand Wesolowski
> +#                       <jimmy.durand.wesolowski@gmail.com>
>  #
>  # THIS MATERIAL IS PROVIDED AS IS, WITH ABSOLUTELY NO WARRANTY EXPRESSED
>  # OR IMPLIED.  ANY USE IS AT YOUR OWN RISK.
> @@ -39,8 +41,9 @@ sample.o: sample.c sample_tracepoint.h
>  
>  # This rule generate .o only and depends on rules for generating
>  # the .h and .c
> +
>  %.o: %.tp %.c %.h
> -	$(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<
> +	CFLAGS="$(AM_CPPFLAGS)" $(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<

The intent behind the examples is that they are installed in
/usr/share/doc, and should be built both from within the source tree and
when installed in the system. This dependency on AM_CPPFLAGS does not
meet this requirement.

Also, you are mixing CPPFLAGS and CFLAGS here.

Thanks,

Mathieu

>  
>  # The following rule can be used to generate all files instead of having one
>  # for each file type. Note that the sample.o has a dependency on the
> @@ -49,10 +52,10 @@ sample.o: sample.c sample_tracepoint.h
>  #	lttng-gen-tp $<
>  
>  %.h: %.tp
> -	$(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<
> +	CFLAGS="$(AM_CPPFLAGS)" $(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<
>  
>  %.c: %.tp
> -	$(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<
> +	CFLAGS="$(AM_CPPFLAGS)" $(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<
>  
>  .PHONY: clean
>  clean:
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
