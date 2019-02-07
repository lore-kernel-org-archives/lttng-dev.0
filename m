From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Cleanup: fix typo 'acces' ->
 'access'
Date: Thu, 7 Feb 2019 16:26:08 -0500 (EST)
Message-ID: <693848585.140.1549574768825.JavaMail.zimbra__5504.20129891194$1549574789$gmane$org@efficios.com>
References: <20190207202431.21827-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 43wWZp6fpCzpGT
 for <lttng-dev@lists.lttng.org>; Thu,  7 Feb 2019 16:26:10 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id F07299D813
 for <lttng-dev@lists.lttng.org>; Thu,  7 Feb 2019 16:26:09 -0500 (EST)
In-Reply-To: <20190207202431.21827-1-mjeanson@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Michael Jeanson <mjeanson@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged into ust master, thanks!

Mathieu

----- On Feb 7, 2019, at 3:24 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> liblttng-ust-dl/lttng-ust-dl.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/liblttng-ust-dl/lttng-ust-dl.c b/liblttng-ust-dl/lttng-ust-dl.c
> index ce2ae0e7..231e9ec3 100644
> --- a/liblttng-ust-dl/lttng-ust-dl.c
> +++ b/liblttng-ust-dl/lttng-ust-dl.c
> @@ -107,7 +107,7 @@ void lttng_ust_dl_dlopen(void *so_base, const char *so_name,
> 
> 	elf = lttng_ust_elf_create(resolved_path);
> 	if (!elf) {
> -		ERR("could not acces file %s", resolved_path);
> +		ERR("could not access file %s", resolved_path);
> 		return;
> 	}
> 
> @@ -169,7 +169,7 @@ void lttng_ust_dl_dlmopen(void *so_base, Lmid_t nsid, const
> char *so_name,
> 
> 	elf = lttng_ust_elf_create(resolved_path);
> 	if (!elf) {
> -		ERR("could not acces file %s", resolved_path);
> +		ERR("could not access file %s", resolved_path);
> 		return;
> 	}
> 
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
