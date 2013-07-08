From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH lttng-ust] Allow environment
	variable	LTTNG_HOME to override HOME
Date: Mon, 8 Jul 2013 12:12:24 -0400
Message-ID: <20130708161223.GQ29362__42158.7876779542$1373299976$gmane$org@Krystal>
References: <OFA5A3277B.87DDB05C-ONC2257B87.0041920C-C2257B87.0042359F@il.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UwE37-0006RG-Cz
	for lttng-dev@lists.lttng.org; Mon, 08 Jul 2013 12:12:25 -0400
Content-Disposition: inline
In-Reply-To: <OFA5A3277B.87DDB05C-ONC2257B87.0041920C-C2257B87.0042359F@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Amit Margalit <AMITM@il.ibm.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

I've had issues with line wrapping, please fix your email client next
time.

I merged it manually into the master branch:

commit 3c6f6263bb2d87dc863c24a4edc59c2c959270b0
Author: Amit Margalit <AMITM@il.ibm.com>
Date:   Mon Jul 8 12:10:31 2013 -0400

    Allow environment variable LTTNG_HOME to override HOME
    
    Patch functionality - If LTTNG_HOME environment variable exists, it is
    used instead of HOME.  Reason for patch - We are trying to deploy LTTng
    on a system where $HOME is on a filesystem mounted read-only, but cannot
    afford to run lttng as a different user and cannot move the home
    directories of users to writeable locations.
    
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

* Amit Margalit (AMITM@il.ibm.com) wrote:
> Hello all,
> 
> I tried to find some guide for contribution, but http://lttng.org/contrib 
> insists that page is not found, so please forgive me (and teach) where I 
> do things in a non-standard way.
> 
> Patch functionality - If LTTNG_HOME environment variable exists, it is 
> used instead of HOME.
> Reason for patch - We are trying to deploy LTTng on a system where $HOME 
> is on a filesystem mounted read-only, but cannot afford to run lttng as a 
> different user and cannot move the home directories of users to writeable 
> locations.
> Patch baseline: 2.2.0 rc2 
> 
> This patch handles only UST. The next email will be a patch against 
> lttng-tools.
> 
> diff -ur lttng-ust-2.2.0-rc2-orig/liblttng-ust/lttng-ust-comm.c 
> lttng-ust-2.2.0-rc2/liblttng-ust/lttng-ust-comm.c
> --- lttng-ust-2.2.0-rc2-orig/liblttng-ust/lttng-ust-comm.c      2013-05-08 
> 22:58:40.000000000 +0300
> +++ lttng-ust-2.2.0-rc2/liblttng-ust/lttng-ust-comm.c   2013-06-11 
> 14:12:55.921673678 +0300
> @@ -189,6 +189,20 @@
>  extern void lttng_ring_buffer_metadata_client_exit(void);
>  
>  /*
> + * Returns the HOME directory path. Caller MUST NOT free(3) the return 
> pointer.
> + */
> +static
> +char *get_lttng_home_dir(void)
> +{
> +       char *val = NULL;
> +       val = getenv("LTTNG_HOME");
> +       if (val != NULL) {
> +               return val;
> +       }
> +       return getenv("HOME");
> +}
> +
> +/*
>   * Force a read (imply TLS fixup for dlopen) of TLS variables.
>   */
>  static
> @@ -230,7 +244,7 @@
>                 assert(local_apps.allowed == 0);
>                 return 0;
>         }
> -       home_dir = (const char *) getenv("HOME");
> +       home_dir = (const char *) get_lttng_home_dir();
>         if (!home_dir) {
>                 WARN("HOME environment variable not set. Disabling 
> LTTng-UST per-user tracing.");
>                 assert(local_apps.allowed == 0);
> 
> Thanks,
> 
> Amit Margalit
> IBM XIV - Storage Reinvented
> XIV-NAS Development Team
> Tel. 03-689-7774
> Fax. 03-689-7230
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
