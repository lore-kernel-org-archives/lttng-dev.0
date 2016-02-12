From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-tools 1/5] Drop optionnal
	control	modules load and unload
Date: Fri, 12 Feb 2016 21:40:10 +0000 (UTC)
Message-ID: <1094072531.18569.1455313210433.JavaMail.zimbra__19912.1658377864$1455313269$gmane$org@efficios.com>
References: <1455312708-462-1-git-send-email-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1aULRs-0004ER-Ik
 for lttng-dev@lists.lttng.org; Fri, 12 Feb 2016 16:40:21 -0500
In-Reply-To: <1455312708-462-1-git-send-email-mjeanson@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org



----- On Feb 12, 2016, at 4:31 PM, Michael Jeanson mjeanson@efficios.com wrote:

> The optionnal control modules are loaded and unloaded trought modules

optionnal -> optional
trough -> through

Thanks,

Mathieu

> dependencies by modprobe or libkmod. Trying to load them manually leads
> to spurious log messages and slows down the sessiond startup.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> src/bin/lttng-sessiond/modprobe.c | 18 ------------------
> 1 file changed, 18 deletions(-)
> 
> diff --git a/src/bin/lttng-sessiond/modprobe.c
> b/src/bin/lttng-sessiond/modprobe.c
> index 2c527dc..81ce810 100644
> --- a/src/bin/lttng-sessiond/modprobe.c
> +++ b/src/bin/lttng-sessiond/modprobe.c
> @@ -33,8 +33,6 @@
> 
> /* LTTng kernel tracer mandatory core modules list */
> struct kern_modules_param kern_modules_control_core[] = {
> -	{ "lttng-tracer" },	/* MUST be loaded first so keep at top */
> -	{ "lttng-lib-ring-buffer" },
> 	{ "lttng-ring-buffer-client-discard" },
> 	{ "lttng-ring-buffer-client-overwrite" },
> 	{ "lttng-ring-buffer-metadata-client" },
> @@ -43,14 +41,6 @@ struct kern_modules_param kern_modules_control_core[] = {
> 	{ "lttng-ring-buffer-metadata-mmap-client" },
> };
> 
> -/* LTTng kernel tracer optional base modules list */
> -struct kern_modules_param kern_modules_control_opt[] = {
> -	{ "lttng-types" },
> -	{ "lttng-ftrace" },
> -	{ "lttng-kprobes" },
> -	{ "lttng-kretprobes" },
> -};
> -
> /* LTTng kernel tracer probe modules list */
> struct kern_modules_param kern_modules_probes_default[] = {
> 	{ "lttng-probe-asoc" },
> @@ -134,9 +124,6 @@ static void modprobe_remove_lttng(const struct
> kern_modules_param *modules,
>  */
> void modprobe_remove_lttng_control(void)
> {
> -	modprobe_remove_lttng(kern_modules_control_opt,
> -			      ARRAY_SIZE(kern_modules_control_opt),
> -			      LTTNG_MOD_OPTIONAL);
> 	modprobe_remove_lttng(kern_modules_control_core,
> 			      ARRAY_SIZE(kern_modules_control_core),
> 			      LTTNG_MOD_REQUIRED);
> @@ -303,11 +290,6 @@ int modprobe_lttng_control(void)
> 	ret = modprobe_lttng(kern_modules_control_core,
> 			     ARRAY_SIZE(kern_modules_control_core),
> 			     LTTNG_MOD_REQUIRED);
> -	if (ret != 0)
> -		return ret;
> -	ret = modprobe_lttng(kern_modules_control_opt,
> -			     ARRAY_SIZE(kern_modules_control_opt),
> -			     LTTNG_MOD_OPTIONAL);
> 	return ret;
> }
> 
> --
> 2.7.0
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
