From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tool] Fix: mi: Make sure
	GIT_VERSION	symbol always exist
Date: Thu, 31 Jul 2014 21:17:17 +0000 (UTC)
Message-ID: <649476030.24171.1406841437430.JavaMail.zimbra__35181.450416758$1406841497$gmane$org@efficios.com>
References: <1406584476-32009-1-git-send-email-jonathan.r.julien@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XCxiw-0006Ov-C6
 for lttng-dev@lists.lttng.org; Thu, 31 Jul 2014 17:17:24 -0400
In-Reply-To: <1406584476-32009-1-git-send-email-jonathan.r.julien@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Just to make sure: I guess this patch is not needed
after the changes I did ?

----- Original Message -----
> From: "Jonathan Rajotte Julien" <jonathan.r.julien@gmail.com>
> To: lttng-dev@lists.lttng.org
> Sent: Monday, July 28, 2014 5:54:36 PM
> Subject: [lttng-dev] [PATCH lttng-tool] Fix: mi: Make sure GIT_VERSION	symbol always exist
> 
> The use of GIT_VERSION symbol in mi to express the position in git tree
> force the need to have it defined for each type of build.
> 
> This make sure that a build from source file only (git scm not present) is
> possible.
> 
> Signed-off-by: Jonathan Rajotte Julien <jonathan.r.julien@gmail.com>
> ---
>  include/Makefile.am    | 15 ++-------------
>  include/version.h.tmpl |  6 +++++-
>  2 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/include/Makefile.am b/include/Makefile.am
> index d40cb4a..ca515da 100644
> --- a/include/Makefile.am
> +++ b/include/Makefile.am
> @@ -47,19 +47,8 @@ version.h:
>  			## don't want to update the file if it is already up to date
>  			##
>  			if [ $$(grep -cE "^#define GIT_VERSION \"?$${git_version}\"?$$"
>  			"$${version_h}") -eq 0 ]; then \
> -				if [ $$(grep -c "^#define GIT_VERSION" "$${version_h}") -gt 0 ]; then \
> -					##
> -					## If there is already a GIT_VERSION defined,
> -					## we just replace it by the new version
> -					##
> -					sed -i "s'^#define GIT_VERSION.*$$'#define GIT_VERSION
> \"$${git_version}\"'" "$${version_h}"; \
> -				else \
> -					##
> -					## Else, we add a GIT_VERSION define
> -					## containing our new version.
> -					##
> -					sed -i "s'^\(#define VERSION_H.*\)$$'\1\n\n#define GIT_VERSION
> \"$${git_version}\"'" "$${version_h}"; \
> -				fi; \
> +				sed -i "s'^#define GIT_VERSION.*$$'#define GIT_VERSION
> \"$${git_version}\"'" "$${version_h}"; \
> +				sed -i "s'^#define GIT_SOURCE.*$$'#define GIT_SOURCE 1'"
> "$${version_h}"; \
>  			fi; \
>  		fi; \
>  	fi)
> diff --git a/include/version.h.tmpl b/include/version.h.tmpl
> index 2cab733..3ef6905 100644
> --- a/include/version.h.tmpl
> +++ b/include/version.h.tmpl
> @@ -20,10 +20,14 @@
>  #ifndef VERSION_H
>  #define VERSION_H
>  
> +
> +#define GIT_SOURCE 0
> +#define GIT_VERSION ""
> +
>  /*
>   * Define the macro containing the FULL version
>   */
> -#ifdef GIT_VERSION
> +#if GIT_SOURCE
>  #define FULL_VERSION "" GIT_VERSION
>  #else /* GIT_VERSION */
>  #define FULL_VERSION "" VERSION
> --
> 2.0.0
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
