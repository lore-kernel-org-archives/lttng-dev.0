From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Tests: Fix nprocesses
	applications shutdown
Date: Tue, 19 Mar 2013 12:05:43 -0400
Message-ID: <51488CD7.5050200__23610.4389223785$1363709201$gmane$org@efficios.com>
References: <1363633209-7528-1-git-send-email-christian.babeux@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UHz2p-0006Wd-KU
	for lttng-dev@lists.lttng.org; Tue, 19 Mar 2013 12:05:47 -0400
In-Reply-To: <1363633209-7528-1-git-send-email-christian.babeux@efficios.com>
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

I have a problem with that. This gets printed for every application:

./test_nprocesses: line 80: 30283 Terminated
./$CURDIR/$TEST_BIN_NAME 1000 > /dev/null 2>&1

The output is not pretty :P

I'm having overall problem with this test for two reasons. First, with
the new changes, registering an application takes a bit longer because
of the back and forth notification event to register events and
channels. This makes the "list application validation" fail most of the
time. Increasing the sleep time helps but it is VERY ARBITRARY.

The second thing is that running this test with a normal user, too many
open files is hit in the consumer and the test of course fails.

So, I think I'll have to find a clever way to validate applications so
not to wait an arbitrary amount of time and probably drop the
applications from 100 to 50.

David

Christian Babeux:
> The nprocesses test is using the SIGPIPE signal to shutdown the
> spawned child applications. This is done in order to silence
> the shell message such as this one:
> 
> "nprocesses/test_nprocesses: line 79: 26458 Terminated"
> 
> This mechanism is broken on systems where the SIGPIPE default handler
> is overriden (thus no application shutdown occurs) in the executing
> environment. This could lead to stale applications polluting the system
> and causing heratic behavior in subsequent tests.
> 
> This commit add a loop and check that all the spawned applications have
> been successfully killed.
> 
> Signed-off-by: Christian Babeux <christian.babeux@efficios.com>
> ---
>  tests/regression/ust/nprocesses/test_nprocesses | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/regression/ust/nprocesses/test_nprocesses b/tests/regression/ust/nprocesses/test_nprocesses
> index e89d02e..23d9a0a 100755
> --- a/tests/regression/ust/nprocesses/test_nprocesses
> +++ b/tests/regression/ust/nprocesses/test_nprocesses
> @@ -74,8 +74,10 @@ destroy_lttng_session $SESSION_NAME
>  
>  rm -rf $TRACE_PATH
>  
> -# Send SIGPIPE to 'silence' bash process status such as "Process as terminated"
> -killall -s PIPE -q $TEST_BIN_NAME >/dev/null 2>&1
> +while [ -n "$(pidof $TEST_BIN_NAME)" ]; do
> +	killall -q $TEST_BIN_NAME >/dev/null 2>&1
> +	sleep 0.5
> +done
>  
>  pass "Kill all spawned applications"
>  
