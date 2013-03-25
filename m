From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools 1/6] Tests: Fix wrong number of
 tests in test plan of the thread stall test
Date: Mon, 25 Mar 2013 10:16:50 -0400
Message-ID: <51505C52.4050300__34562.4934918762$1364221060$gmane$org@efficios.com>
References: <1363895807-17892-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UK8Ck-0007JH-3c
	for lttng-dev@lists.lttng.org; Mon, 25 Mar 2013 10:16:54 -0400
In-Reply-To: <1363895807-17892-1-git-send-email-christian.babeux@efficios.com>
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

Merged!

Thanks
David

Christian Babeux:
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  tests/regression/tools/health/test_thread_stall | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/regression/tools/health/test_thread_stall b/tests/regression/tools/health/test_thread_stall
> index 92cfb01..1651c02 100755
> --- a/tests/regression/tools/health/test_thread_stall
> +++ b/tests/regression/tools/health/test_thread_stall
> @@ -24,7 +24,7 @@ SESSION_NAME="health_thread_stall"
>  EVENT_NAME="bogus"
>  HEALTH_CHECK_BIN="health_check"
>  SESSIOND_PRELOAD=".libs/libhealthstall.so"
> -NUM_TESTS=12
> +NUM_TESTS=11
>  
>  source $TESTDIR/utils/utils.sh
>  
