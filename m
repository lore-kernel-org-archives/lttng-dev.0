From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Tests: Fix wrong number of
 tests in thread stall as root test
Date: Wed, 19 Jun 2013 15:26:55 -0400
Message-ID: <51C205FF.8060005__20835.8794487596$1371670055$gmane$org@efficios.com>
References: <1371669725-20853-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UpO21-0000lp-PI
	for lttng-dev@lists.lttng.org; Wed, 19 Jun 2013 15:27:02 -0400
In-Reply-To: <1371669725-20853-1-git-send-email-christian.babeux@efficios.com>
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

Merged

Christian Babeux:
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  tests/regression/tools/health/test_thread_stall | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/regression/tools/health/test_thread_stall b/tests/regression/tools/health/test_thread_stall
> index 9295131..0e8b510 100755
> --- a/tests/regression/tools/health/test_thread_stall
> +++ b/tests/regression/tools/health/test_thread_stall
> @@ -24,7 +24,7 @@ SESSION_NAME="health_thread_stall"
>  EVENT_NAME="bogus"
>  HEALTH_CHECK_BIN="health_check"
>  SESSIOND_PRELOAD=".libs/libhealthstall.so"
> -NUM_TESTS=11
> +NUM_TESTS=12
>  
>  source $TESTDIR/utils/utils.sh
>  
> @@ -131,7 +131,7 @@ else
>  	isroot=0
>  fi
>  
> -skip $isroot "Root access is needed. Skipping LTTNG_THREAD_MANAGE_KERNEL tests." "3" ||
> +skip $isroot "Root access is needed. Skipping LTTNG_THREAD_MANAGE_KERNEL tests." "4" ||
>  {
>  	test_thread_stall "LTTNG_THREAD_MANAGE_KERNEL" "8"
>  }
