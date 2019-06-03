From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Fix: get tid not pid in vtid
 context
Date: Mon, 3 Jun 2019 14:52:38 -0400 (EDT)
Message-ID: <1158990877.25379.1559587958839.JavaMail.zimbra__35096.9177948841$1559587981$gmane$org@efficios.com>
References: <20190603182110.13044-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45HkhG1BR1z10WF
 for <lttng-dev@lists.lttng.org>; Mon,  3 Jun 2019 14:52:45 -0400 (EDT)
In-Reply-To: <20190603182110.13044-1-mjeanson@efficios.com>
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

Merged into master (only applies to master).

Thanks!

Mathieu

----- On Jun 3, 2019, at 2:21 PM, Michael Jeanson mjeanson@efficios.com wrote:

> Looks like an over enthusiastic copy/paste error in
> commit 98357ffd0125c23387d42d4b706c56077392326d.
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
> ---
> liblttng-ust/lttng-context-vtid.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/liblttng-ust/lttng-context-vtid.c
> b/liblttng-ust/lttng-context-vtid.c
> index 5cefe953..80661f63 100644
> --- a/liblttng-ust/lttng-context-vtid.c
> +++ b/liblttng-ust/lttng-context-vtid.c
> @@ -63,7 +63,7 @@ pid_t wrapper_getvtid(void)
> 
> 	vtid = CMM_LOAD_SHARED(URCU_TLS(cached_vtid));
> 	if (caa_unlikely(!vtid)) {
> -		vtid = getpid();
> +		vtid = gettid();
> 		CMM_STORE_SHARED(URCU_TLS(cached_vtid), vtid);
> 	}
> 	return vtid;
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
