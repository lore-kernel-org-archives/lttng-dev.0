From: David OShea <David.OShea@quantum.com>
Subject: Re: TRACEPOINT_PROVIDER mismatch check
	in	ust-tracepoint-event.h needs -Wsystem-headers
Date: Mon, 26 Nov 2012 08:57:09 +0000
Message-ID: <20998D40D9A2B7499CA5A3A2666CB1EB19F87B5C__49830.3583277904$1353920281$gmane$org@ZURMSG1.QUANTUM.com>
References: <20998D40D9A2B7499CA5A3A2666CB1EB19F87106@ZURMSG1.QUANTUM.com>
	<20121119162618.GA17428@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mx0b-000ceb01.pphosted.com ([67.231.152.126])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <prvs=76770532f8=david.oshea@quantum.com>)
	id 1TcuV9-0002ae-HD
	for lttng-dev@lists.lttng.org; Mon, 26 Nov 2012 03:57:15 -0500
In-Reply-To: <20121119162618.GA17428@Krystal>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Mathieu,

Thanks for the response and apologies for the delay in mine, please see below:

> -----Original Message-----
> From: Mathieu Desnoyers [mailto:mathieu.desnoyers@efficios.com]
> Sent: Tuesday, 20 November 2012 2:56 AM
> To: David OShea
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] TRACEPOINT_PROVIDER mismatch check in ust-
> tracepoint-event.h needs -Wsystem-headers
[...]
> > I'm not sure if there is any way you could "fix" this so that
> > -Wsystem-headers isn't required, but perhaps it would at least be
> > worth documenting that this flag could be used - but perhaps not
> > recommend it - to enable those checks to occur.
> 
> I have not found any way to show those warnings from UST system headers
> without -Wsystem-headers. We have the following scenario:
> 
> probe C file
>   -> includes ust probe description file
>      -> includes tracepoint-event.h (system header)
>         -> includes ust probe description file
>         -> includes ust-tracepoint-event.h (system header) [1]
>            For each stage:
>              -> undef/define macros
>              -> includes ust probe description file
> 
> Since the actual functions are created by the compiler in the scope of
> ust-tracepoint-event.h [1] (a system header), the warnings are
> inhibited
> unless we specify -Wsystem-headers.
[...]
> So I guess documenting this would be the right way to do it, unless
> anyone has a better idea ?

I don't know much about the macros in ust-tracepoint-event.h, so this might not make any sense, but could you have the __tracepoint_provider_check_##TRACEPOINT_PROVIDER() function actually get called from the __lttng_events_init__##TRACEPOINT_PROVIDER() (constructor) function?  I assume this would mean you'd get link-time errors if you have a provider name mismatch.  It would also mean a lot of useless calls to empty functions at startup, but I assume that really shouldn't take too long.  Perhaps this checking could be a compile-time option, so that if you're concerned about the startup time impact you can disable it, or perhaps the functions could be marked as inline?

Thanks,
David

----------------------------------------------------------------------
The information contained in this transmission may be confidential. Any disclosure, copying, or further distribution of confidential information is not permitted unless such privilege is explicitly granted in writing by Quantum. Quantum reserves the right to have electronic communications, including email and attachments, sent across its networks filtered through anti virus and spam software programs and retain such messages in order to comply with applicable data security and retention requirements. Quantum is not responsible for the proper and complete transmission of the substance of this communication or for any delay in its receipt.
