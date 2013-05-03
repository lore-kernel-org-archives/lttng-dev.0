From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: tracepoint provider: static versus dynamic
	linking	(TRACEPOINT_PROBE_DYNAMIC_LINKAGE)
Date: Fri, 3 May 2013 11:33:28 -0400
Message-ID: <20130503153328.GD1513__36204.1597174995$1367595242$gmane$org@Krystal>
References: <509B22FA.2030800@quantum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UYHzF-0007Je-MD
	for lttng-dev@lists.lttng.org; Fri, 03 May 2013 11:33:29 -0400
Content-Disposition: inline
In-Reply-To: <509B22FA.2030800@quantum.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Bryant <david.bryant@quantum.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi David,

Sorry for the late reply,

* David Bryant (david.bryant@quantum.com) wrote:
> Hello,
>
> What are the pros and cons of static versus dynamic linking of the  
> tracepoint provider? I can't find much information looking around.

static linking: no need to use LD_PRELOAD.

dynamic linking: can ship tracepoint provider as separate .so, packaging
separately from the instrumented application.

> Are their any licensing related issues? For example, is closed-source  
> software not allowed to use static linking?

The headers used to build the tracepoint providers are MIT-licensed, so
there is absolutely no licensing issue here with static linking of
tracepoint providers with closed-source apps. However, liblttng-ust per
se is _always_ dynamically linked.

Thanks,

Mathieu

>
> Is it just an optimisation - allowing the program to run without probes  
> connected?
>
> Thanks,
> Dave
>
>
> Notes from my digging of how it works:
>
> Looking at the preprocessor output of sample.c without/with  
> TRACEPOINT_PROBE_DYNAMIC_LINKAGE defined I see:
>
> $ diff -u sample.i.static sample.i.dynamic
> --- sample.i.static    2012-11-08 13:29:04.049059515 +1030
> +++ sample.i.dynamic    2012-11-08 13:29:04.169062438 +1030
> @@ -746,7 +746,7 @@
>  struct tracepoint __tracepoint_sample_component___message  
> __attribute__((section("__tracepoints"))) = {
>      __tp_strtab_sample_component___message,
>      0,
>      ((void *)0),
> -    &__tracepoint_provider_sample_component,
> +    ((void *)0),
>      "char *, text",
>  };
>
> (line breaks added by me).
>
> So the "int * tracepoint::tracepoint_provider_ref" member is set to  
> ((void *)0) in struct tracepoint:
>
> struct tracepoint {
>  const char *name;
>  int state;
>  struct tracepoint_probe *probes;
>  int *tracepoint_provider_ref;         /* XXX */
>  const char *signature;
>  char padding[16];
> };
>
> So the static version is not dependent on the symbol  
> "__tracepoint_provider_sample_component". Running  
> LD_PRELOAD=libprovider.so ./sample (somehow?) reinstates that symbol.  
> (Can't quite see how that works).
>
> ----------------------------------------------------------------------
> The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
