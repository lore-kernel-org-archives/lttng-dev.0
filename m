From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 1/4] Tests: Add a check
	for	color support when printing status
Date: Thu, 20 Sep 2012 22:16:39 -0400
Message-ID: <20120921021639.GB22861__39302.3250428543$1348193836$gmane$org@Krystal>
References: <1348178720-24610-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TEsnJ-0006M8-DS
	for lttng-dev@lists.lttng.org; Thu, 20 Sep 2012 22:16:41 -0400
Content-Disposition: inline
In-Reply-To: <1348178720-24610-1-git-send-email-christian.babeux@efficios.com>
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
> When printing the status of test is OK or FAIL, check if stdout is
> attached to a terminal device. This way the output is not cluttered
> with useless escape characters. Some use cases where we don't want
> colors:
> 
> $ ./sometest | less
> 
> $ ./sometest > a.log
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  tests/utils.h | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/utils.h b/tests/utils.h
> index 7650865..34c8bd6 100644
> --- a/tests/utils.h
> +++ b/tests/utils.h
> @@ -16,10 +16,28 @@
>   */
>  
>  #include <stdio.h>
> +#include <unistd.h>
>  
>  #define BRIGHT 1
>  #define GREEN 32
>  #define RED 31
>  
> -#define PRINT_OK() printf("%c[%d;%dmOK%c[%dm\n", 0x1B, BRIGHT, GREEN, 0x1B, 0);
> -#define PRINT_FAIL() printf("%c[%d;%dmFAIL%c[%dm\n", 0x1B, BRIGHT, RED, 0x1B, 0);
> +#define PRINT_OK()							\
> +do {									\
> +	/* Check for color support */					\
> +	if (isatty(fileno(stdout))) {					\

I'm 100% ok with this approach, just a small optimisation to consider:

change fileno(stdout) for STDOUT_FILENO , as defined by unistd.h.

(same below)

Thanks!

Mathieu

> +		printf("%c[%d;%dmOK%c[%dm\n", 0x1B, BRIGHT, GREEN, 0x1B, 0); \
> +	} else {							\
> +		printf("OK\n");					\
> +	}								\
> +} while (0)
> +
> +#define PRINT_FAIL() \
> +do {									\
> +	/* Check for color support */					\
> +	if (isatty(fileno(stdout))) {					\
> +		printf("%c[%d;%dmFAIL%c[%dm\n", 0x1B, BRIGHT, RED, 0x1B, 0); \
> +	} else {							\
> +		printf("FAIL\n");					\
> +	}								\
> +} while (0)
> -- 
> 1.7.12
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
