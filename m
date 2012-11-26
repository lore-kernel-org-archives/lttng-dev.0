From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: TRACEPOINT_PROVIDER mismatch check
	in	ust-tracepoint-event.h needs -Wsystem-headers
Date: Mon, 26 Nov 2012 15:28:36 -0500
Message-ID: <20121126202836.GA30838__27724.6310645298$1353961754$gmane$org@Krystal>
References: <20998D40D9A2B7499CA5A3A2666CB1EB19F87106@ZURMSG1.QUANTUM.com>
	<20121119162618.GA17428@Krystal>
	<20998D40D9A2B7499CA5A3A2666CB1EB19F87B5C@ZURMSG1.QUANTUM.com>
	<20121126201659.GB30509@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Td5IE-00081x-GA
	for lttng-dev@lists.lttng.org; Mon, 26 Nov 2012 15:28:38 -0500
Content-Disposition: inline
In-Reply-To: <20121126201659.GB30509@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David OShea <David.OShea@quantum.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * David OShea (David.OShea@quantum.com) wrote:
> > Hi Mathieu,
> > 
> > Thanks for the response and apologies for the delay in mine, please see below:
> > 
> > > -----Original Message-----
> > > From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]
> > > Sent: Tuesday, 20 November 2012 2:56 AM
> > > To: David OShea
> > > Cc: lttng-dev@lists.lttng.org
> > > Subject: Re: [lttng-dev] TRACEPOINT_PROVIDER mismatch check in ust-
> > > tracepoint-event.h needs -Wsystem-headers
> > [...]
> > > > I'm not sure if there is any way you could "fix" this so that
> > > > -Wsystem-headers isn't required, but perhaps it would at least be
> > > > worth documenting that this flag could be used - but perhaps not
> > > > recommend it - to enable those checks to occur.
> > > 
> > > I have not found any way to show those warnings from UST system headers
> > > without -Wsystem-headers. We have the following scenario:
> > > 
> > > probe C file
> > >   -> includes ust probe description file
> > >      -> includes tracepoint-event.h (system header)
> > >         -> includes ust probe description file
> > >         -> includes ust-tracepoint-event.h (system header) [1]
> > >            For each stage:
> > >              -> undef/define macros
> > >              -> includes ust probe description file
> > > 
> > > Since the actual functions are created by the compiler in the scope of
> > > ust-tracepoint-event.h [1] (a system header), the warnings are
> > > inhibited
> > > unless we specify -Wsystem-headers.
> > [...]
> > > So I guess documenting this would be the right way to do it, unless
> > > anyone has a better idea ?
> > 
> > I don't know much about the macros in ust-tracepoint-event.h, so this
> > might not make any sense, but could you have the
> > __tracepoint_provider_check_##TRACEPOINT_PROVIDER() function actually
> > get called from the __lttng_events_init__##TRACEPOINT_PROVIDER()
> > (constructor) function?  I assume this would mean you'd get link-time
> > errors if you have a provider name mismatch.  It would also mean a lot
> > of useless calls to empty functions at startup, but I assume that
> > really shouldn't take too long.  Perhaps this checking could be a
> > compile-time option, so that if you're concerned about the startup
> > time impact you can disable it, or perhaps the functions could be
> > marked as inline?
> 
> That makes sense!
> 
> Can you try the following patch and let me know if it fixes your
> problem?

hrm, actually, even without the patch, I get:

sample.o:(__tracepoints+0x18): undefined reference to `__tracepoint_provider_sadfasdmple_component'

if I try to compile a tracepoint with an incorrect provider name. So the
patch would not be needed. I'm using gcc 4.7.2 (Debian 4.7.2-4).

Maybe the fact that you don't get any linker error is because of
specific behavior wrt unused attribute of your gcc 4.3.3 ?

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
> commit f26441658685b281756ccbc8f74d70b9f2e6dad5
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Mon Nov 26 15:14:24 2012 -0500
> 
>     Print probe provider mismatch error even without -Wsystem-headers
>     
>     Suggested-by: David OShea <David.OShea@quantum.com>
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> diff --git a/include/lttng/ust-tracepoint-event.h b/include/lttng/ust-tracepoint-event.h
> index 8f804d6..c341e04 100644
> --- a/include/lttng/ust-tracepoint-event.h
> +++ b/include/lttng/ust-tracepoint-event.h
> @@ -72,7 +72,7 @@ void _TP_COMBINE_TOKENS(__tracepoint_provider_mismatch_, TRACEPOINT_PROVIDER)(vo
>  #define TRACEPOINT_EVENT_INSTANCE(_provider, _template, _name, _args)	\
>  	__tracepoint_provider_mismatch_##_provider();
>  
> -static __attribute__((unused))
> +static inline
>  void _TP_COMBINE_TOKENS(__tracepoint_provider_check_, TRACEPOINT_PROVIDER)(void)
>  {
>  #include TRACEPOINT_INCLUDE
> @@ -655,6 +655,15 @@ _TP_COMBINE_TOKENS(__lttng_events_init__, TRACEPOINT_PROVIDER)(void)
>  {
>  	int ret;
>  
> +	/*
> +	 * __tracepoint_provider_check_ ## TRACEPOINT_PROVIDER() is a
> +	 * static inline function that ensures every probe PROVIDER
> +	 * argument match the provider within which they appear. It
> +	 * calls empty static inline functions, and therefore has no
> +	 * runtime effect. However, if it detects an error, a linker
> +	 * error will appear.
> +	 */
> +	_TP_COMBINE_TOKENS(__tracepoint_provider_check_, TRACEPOINT_PROVIDER)();
>  	ret = lttng_probe_register(&_TP_COMBINE_TOKENS(__probe_desc___, TRACEPOINT_PROVIDER));
>  	assert(!ret);
>  }
> -- 
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
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
