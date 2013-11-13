From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/2] Base-address tracing for dlopen and
	dlclose
Date: Wed, 13 Nov 2013 13:51:30 +0000 (UTC)
Message-ID: <2094822839.66252.1384350690210.JavaMail.zimbra__40515.8470072367$1384351757$gmane$org@efficios.com>
References: <1384183688-19038-1-git-send-email-paul_woegerer@mentor.com>
	<1384183688-19038-2-git-send-email-paul_woegerer@mentor.com>
	<318817448.66208.1384349143345.JavaMail.zimbra@efficios.com>
	<528382D0.3030202@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1Vgar2-0000Bg-PB
	for lttng-dev@lists.lttng.org; Wed, 13 Nov 2013 08:51:42 -0500
In-Reply-To: <528382D0.3030202@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Woegerer <Paul_Woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org



----- Original Message -----
> From: "Paul Woegerer" <Paul_Woegerer@mentor.com>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Sent: Wednesday, November 13, 2013 8:46:56 AM
> Subject: Re: [PATCH 1/2] Base-address tracing for dlopen and dlclose
> 
> Hi Mathieu,
> 
> Thanks for the review.
> Comments see below:
> 
> On 11/13/2013 02:25 PM, Mathieu Desnoyers wrote:
> > ----- Original Message -----
> >> Provide an LD_PRELOAD library to allow tracing of calls to dlopen and
> >> dlclose.  Tracing the lttng-ust internal use of dlopen and dlclose is
> >> prevented.
> > Why do we need to prevent tracing lttng-ust internal use of dlopen/dlclose
> > ?
> 
> I assumed this would be beneficial to have (less noise in  the trace
> data). But if you don't like that we can also leave it out. You will see
> lots of
> 
> ust_baddr:push: { cpu_id = X }, { baddr = 0xXXXXXXXX, sopath =
> "/.../liblttng-ust-tracepoint.so.0.0.0", size = A, mtime = B }
> 
> events in the trace though (I attached a sample to demonstrate this).

I try not to hide anything from the users. If the viewer cares about this, they can always filter out when they read the traces.

Moreover, I'd really like not to modify tracepoint.h if possible for instrumentation ABI compatibility reasons.

> 
> >> +void *dlopen(const char *filename, int flag)
> >> +{
> >> +	void *handle = _lttng_ust_dl_libc_dlopen(filename, flag);
> >> +	if (handle) {
> >> +		struct link_map *p = NULL;
> >> +		if (dlinfo(handle, RTLD_DI_LINKMAP, &p) != -1 && p != NULL
> >> +			&& p->l_addr != 0)
> > Maybe add one extra tab above for readability.
> 
> No problem. I can do that.
> 
> Do you want me to resend the patch without lttng_ust_dlopen/close handling ?

Yes, please,

Thanks!

Mathieu

> 
> --
> Paul
> 
> > Same here.
> >
> > Thanks,
> >
> > Mathieu
> >
> >> +			lttng_ust_baddr_pop((void *) p->l_addr);
> >> +	}
> >> +	return _lttng_ust_dl_libc_dlclose(handle);
> >> +}
> >> +
> >> +static void __attribute__((destructor))
> >> +lttng_ust_baddr_handle_fini(void);
> >> +static void
> >> +lttng_ust_baddr_handle_fini(void)
> >> +{
> >> +	if (__lttng_ust_baddr_handle) {
> >> +		int ret = _lttng_ust_dl_libc_dlclose(__lttng_ust_baddr_handle);
> >> +		if (ret)
> >> +			fprintf(stderr, "%s\n", dlerror());
> >> +	}
> >> +}
> >> --
> >> 1.8.4.2
> >>
> >>
> 
> 
> --
> Paul Woegerer, SW Development Engineer
> Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
> Mentor Graphics, Embedded Software Division
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
