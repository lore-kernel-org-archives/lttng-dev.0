From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH babeltrace] Replace AM_PROG_MKDIR obsolete
	macro with	AC_PROG_MKDIR_P
Date: Sat, 23 Mar 2013 19:03:27 -0400
Message-ID: <20130323230327.GA2745__16029.3201836341$1364079865$gmane$org@Krystal>
References: <1364064475-24015-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UJXTH-0005cB-22
	for lttng-dev@lists.lttng.org; Sat, 23 Mar 2013 19:03:31 -0400
Content-Disposition: inline
In-Reply-To: <1364064475-24015-1-git-send-email-christian.babeux@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Christian Babeux (christian.babeux@efficios.com) wrote:
> The bootstrap script is complaining with a deprecation warning [1] for
> the AM_PROG_MKDIR_P Automake macro.

Merged, thanks!

Mathieu

> 
> Relevant bootstrap output:
> 
> configure.ac:13: warning: The 'AM_PROG_MKDIR_P' macro is deprecated,
> 		 and will soon be removed.
> configure.ac:13: You should use the Autoconf-provided 'AC_PROG_MKDIR_P'
> 		 macro instead,
> configure.ac:13: and use '$(MKDIR_P)' instead of '$(mkdir_p)'in your
> 		 Makefile.am files.
> 
> Fix this by updating configure.ac with the proposed AC_PROG_MKDIR_P macro.
> 
> [1] - https://www.gnu.org/software/automake/manual/html_node/Obsolete-Macros.html
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index b96e09f..cc23f5a 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -10,7 +10,7 @@ m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
>  
>  AC_CONFIG_MACRO_DIR([m4])
>  
> -AM_PROG_MKDIR_P
> +AC_PROG_MKDIR_P
>  
>  AC_CONFIG_HEADERS([config.h])
>  
> -- 
> 1.8.2
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
