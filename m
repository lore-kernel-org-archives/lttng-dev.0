From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 2/2] Cleanup: Remove
	unused	get_default_session_name() function
Date: Thu, 16 Aug 2012 10:18:59 -0400
Message-ID: <20120816141859.GB29703__49633.4342788488$1345126770$gmane$org@Krystal>
References: <1345048771-18936-1-git-send-email-christian.babeux@efficios.com>
	<1345048771-18936-2-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1T20ua-0002YJ-TL
	for lttng-dev@lists.lttng.org; Thu, 16 Aug 2012 10:19:00 -0400
Content-Disposition: inline
In-Reply-To: <1345048771-18936-2-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org, dgoulet@efficios.com
List-Id: lttng-dev@lists.lttng.org

* Christian Babeux (christian.babeux@efficios.com) wrote:
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> ---
>  src/bin/lttng/commands/destroy.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/src/bin/lttng/commands/destroy.c b/src/bin/lttng/commands/destroy.c
> index 7b7ea0e..cdc2c53 100644
> --- a/src/bin/lttng/commands/destroy.c
> +++ b/src/bin/lttng/commands/destroy.c
> @@ -114,21 +114,6 @@ error:
>  }
>  
>  /*
> - * get_default_session_name
> - *
> - * Returns the default sessions name, if any
> - */
> -static int get_default_session_name(char **name)
> -{
> -	char *session_name = get_session_name();
> -	if (session_name == NULL) {
> -		return CMD_ERROR;
> -	}
> -	*name = session_name;
> -	return CMD_SUCCESS;
> -}
> -
> -/*
>   * The 'destroy <options>' first level command
>   */
>  int cmd_destroy(int argc, const char **argv)
> -- 
> 1.7.11.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
