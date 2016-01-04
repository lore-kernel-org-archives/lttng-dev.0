From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH babeltrace] Do not use g_list_free_full
Date: Mon, 4 Jan 2016 16:42:06 -0500
Message-ID: <568AE72E.5030102__8709.79252872548$1451943791$gmane$org@efficios.com>
References: <1451943430-7346-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1aGCtK-0008CG-GN
 for lttng-dev@lists.lttng.org; Mon, 04 Jan 2016 16:42:15 -0500
In-Reply-To: <1451943430-7346-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


On 2016-01-04 04:37 PM, Jonathan Rajotte wrote:
> Babeltrace support glibc all the way back to 2.20 and g_list_free_full
Sorry the version number here should be 2.22. Do you want a new patch ?
> exists from 2.28.0 (backported to 2.27.2) only.
>
> The replacement is the current implementation found in modern glibc.
>
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>   formats/ctf/ir/visitor.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/formats/ctf/ir/visitor.c b/formats/ctf/ir/visitor.c
> index 9b65ed5..704a804 100644
> --- a/formats/ctf/ir/visitor.c
> +++ b/formats/ctf/ir/visitor.c
> @@ -724,7 +724,8 @@ end:
>   		g_free(name_copy);
>   	}
>   	if (path_tokens) {
> -		g_list_free_full(path_tokens, free);
> +		g_list_foreach(path_tokens, (GFunc) free, NULL);
> +		g_list_free(path_tokens);
>   	}
>   	return ret;
>   error:

-- 
Jonathan R. Julien
Efficios
