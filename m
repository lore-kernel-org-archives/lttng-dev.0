From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [lttng dev] [PATCH lttng-ust 2/2]
	Refactor	ust_baddr_statedump functions to reduce duplicated code
Date: Wed, 20 May 2015 16:40:02 +0000 (UTC)
Message-ID: <125572990.4703.1432140002527.JavaMail.zimbra__44325.8922816769$1432140152$gmane$org@efficios.com>
References: <1432073856-458-1-git-send-email-abusque@efficios.com>
 <1432073856-458-2-git-send-email-abusque@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Yv72G-0000Ea-RT
 for lttng-dev@lists.lttng.org; Wed, 20 May 2015 12:40:09 -0400
In-Reply-To: <1432073856-458-2-git-send-email-abusque@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Antoine Busque <abusque@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> This refactoring allows the reuse of code that handles the iteration
> over the sessions, used for all ust_baddr_statedump events.
> 
> Signed-off-by: Antoine Busque <abusque@efficios.com>
> ---
>  liblttng-ust/lttng-ust-baddr.c | 133
>  ++++++++++++++++++++++-------------------
>  1 file changed, 71 insertions(+), 62 deletions(-)
> 
> diff --git a/liblttng-ust/lttng-ust-baddr.c b/liblttng-ust/lttng-ust-baddr.c
> index 5ec3d40..26f234f 100644
> --- a/liblttng-ust/lttng-ust-baddr.c
> +++ b/liblttng-ust/lttng-ust-baddr.c
> @@ -44,24 +44,27 @@ struct extract_data {
>  	void *exec_baddr;	/* executable base address */
>  };
>  
> +struct soinfo_data {
> +	void *base_addr_ptr;
> +	const char *resolved_path;
> +	int vdso;
> +	off_t size;
> +	time_t mtime;
> +};
> +
> +typedef void (*tracepoint_cb)(struct lttng_session *session,
> +			      void *extra_tp_args);

Can we rename "extra_tp_args" to "priv" across this file ?

