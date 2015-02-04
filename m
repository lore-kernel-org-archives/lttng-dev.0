From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [urcu][PATCH] trivial:
	urcu-pointer.h:	s/rcu_dereference_pointer/rcu_dereference/
Date: Wed, 4 Feb 2015 17:07:49 +0000 (UTC)
Message-ID: <1774806450.75512.1423069669516.JavaMail.zimbra__18921.8875057579$1423070013$gmane$org@efficios.com>
References: <1422986026-32124-1-git-send-email-cota@braap.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YJ3Qb-0006FN-0X
 for lttng-dev@lists.lttng.org; Wed, 04 Feb 2015 12:07:51 -0500
In-Reply-To: <1422986026-32124-1-git-send-email-cota@braap.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Emilio G. Cota" <cota@braap.org>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Added "Fix: documentation" to the title, merged into
master, stable-0.8 and stable-0.7, thanks!

Mathieu

----- Original Message -----
> From: "Emilio G. Cota" <cota@braap.org>
> To: lttng-dev@lists.lttng.org
> Sent: Tuesday, February 3, 2015 12:53:46 PM
> Subject: [lttng-dev] [urcu][PATCH] trivial: urcu-pointer.h:	s/rcu_dereference_pointer/rcu_dereference/
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  urcu/static/urcu-pointer.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/urcu/static/urcu-pointer.h b/urcu/static/urcu-pointer.h
> index 4361156..a5b3e4b 100644
> --- a/urcu/static/urcu-pointer.h
> +++ b/urcu/static/urcu-pointer.h
> @@ -122,21 +122,21 @@ extern "C" {
>  /**
>   * _rcu_assign_pointer - assign (publicize) a pointer to a new data
>   structure
>   * meant to be read by RCU read-side critical sections. Returns the assigned
>   * value.
>   *
>   * Documents which pointers will be dereferenced by RCU read-side critical
>   * sections and adds the required memory barriers on architectures requiring
>   * them. It also makes sure the compiler does not reorder code initializing
>   the
>   * data structure before its publication.
>   *
> - * Should match rcu_dereference_pointer().
> + * Should match rcu_dereference().
>   *
>   * This macro is less than 10 lines long.  The intent is that this macro
>   * meets the 10-line criterion in LGPL, allowing this function to be
>   * expanded directly in non-LGPL code.
>   */
>  #define _rcu_assign_pointer(p, v)	_rcu_set_pointer(&(p), v)
>  
>  #ifdef __cplusplus
>  }
>  #endif
> --
> 1.8.3
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
