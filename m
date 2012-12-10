From: "Gabbasov, Andrew" <Andrew_Gabbasov@mentor.com>
Subject: Re: [PATCH lttng-modules] wrapper/perf.h: Fix
	kernel	version condition
Date: Mon, 10 Dec 2012 18:14:22 +0000
Message-ID: <6C5EA58090A5ED459815C4D04C2B466F8C5686DF__15667.0548640706$1355163309$gmane$org@EU-MBX-01.mgc.mentorg.com>
References: <1355065230-4313-1-git-send-email-andrew_gabbasov@mentor.com>,
	<20121210160533.GB5557@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Andrew_Gabbasov@mentor.com>) id 1Ti7s7-0002BV-7I
	for lttng-dev@lists.lttng.org; Mon, 10 Dec 2012 13:14:31 -0500
In-Reply-To: <20121210160533.GB5557@Krystal>
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

I was looking at stable versions when setting all those versions ifdef's.
Stable 2.6.36.x has "old" parameter (pid_t), while 2.6.37.x already has "new" parameter
(struct task_struct *). That's why the checking statement with ">=" should have 2.6.37.

For example, see
http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=blob;f=include/linux/perf_event.h;h=1d42c6ecd00a3d0b885c84f36e0c38dca976eee4;hb=refs/heads/linux-2.6.36.y
line 871. This is the file in latest 2.6.36.y version, that has "old" pid_t parameter
in perf_event_create_kernel_counter() function, so this change was introduced
later than in 2.6.36.

Thanks.

Best regards,
Andrew
________________________________________
From: Mathieu Desnoyers [mathieu.desnoyers@efficios.com]
Sent: Monday, December 10, 2012 20:05
To: Gabbasov, Andrew
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] [PATCH lttng-modules] wrapper/perf.h: Fix kernel       version condition

* Andrew Gabbasov (andrew_gabbasov@mentor.com) wrote:
> The pid_t parameter of function perf_event_create_kernel_counter
> was changed to task_struct pointer starting from 2.6.37.x.

Did you check if 2.6.36.x stable kernels also introduced this change ?
This might explain why in my own testing I did put 2.6.36 as kernel
version cutoff.

Thanks,

Mathieu

>
> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> ---
>  wrapper/perf.h |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/wrapper/perf.h b/wrapper/perf.h
> index 5dfa84b..5de205c 100644
> --- a/wrapper/perf.h
> +++ b/wrapper/perf.h
> @@ -34,7 +34,7 @@ wrapper_perf_event_create_kernel_counter(struct perf_event_attr *attr,
>  }
>  #else /* defined(CONFIG_PERF_EVENTS) && (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,99)) */
>
> -#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36))
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37))
>  static inline struct perf_event *
>  wrapper_perf_event_create_kernel_counter(struct perf_event_attr *attr,
>                               int cpu,
> @@ -43,7 +43,7 @@ wrapper_perf_event_create_kernel_counter(struct perf_event_attr *attr,
>  {
>       return perf_event_create_kernel_counter(attr, cpu, task, callback);
>  }
> -#else /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)) */
> +#else /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37)) */
>  static inline struct perf_event *
>  wrapper_perf_event_create_kernel_counter(struct perf_event_attr *attr,
>                               int cpu,
> @@ -60,8 +60,11 @@ wrapper_perf_event_create_kernel_counter(struct perf_event_attr *attr,
>       return perf_event_create_kernel_counter(attr, cpu, pid, callback);
>  }
>
> +#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,37)) */
> +
> +#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,6,36))
>  #define local64_read(l)              atomic64_read(l)
> -#endif /* (LINUX_VERSION_CODE >= KERNEL_VERSION(2,6,36)) */
> +#endif
>
>  #endif /* defined(CONFIG_PERF_EVENTS) && (LINUX_VERSION_CODE >= KERNEL_VERSION(3,0,99)) */
>
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
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
