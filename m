From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: set soinfo_data's vdso flag
 correctly in base address statedump
Date: Tue, 30 Jun 2015 22:34:57 +0000 (UTC)
Message-ID: <993897493.1534.1435703697996.JavaMail.zimbra__31088.3426493549$1435703789$gmane$org@efficios.com>
References: <1435701541-8013-1-git-send-email-abusque@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZA47X-0000em-Er
 for lttng-dev@lists.lttng.org; Tue, 30 Jun 2015 18:35:23 -0400
In-Reply-To: <1435701541-8013-1-git-send-email-abusque@efficios.com>
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

merged into master, thanks!

Mathieu

----- On Jun 30, 2015, at 5:59 PM, Antoine Busque abusque@efficios.com wrote:

> The vdso flag is set to 0 when the executable can be found on disk.
> 
> Signed-off-by: Antoine Busque <abusque@efficios.com>
> ---
> liblttng-ust/lttng-ust-statedump.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/liblttng-ust/lttng-ust-statedump.c
> b/liblttng-ust/lttng-ust-statedump.c
> index 4faee07..37f067f 100644
> --- a/liblttng-ust/lttng-ust-statedump.c
> +++ b/liblttng-ust/lttng-ust-statedump.c
> @@ -191,6 +191,8 @@ int extract_soinfo_events(struct dl_phdr_info *info, size_t
> size, void *_data)
> 				snprintf(resolved_path, PATH_MAX - 1, "[%s]",
> 					info->dlpi_name);
> 				so_data.vdso = 1;
> +			} else {
> +				so_data.vdso = 0;
> 			}
> 		}
> 
> --
> 2.4.5

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
