From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-tools 8/8] Fix: add missing
 synchronization point for before app test case
Date: Wed, 19 Nov 2014 22:45:59 +0000 (UTC)
Message-ID: <187608591.16819.1416437159675.JavaMail.zimbra__1047.74682918123$1416437310$gmane$org@efficios.com>
References: <1416433232-20080-1-git-send-email-mathieu.desnoyers@efficios.com>
 <1416433232-20080-9-git-send-email-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1XrE0i-0002ze-E7
 for lttng-dev@lists.lttng.org; Wed, 19 Nov 2014 17:46:07 -0500
In-Reply-To: <1416433232-20080-9-git-send-email-mathieu.desnoyers@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: jgalar@efficios.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> To: jgalar@efficios.com
> Cc: lttng-dev@lists.lttng.org, "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Sent: Wednesday, November 19, 2014 10:40:32 PM
> Subject: [PATCH lttng-tools 8/8] Fix: add missing synchronization point for before app test case
> 
> Fixes a race where the application could generate all its events before
> trace start.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
[...]
> b/tests/utils/testapp/gen-ust-events/gen-ust-events.c
> index 42fa082..60f1c6f 100644
> --- a/tests/utils/testapp/gen-ust-events/gen-ust-events.c
> +++ b/tests/utils/testapp/gen-ust-events/gen-ust-events.c
> @@ -15,6 +15,7 @@
>   * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
>   */
>  
> +#define _GNU_SOURCE
>  #include <assert.h>
>  #include <arpa/inet.h>
>  #include <fcntl.h>
> @@ -27,15 +28,21 @@
>  #include <sys/types.h>
>  #include <unistd.h>
>  #include <stdbool.h>
> +#include <signal.h>
> +#include <poll.h>
> +#include <errno.h>
>  
>  #define TRACEPOINT_DEFINE
>  #include "tp.h"
>  
>  void create_file(const char *path)
>  {
> +	static bool file_created = false;
>  	int ret;
>  
> -	assert(path);
> +	if (!path || file_created) {
> +		return;
> +	}
>  
>  	ret = creat(path, S_IRWXU);
>  	if (ret < 0) {
> @@ -44,6 +51,30 @@ void create_file(const char *path)
>  	}
>  
>  	(void) close(ret);
> +	file_created = true;
> +}
> +
> +static
> +void wait_on_file(const char *path)
> +{
> +	if (!path) {
> +		return;
> +	}
> +	for (;;) {
> +		int ret;
> +		struct stat buf;
> +
> +		ret = stat(path, &buf);
> +		if (ret == -1 && errno == ENOENT) {
> +			(void) poll(NULL, 0, 10);	/* 10 ms delay */
> +			continue;			/* retry */
> +		}
> +		if (ret) {
> +			perror("stat");
> +			exit(EXIT_FAILURE);
> +		}
> +		break;	/* found */
> +	}
>  }
>  
>  int main(int argc, char **argv)
> @@ -55,8 +86,8 @@ int main(int argc, char **argv)
>  	float flt = 2222.0;
>  	int nr_iter = 100;
>  	useconds_t nr_usec = 0;
> -	char *tmp_file_path = NULL;
> -	bool file_created = false;
> +	char *after_first_event_file_path = NULL;
> +	char *before_last_event_file_path = NULL;
>  
>  	if (argc >= 2) {
>  		/*
> @@ -71,22 +102,30 @@ int main(int argc, char **argv)
>  	}
>  
>  	if (argc >= 4) {
> -		tmp_file_path = argv[3];
> +		after_first_event_file_path = argv[3];
> +	}
> +
> +	if (argc >= 5) {
> +		before_last_event_file_path = argv[4];
>  	}
>  
>  	for (i = 0; nr_iter < 0 || i < nr_iter; i++) {
> +		if (nr_iter >= 0 && i == nr_iter) {

This should be if (nr_iter >= 0 && i == nr_iter - 1)

Thanks,

Mathieu

> +			/*
> +			 * Wait on synchronization before writing last
> +			 * event.
> +			 */
> +			wait_on_file(before_last_event_file_path);
> +		}
>  		netint = htonl(i);
> -		tracepoint(tp, tptest, i, netint, values, text, strlen(text), dbl,
> -				flt);
> +		tracepoint(tp, tptest, i, netint, values, text,
> +			strlen(text), dbl, flt);
>  
>  		/*
> -		 * First loop we create the file if asked to indicate that at least one
> -		 * tracepoint has been hit.
> +		 * First loop we create the file if asked to indicate
> +		 * that at least one tracepoint has been hit.
>  		 */
> -		if (!file_created && tmp_file_path) {
> -			create_file(tmp_file_path);
> -			file_created = true;
> -		}
> +		create_file(after_first_event_file_path);
>  		usleep(nr_usec);
>  	}
>  
> --
> 2.1.1
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
