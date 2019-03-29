From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-tools v2 2/2] Tests: plan_tests must
 be called before running tests/skipping
Date: Fri, 29 Mar 2019 16:27:27 -0400
Message-ID: <20190329202727.GC4613__2557.09654172591$1553891272$gmane$org@joraj-alpa>
References: <20190328210221.27662-1-jonathan.rajotte-julien@efficios.com>
 <20190328210221.27662-2-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44WCw91CZxz1KnX
 for <lttng-dev@lists.lttng.org>; Fri, 29 Mar 2019 16:27:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20190328210221.27662-2-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
Cc: jgalar@efficios.com
List-Id: lttng-dev@lists.lttng.org

Do not consider this patch, it is bogus.

The test plan is already defined inside the notification executable runned in
kernel_test.

Thanks

On Thu, Mar 28, 2019 at 05:02:21PM -0400, Jonathan Rajotte wrote:
> Otherwise tap parsers can complain that there was no test plan and
> report a failure.
> 
> Signed-off-by: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
> ---
>  tests/regression/tools/notification/test_notification_kernel | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/regression/tools/notification/test_notification_kernel b/tests/regression/tools/notification/test_notification_kernel
> index e7368df26..604cc48cf 100755
> --- a/tests/regression/tools/notification/test_notification_kernel
> +++ b/tests/regression/tools/notification/test_notification_kernel
> @@ -107,12 +107,13 @@ function kernel_test
>  	rm -rf ${consumerd_pipe[@]} 2> /dev/null
>  }
>  
> +plan_tests $NUM_TESTS
> +
>  if [ "$(id -u)" == "0" ]; then
>  	validate_lttng_modules_present
>  	kernel_test
>  else
>  	# Kernel tests are skipped.
> -	plan_tests $NUM_TESTS
>  	skip 0 "Root access is needed. Skipping all kernel notification tests." $NUM_TESTS
>  fi
>  
> -- 
> 2.17.1
> 

-- 
Jonathan Rajotte-Julien
EfficiOS
