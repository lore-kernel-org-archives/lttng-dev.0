From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules v2] Add new tracepoint in KVM.
Date: Thu, 10 Oct 2013 14:38:21 +0000 (UTC)
Message-ID: <2117286113.37152.1381415901023.JavaMail.zimbra__8735.72057248584$1381415963$gmane$org@efficios.com>
References: <1381283373-25699-1-git-send-email-mohamad.gebai@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VUHNi-0002Pd-Fd
	for lttng-dev@lists.lttng.org; Thu, 10 Oct 2013 10:38:32 -0400
In-Reply-To: <1381283373-25699-1-git-send-email-mohamad.gebai@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mohamad Gebai <mohamad.gebai@gmail.com>
Cc: lttng-dev@lists.lttng.org, Mohamad Gebai <mohamad.gebai@polymtl.ca>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Mohamad Gebai" <mohamad.gebai@gmail.com>
> To: lttng-dev@lists.lttng.org
> Cc: "Mohamad Gebai" <mohamad.gebai@polymtl.ca>
> Sent: Tuesday, October 8, 2013 9:49:32 PM
> Subject: [lttng-dev] [PATCH lttng-modules v2] Add new tracepoint in KVM.

For next patches, please remove the dot from the end of patch title.

Also, since your email "From" is @gmail.com, it does not match your polymtl address. I'm assuming the Author is from polymtl.

I think you could add a From field within the patch header next time to correct this.

Merged,

Thanks!

Mathieu

> 
> New tracepoint added in kvm: kvm_write_tsc_offset.
> 
> Signed-off-by: Mohamad Gebai <mohamad.gebai@polymtl.ca>
> ---
>  .../events/lttng-module/arch/x86/kvm/trace.h       |   23
>  ++++++++++++++++++++
>  .../events/mainline/arch/x86/kvm/trace.h           |   21 ++++++++++++++++++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
> b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
> index 8e71a7f..5eec169 100644
> --- a/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
> +++ b/instrumentation/events/lttng-module/arch/x86/kvm/trace.h
> @@ -761,6 +761,29 @@ TRACE_EVENT(
>  		  __entry->gpa_match ? "GPA" : "GVA")
>  )
>  
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,11,0))
> +TRACE_EVENT(kvm_write_tsc_offset,
> +	TP_PROTO(unsigned int vcpu_id, __u64 previous_tsc_offset,
> +		 __u64 next_tsc_offset),
> +	TP_ARGS(vcpu_id, previous_tsc_offset, next_tsc_offset),
> +
> +	TP_STRUCT__entry(
> +		__field( unsigned int,	vcpu_id				)
> +		__field(	__u64,	previous_tsc_offset		)
> +		__field(	__u64,	next_tsc_offset			)
> +	),
> +
> +	TP_fast_assign(
> +		tp_assign(vcpu_id, vcpu_id)
> +		tp_assign(previous_tsc_offset, previous_tsc_offset)
> +		tp_assign(next_tsc_offset, next_tsc_offset)
> +	),
> +
> +	TP_printk("vcpu=%u prev=%llu next=%llu", __entry->vcpu_id,
> +		  __entry->previous_tsc_offset, __entry->next_tsc_offset)
> +)
> +#endif
> +
>  #ifdef CONFIG_X86_64
>  
>  #define host_clocks					\
> diff --git a/instrumentation/events/mainline/arch/x86/kvm/trace.h
> b/instrumentation/events/mainline/arch/x86/kvm/trace.h
> index fe5e00e..545245d 100644
> --- a/instrumentation/events/mainline/arch/x86/kvm/trace.h
> +++ b/instrumentation/events/mainline/arch/x86/kvm/trace.h
> @@ -756,6 +756,27 @@ TRACE_EVENT(
>  		  __entry->gpa_match ? "GPA" : "GVA")
>  );
>  
> +TRACE_EVENT(kvm_write_tsc_offset,
> +	TP_PROTO(unsigned int vcpu_id, __u64 previous_tsc_offset,
> +		 __u64 next_tsc_offset),
> +	TP_ARGS(vcpu_id, previous_tsc_offset, next_tsc_offset),
> +
> +	TP_STRUCT__entry(
> +		__field( unsigned int,	vcpu_id				)
> +		__field(	__u64,	previous_tsc_offset		)
> +		__field(	__u64,	next_tsc_offset			)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->vcpu_id		= vcpu_id;
> +		__entry->previous_tsc_offset	= previous_tsc_offset;
> +		__entry->next_tsc_offset	= next_tsc_offset;
> +	),
> +
> +	TP_printk("vcpu=%u prev=%llu next=%llu", __entry->vcpu_id,
> +		  __entry->previous_tsc_offset, __entry->next_tsc_offset)
> +);
> +
>  #ifdef CONFIG_X86_64
>  
>  #define host_clocks					\
> --
> 1.7.10.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
