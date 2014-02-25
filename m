From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: Dump executable base-address
 with readlink
Date: Tue, 25 Feb 2014 10:18:04 +0000 (UTC)
Message-ID: <1929911414.29781.1393323484733.JavaMail.zimbra__14425.5689614967$1393323531$gmane$org@efficios.com>
References: <1393321620-14770-1-git-send-email-paul_woegerer@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WIF5U-0006Z1-Bu
	for lttng-dev@lists.lttng.org; Tue, 25 Feb 2014 05:18:09 -0500
In-Reply-To: <1393321620-14770-1-git-send-email-paul_woegerer@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Woegerer <paul_woegerer@mentor.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

merged with small style updates.

Thanks!

Mathieu

----- Original Message -----
> From: "Paul Woegerer" <paul_woegerer@mentor.com>
> To: lttng-dev@lists.lttng.org, "mathieu desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Tuesday, February 25, 2014 4:47:00 AM
> Subject: [PATCH lttng-ust] Fix: Dump executable base-address with readlink
> 
> The previous approach only worked if the traced executable was invoked
> via its fully qualified path. Using readlink to determine the full
> qualified path of the traced executable works reliably even when the
> traced executable is started via PATH lookup.
> 
> Signed-off-by: Paul Woegerer <paul_woegerer@mentor.com>
> ---
>  liblttng-ust/lttng-ust-baddr.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/liblttng-ust/lttng-ust-baddr.c b/liblttng-ust/lttng-ust-baddr.c
> index 42ae630..3ae4e03 100644
> --- a/liblttng-ust/lttng-ust-baddr.c
> +++ b/liblttng-ust/lttng-ust-baddr.c
> @@ -154,21 +154,21 @@ static
>  void dump_exec_baddr(struct extract_data *data)
>  {
>  	void *owner = data->owner;
> -	Dl_info dl_info = { 0 };
>  	void *base_addr_ptr;
> -	char resolved_path[PATH_MAX];
> +	char exe_path[PATH_MAX];
> +	ssize_t exe_len;
>  
>  	base_addr_ptr = data->exec_baddr;
>  	if (!base_addr_ptr)
>  		return;
>  	/*
> -	 * We have to use Dl_info to determine the executable full path.
> +	 * We have to use /proc/self/exe to determine the executable full path.
>  	 */
> -	if (!dladdr(base_addr_ptr, &dl_info))
> +	exe_len = readlink("/proc/self/exe", exe_path, sizeof(exe_path)-1);
> +	if (exe_len <= 0)
>  		return;
> -	if (!realpath(dl_info.dli_fname, resolved_path))
> -		return;
> -	trace_baddr(base_addr_ptr, resolved_path, 0, owner);
> +	exe_path[exe_len] = '\0';
> +	trace_baddr(base_addr_ptr, exe_path, 0, owner);
>  }
>  
>  int lttng_ust_baddr_statedump(void *owner)
> --
> 1.8.5.2
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
