From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: Define lttng-tracer
 metadata only once
Date: Wed, 10 Feb 2016 16:41:03 +0000 (UTC)
Message-ID: <1621422344.16200.1455122463157.JavaMail.zimbra__40460.3067589507$1455122553$gmane$org@efficios.com>
References: <1455120494-26669-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aTXpG-0008Uk-Cs
 for lttng-dev@lists.lttng.org; Wed, 10 Feb 2016 11:41:15 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B0001340587
 for <lttng-dev@lists.lttng.org>; Wed, 10 Feb 2016 16:41:04 +0000 (UTC)
In-Reply-To: <1455120494-26669-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged into master and stable-2.7, thanks!

Mathieu

----- On Feb 10, 2016, at 11:08 AM, Michael Jeanson mjeanson@efficios.com wrote:

> Fixes sysfs trying to create the lttng-tracer module version node
> multiple times.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> Makefile                        | 8 ++++----
> lttng-context-cpu-id.c          | 8 --------
> lttng-context-hostname.c        | 8 --------
> lttng-context-interruptible.c   | 8 --------
> lttng-context-migratable.c      | 8 --------
> lttng-context-need-reschedule.c | 8 --------
> lttng-context-nice.c            | 8 --------
> lttng-context-perf-counters.c   | 8 --------
> lttng-context-pid.c             | 8 --------
> lttng-context-ppid.c            | 8 --------
> lttng-context-preemptible.c     | 8 --------
> lttng-context-prio.c            | 8 --------
> lttng-context-procname.c        | 8 --------
> lttng-context-tid.c             | 8 --------
> lttng-context-vpid.c            | 8 --------
> lttng-context-vppid.c           | 8 --------
> lttng-context-vtid.c            | 8 --------
> 17 files changed, 4 insertions(+), 132 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 5d6be94..05e4449 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -55,10 +55,6 @@ ifneq ($(KERNELRELEASE),)
>                          lttng-filter-validator.o \
>                          probes/lttng-probe-user.o
> 
> -    obj-$(CONFIG_LTTNG) += lttng-statedump.o
> -    lttng-statedump-objs := lttng-statedump-impl.o wrapper/irqdesc.o \
> -                            wrapper/fdtable.o
> -
>     ifneq ($(CONFIG_HAVE_SYSCALL_TRACEPOINTS),)
>       lttng-tracer-objs += lttng-syscalls.o
>     endif # CONFIG_HAVE_SYSCALL_TRACEPOINTS
> @@ -84,6 +80,10 @@ ifneq ($(KERNELRELEASE),)
>         -o \( $(VERSION) -eq 3 -a $(PATCHLEVEL) -ge 15 -a $(SUBLEVEL) -ge 0 \) ] ; then
>         \
>         echo "lttng-tracepoint.o" ; fi;)
> 
> +    obj-$(CONFIG_LTTNG) += lttng-statedump.o
> +    lttng-statedump-objs := lttng-statedump-impl.o wrapper/irqdesc.o \
> +                            wrapper/fdtable.o
> +
>     obj-$(CONFIG_LTTNG) += probes/
>     obj-$(CONFIG_LTTNG) += lib/
> 
> diff --git a/lttng-context-cpu-id.c b/lttng-context-cpu-id.c
> index ed2a2a9..94126af 100644
> --- a/lttng-context-cpu-id.c
> +++ b/lttng-context-cpu-id.c
> @@ -85,11 +85,3 @@ int lttng_add_cpu_id_to_ctx(struct lttng_ctx **ctx)
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(lttng_add_cpu_id_to_ctx);
> -
> -MODULE_LICENSE("GPL and additional rights");
> -MODULE_AUTHOR("Mathieu Desnoyers");
> -MODULE_DESCRIPTION("Linux Trace Toolkit CPU id Context");
> -MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> -	LTTNG_MODULES_EXTRAVERSION);
> diff --git a/lttng-context-hostname.c b/lttng-context-hostname.c
> index 7d9f081..cd414c0 100644
> --- a/lttng-context-hostname.c
> +++ b/lttng-context-hostname.c
> @@ -118,11 +118,3 @@ int lttng_add_hostname_to_ctx(struct lttng_ctx **ctx)
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(lttng_add_hostname_to_ctx);
> -
> -MODULE_LICENSE("GPL and additional rights");
> -MODULE_AUTHOR("Mathieu Desnoyers");
> -MODULE_DESCRIPTION("Linux Trace Toolkit Perf Support");
> -MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> -	LTTNG_MODULES_EXTRAVERSION);
> diff --git a/lttng-context-interruptible.c b/lttng-context-interruptible.c
> index b608a6e..295b10d 100644
> --- a/lttng-context-interruptible.c
> +++ b/lttng-context-interruptible.c
> @@ -92,11 +92,3 @@ int lttng_add_interruptible_to_ctx(struct lttng_ctx **ctx)
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(lttng_add_interruptible_to_ctx);
> -
> -MODULE_LICENSE("GPL and additional rights");
> -MODULE_AUTHOR("Mathieu Desnoyers");
> -MODULE_DESCRIPTION("Linux Trace Toolkit interruptible Context");
> -MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> -	LTTNG_MODULES_EXTRAVERSION);
> diff --git a/lttng-context-migratable.c b/lttng-context-migratable.c
> index 1aaedf6..ef0c4ed 100644
> --- a/lttng-context-migratable.c
> +++ b/lttng-context-migratable.c
> @@ -85,11 +85,3 @@ int lttng_add_migratable_to_ctx(struct lttng_ctx **ctx)
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(lttng_add_migratable_to_ctx);
> -
> -MODULE_LICENSE("GPL and additional rights");
> -MODULE_AUTHOR("Mathieu Desnoyers");
> -MODULE_DESCRIPTION("Linux Trace Toolkit migratable Context");
> -MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> -	LTTNG_MODULES_EXTRAVERSION);
> diff --git a/lttng-context-need-reschedule.c b/lttng-context-need-reschedule.c
> index 82f2d61..b0ea6d1 100644
> --- a/lttng-context-need-reschedule.c
> +++ b/lttng-context-need-reschedule.c
> @@ -85,11 +85,3 @@ int lttng_add_need_reschedule_to_ctx(struct lttng_ctx **ctx)
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(lttng_add_need_reschedule_to_ctx);
> -
> -MODULE_LICENSE("GPL and additional rights");
> -MODULE_AUTHOR("Mathieu Desnoyers");
> -MODULE_DESCRIPTION("Linux Trace Toolkit need_reschedule Context");
> -MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> -	LTTNG_MODULES_EXTRAVERSION);
> diff --git a/lttng-context-nice.c b/lttng-context-nice.c
> index b2d7705..2ad3841 100644
> --- a/lttng-context-nice.c
> +++ b/lttng-context-nice.c
> @@ -85,11 +85,3 @@ int lttng_add_nice_to_ctx(struct lttng_ctx **ctx)
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(lttng_add_nice_to_ctx);
> -
> -MODULE_LICENSE("GPL and additional rights");
> -MODULE_AUTHOR("Mathieu Desnoyers");
> -MODULE_DESCRIPTION("Linux Trace Toolkit Nice Context");
> -MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> -	LTTNG_MODULES_EXTRAVERSION);
> diff --git a/lttng-context-perf-counters.c b/lttng-context-perf-counters.c
> index 0c74234..467b718 100644
> --- a/lttng-context-perf-counters.c
> +++ b/lttng-context-perf-counters.c
> @@ -280,11 +280,3 @@ error_attr:
> 	kfree(events);
> 	return ret;
> }
> -
> -MODULE_LICENSE("GPL and additional rights");
> -MODULE_AUTHOR("Mathieu Desnoyers");
> -MODULE_DESCRIPTION("Linux Trace Toolkit Perf Support");
> -MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> -	LTTNG_MODULES_EXTRAVERSION);
> diff --git a/lttng-context-pid.c b/lttng-context-pid.c
> index 5ad92c1..3428be6 100644
> --- a/lttng-context-pid.c
> +++ b/lttng-context-pid.c
> @@ -85,11 +85,3 @@ int lttng_add_pid_to_ctx(struct lttng_ctx **ctx)
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(lttng_add_pid_to_ctx);
> -
> -MODULE_LICENSE("GPL and additional rights");
> -MODULE_AUTHOR("Mathieu Desnoyers");
> -MODULE_DESCRIPTION("Linux Trace Toolkit PID Context");
> -MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> -	LTTNG_MODULES_EXTRAVERSION);
> diff --git a/lttng-context-ppid.c b/lttng-context-ppid.c
> index 28c97b5..7323b88 100644
> --- a/lttng-context-ppid.c
> +++ b/lttng-context-ppid.c
> @@ -107,11 +107,3 @@ int lttng_add_ppid_to_ctx(struct lttng_ctx **ctx)
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(lttng_add_ppid_to_ctx);
> -
> -MODULE_LICENSE("GPL and additional rights");
> -MODULE_AUTHOR("Mathieu Desnoyers");
> -MODULE_DESCRIPTION("Linux Trace Toolkit PPID Context");
> -MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> -	LTTNG_MODULES_EXTRAVERSION);
> diff --git a/lttng-context-preemptible.c b/lttng-context-preemptible.c
> index d4d474c..7053414 100644
> --- a/lttng-context-preemptible.c
> +++ b/lttng-context-preemptible.c
> @@ -103,11 +103,3 @@ int lttng_add_preemptible_to_ctx(struct lttng_ctx **ctx)
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(lttng_add_preemptible_to_ctx);
> -
> -MODULE_LICENSE("GPL and additional rights");
> -MODULE_AUTHOR("Mathieu Desnoyers");
> -MODULE_DESCRIPTION("Linux Trace Toolkit preemptible Context");
> -MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> -	LTTNG_MODULES_EXTRAVERSION);
> diff --git a/lttng-context-prio.c b/lttng-context-prio.c
> index 9da51a2..5a27e04 100644
> --- a/lttng-context-prio.c
> +++ b/lttng-context-prio.c
> @@ -106,11 +106,3 @@ int lttng_add_prio_to_ctx(struct lttng_ctx **ctx)
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(lttng_add_prio_to_ctx);
> -
> -MODULE_LICENSE("GPL and additional rights");
> -MODULE_AUTHOR("Mathieu Desnoyers");
> -MODULE_DESCRIPTION("Linux Trace Toolkit Priority Context");
> -MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> -	LTTNG_MODULES_EXTRAVERSION);
> diff --git a/lttng-context-procname.c b/lttng-context-procname.c
> index 8a747ac..6b5e90a 100644
> --- a/lttng-context-procname.c
> +++ b/lttng-context-procname.c
> @@ -89,11 +89,3 @@ int lttng_add_procname_to_ctx(struct lttng_ctx **ctx)
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(lttng_add_procname_to_ctx);
> -
> -MODULE_LICENSE("GPL and additional rights");
> -MODULE_AUTHOR("Mathieu Desnoyers");
> -MODULE_DESCRIPTION("Linux Trace Toolkit Perf Support");
> -MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> -	LTTNG_MODULES_EXTRAVERSION);
> diff --git a/lttng-context-tid.c b/lttng-context-tid.c
> index 1286265..3eded5b 100644
> --- a/lttng-context-tid.c
> +++ b/lttng-context-tid.c
> @@ -88,11 +88,3 @@ int lttng_add_tid_to_ctx(struct lttng_ctx **ctx)
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(lttng_add_tid_to_ctx);
> -
> -MODULE_LICENSE("GPL and additional rights");
> -MODULE_AUTHOR("Mathieu Desnoyers");
> -MODULE_DESCRIPTION("Linux Trace Toolkit TID Context");
> -MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> -	LTTNG_MODULES_EXTRAVERSION);
> diff --git a/lttng-context-vpid.c b/lttng-context-vpid.c
> index 6fa1c00..a2080f1 100644
> --- a/lttng-context-vpid.c
> +++ b/lttng-context-vpid.c
> @@ -100,11 +100,3 @@ int lttng_add_vpid_to_ctx(struct lttng_ctx **ctx)
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(lttng_add_vpid_to_ctx);
> -
> -MODULE_LICENSE("GPL and additional rights");
> -MODULE_AUTHOR("Mathieu Desnoyers");
> -MODULE_DESCRIPTION("Linux Trace Toolkit vPID Context");
> -MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> -	LTTNG_MODULES_EXTRAVERSION);
> diff --git a/lttng-context-vppid.c b/lttng-context-vppid.c
> index 8a7d172..9e7e54d 100644
> --- a/lttng-context-vppid.c
> +++ b/lttng-context-vppid.c
> @@ -129,11 +129,3 @@ int lttng_add_vppid_to_ctx(struct lttng_ctx **ctx)
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(lttng_add_vppid_to_ctx);
> -
> -MODULE_LICENSE("GPL and additional rights");
> -MODULE_AUTHOR("Mathieu Desnoyers");
> -MODULE_DESCRIPTION("Linux Trace Toolkit vPPID Context");
> -MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> -	LTTNG_MODULES_EXTRAVERSION);
> diff --git a/lttng-context-vtid.c b/lttng-context-vtid.c
> index a37bb76..425f368 100644
> --- a/lttng-context-vtid.c
> +++ b/lttng-context-vtid.c
> @@ -100,11 +100,3 @@ int lttng_add_vtid_to_ctx(struct lttng_ctx **ctx)
> 	return 0;
> }
> EXPORT_SYMBOL_GPL(lttng_add_vtid_to_ctx);
> -
> -MODULE_LICENSE("GPL and additional rights");
> -MODULE_AUTHOR("Mathieu Desnoyers");
> -MODULE_DESCRIPTION("Linux Trace Toolkit vTID Context");
> -MODULE_VERSION(__stringify(LTTNG_MODULES_MAJOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_MINOR_VERSION) "."
> -	__stringify(LTTNG_MODULES_PATCHLEVEL_VERSION)
> -	LTTNG_MODULES_EXTRAVERSION);
> --
> 2.7.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
