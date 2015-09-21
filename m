From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Unnecessary bit shit
Date: Mon, 21 Sep 2015 18:44:45 +0000 (UTC)
Message-ID: <1806250118.12750.1442861085910.JavaMail.zimbra__51.6386041001127$1442861176$gmane$org@efficios.com>
References: <1442860293-20922-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Ze65D-00024k-MG
 for lttng-dev@lists.lttng.org; Mon, 21 Sep 2015 14:45:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id B5653340602
 for <lttng-dev@lists.lttng.org>; Mon, 21 Sep 2015 18:44:54 +0000 (UTC)
In-Reply-To: <1442860293-20922-1-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Merged, with title edit. ;-)

Thanks,

Mathieu

----- On Sep 21, 2015, at 2:31 PM, Jonathan Rajotte jonathan.rajotte-julien@efficios.com wrote:

> Reported by cppcheck [1].
> 
> [1]
> https://ci.lttng.org/view/Code%20quality/job/lttng-ust_master_cppcheck/5/cppcheckResult/source.10/
> 
> Proposed-by: Michael Jeanson <mjeanson@efficios.com>
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
> libringbuffer/backend_internal.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libringbuffer/backend_internal.h b/libringbuffer/backend_internal.h
> index 344784f..79f8bde 100644
> --- a/libringbuffer/backend_internal.h
> +++ b/libringbuffer/backend_internal.h
> @@ -485,7 +485,7 @@ static inline int lttng_ust_fls(unsigned int x)
> 		r -= 2;
> 	}
> 	if (!(x & 0x80000000U)) {
> -		x <<= 1;
> +		/* No need to bit shift on last operation */
> 		r -= 1;
> 	}
> 	return r;
> --
> 2.1.4

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
