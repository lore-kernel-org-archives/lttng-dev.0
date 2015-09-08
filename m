From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: double free in
	liblttng-ust-dl
Date: Tue, 8 Sep 2015 22:29:17 +0000 (UTC)
Message-ID: <992343929.444.1441751357760.JavaMail.zimbra__25199.8505475514$1441751421$gmane$org@efficios.com>
References: <1441747456-20698-1-git-send-email-abusque@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZZRON-000196-0b
 for lttng-dev@lists.lttng.org; Tue, 08 Sep 2015 18:29:32 -0400
In-Reply-To: <1441747456-20698-1-git-send-email-abusque@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Antoine Busque <abusque@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged into master, thanks!

Mathieu

----- On Sep 8, 2015, at 5:24 PM, Antoine Busque abusque@efficios.com wrote:

> Signed-off-by: Antoine Busque <abusque@efficios.com>
> ---
> liblttng-ust-dl/lttng-ust-dl.c | 2 --
> 1 file changed, 2 deletions(-)
> 
> diff --git a/liblttng-ust-dl/lttng-ust-dl.c b/liblttng-ust-dl/lttng-ust-dl.c
> index d6abeff..954d9df 100644
> --- a/liblttng-ust-dl/lttng-ust-dl.c
> +++ b/liblttng-ust-dl/lttng-ust-dl.c
> @@ -109,13 +109,11 @@ void lttng_ust_dl_dlopen(void *so_base, const char
> *so_name, void *ip)
> 	if (has_build_id) {
> 		tracepoint(lttng_ust_dl, build_id,
> 			ip, so_base, build_id, build_id_len);
> -		free(build_id);
> 	}
> 
> 	if (has_debug_link) {
> 		tracepoint(lttng_ust_dl, debug_link,
> 			ip, so_base, dbg_file, crc);
> -		free(dbg_file);
> 	}
> 
> end:
> --
> 2.5.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