> +
>  /*
> - * Trace baddr into all sessions for which statedump is pending owned by
> - * the caller thread.
> + * Trace statedump event into all sessions for which statedump is
> + * pending owned by the caller thread.

...pending and owned...

>   */
>  static
> -int trace_baddr(void *base_addr_ptr,
> -	const char *resolved_path,
> -	int vdso,
> -	void *owner)
> +int trace_statedump_event(tracepoint_cb tp_cb, void *owner, void
> *extra_tp_args)
>  {
>  	struct cds_list_head *sessionsp;
>  	struct lttng_session *session;
> -	struct stat sostat;
>  
> -	if (vdso || stat(resolved_path, &sostat)) {
> -		sostat.st_size = 0;
> -		sostat.st_mtime = -1;
> -	}
>  	/*
>  	 * UST lock nests within dynamic loader lock.
>  	 */
> @@ -79,61 +82,63 @@ int trace_baddr(void *base_addr_ptr,
>  			continue;
>  		if (!session->statedump_pending)
>  			continue;
> -		tracepoint(ust_baddr_statedump, soinfo,
> -				session, base_addr_ptr,
> -				resolved_path, sostat.st_size,
> -				sostat.st_mtime);
> +		tp_cb(session, extra_tp_args);
>  	}
>  	ust_unlock();
>  	return 0;
>  }
>  
>  static
> -int trace_statedump_start(void *owner)
> +void trace_soinfo_cb(struct lttng_session *session, void *extra_tp_args)
>  {
> -	struct cds_list_head *sessionsp;
> -	struct lttng_session *session;
> +	struct soinfo_data *so_data = (struct soinfo_data *)extra_tp_args;

missing space after ")"

>  
> -	if (ust_lock()) {
> -		ust_unlock();
> -		return 1;
> -	}
> +	tracepoint(ust_baddr_statedump, soinfo,
> +		   session, so_data->base_addr_ptr,
> +		   so_data->resolved_path, so_data->size,
> +		   so_data->mtime);
> +}
>  
> -	sessionsp = _lttng_get_sessions();
> -	cds_list_for_each_entry(session, sessionsp, node) {
> -		if (session->owner != owner)
> -			continue;
> -		if (!session->statedump_pending)
> -			continue;
> -		tracepoint(ust_baddr_statedump, start,
> -				session);
> -	}
> -	ust_unlock();
> -	return 0;
> +static
> +void trace_start_cb(struct lttng_session *session, void *extra_tp_args)
> +{
> +	tracepoint(ust_baddr_statedump, start,
> +		   session);

This should fit on a single line.

>  }
>  
>  static
> -int trace_statedump_end(void *owner)
> +void trace_end_cb(struct lttng_session *session, void *extra_tp_args)
>  {
> -	struct cds_list_head *sessionsp;
> -	struct lttng_session *session;
> +	tracepoint(ust_baddr_statedump, end,
> +		   session);

This should fit on a single line.

> +}
>  
> -	if (ust_lock()) {
> -		ust_unlock();
> -		return 1;
> -	}
> +static
> +int trace_baddr(void *owner, struct soinfo_data *so_data)
> +{
> +	struct stat sostat;
>  
> -	sessionsp = _lttng_get_sessions();
> -	cds_list_for_each_entry(session, sessionsp, node) {
> -		if (session->owner != owner)
> -			continue;
> -		if (!session->statedump_pending)
> -			continue;
> -		tracepoint(ust_baddr_statedump, end,
> -				session);
> +	if (so_data->vdso || stat(so_data->resolved_path, &sostat)) {
> +		sostat.st_size = 0;
> +		sostat.st_mtime = -1;
>  	}
> -	ust_unlock();
> -	return 0;
> +
> +	so_data->size = sostat.st_size;
> +	so_data->mtime = sostat.st_mtime;
> +
> +	return trace_statedump_event(trace_soinfo_cb, owner, so_data);
> +}
> +
> +static
> +int trace_statedump_start(void *owner)
> +{
> +	return trace_statedump_event(trace_start_cb, owner, NULL);
> +}
> +
> +static
> +int trace_statedump_end(void *owner)
> +{
> +	return trace_statedump_event(trace_end_cb, owner, NULL);
>  }
>  
>  static
> @@ -141,18 +146,18 @@ int extract_soinfo_events(struct dl_phdr_info *info,
> size_t size, void *_data)
>  {
>  	int j;
>  	struct extract_data *data = _data;
> +	struct soinfo_data so_data;
>  	void *owner = data->owner;
>  
>  	for (j = 0; j < info->dlpi_phnum; j++) {
>  		char resolved_path[PATH_MAX];
> -		void *base_addr_ptr;

Please declare so_data in the innermost scope (here). It's not used
outside, right ?

Thanks,

Mathieu

> -		int vdso = 0;
> +		so_data.vdso = 0;
>  
>  		if (info->dlpi_phdr[j].p_type != PT_LOAD)
>  			continue;
>  
>  		/* Calculate virtual memory address of the loadable segment */
> -		base_addr_ptr = (void *) info->dlpi_addr
> +		so_data.base_addr_ptr = (void *) info->dlpi_addr
>  			+ info->dlpi_phdr[j].p_vaddr;
>  
>  		if ((info->dlpi_name == NULL || info->dlpi_name[0] == 0)
> @@ -163,7 +168,7 @@ int extract_soinfo_events(struct dl_phdr_info *info,
> size_t size, void *_data)
>  			 * could be e.g. vdso. Don't mistakenly dump
>  			 * them as being the program executable.
>  			 */
> -			data->exec_baddr = base_addr_ptr;
> +			data->exec_baddr = so_data.base_addr_ptr;
>  			/*
>  			 * Deal with program executable outside of phdr
>  			 * iteration.
> @@ -173,7 +178,7 @@ int extract_soinfo_events(struct dl_phdr_info *info,
> size_t size, void *_data)
>  		if (info->dlpi_name == NULL || info->dlpi_name[0] == 0) {
>  			/* Found vDSO. */
>  			snprintf(resolved_path, PATH_MAX - 1, "[vdso]");
> -			vdso = 1;
> +			so_data.vdso = 1;
>  		} else {
>  			/*
>  			 * For regular dl_phdr_info entries we have to check if
> @@ -183,10 +188,13 @@ int extract_soinfo_events(struct dl_phdr_info *info,
> size_t size, void *_data)
>  				/* Path unknown, put the 'path' into brackets */
>  				snprintf(resolved_path, PATH_MAX - 1, "[%s]",
>  					info->dlpi_name);
> -				vdso = 1;
> +				so_data.vdso = 1;
>  			}
>  		}
> -		if (trace_baddr(base_addr_ptr, resolved_path, vdso, owner)) {
> +
> +		so_data.resolved_path = resolved_path;
> +
> +		if (trace_baddr(owner, &so_data)) {
>  			return 1;
>  		}
>  		/*
> @@ -201,13 +209,13 @@ int extract_soinfo_events(struct dl_phdr_info *info,
> size_t size, void *_data)
>  static
>  void dump_exec_baddr(struct extract_data *data)
>  {
> -	void *owner = data->owner;
> -	void *base_addr_ptr;
> +	struct soinfo_data so_data;
>  	char exe_path[PATH_MAX];
>  	ssize_t exe_len;
>  
> -	base_addr_ptr = data->exec_baddr;
> -	if (!base_addr_ptr)
> +	so_data.vdso = 0;
> +	so_data.base_addr_ptr = data->exec_baddr;
> +	if (!so_data.base_addr_ptr)
>  		return;
>  	/*
>  	 * We have to use /proc/self/exe to determine the executable full
> @@ -217,7 +225,8 @@ void dump_exec_baddr(struct extract_data *data)
>  	if (exe_len <= 0)
>  		return;
>  	exe_path[exe_len] = '\0';
> -	trace_baddr(base_addr_ptr, exe_path, 0, owner);
> +	so_data.resolved_path = exe_path;
> +	trace_baddr(data->owner, &so_data);
>  }
>  
>  int lttng_ust_baddr_statedump(void *owner)
> --
> 2.4.1
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
