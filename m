From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH urcu v2] runtests: Make path of time
	binary	configurable
Date: Thu, 15 Nov 2012 09:10:01 -0500
Message-ID: <20121115141001.GA31720__7653.25188772312$1352988638$gmane$org@Krystal>
References: <1352988119-2312-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TZ08p-0003la-O8
	for lttng-dev@lists.lttng.org; Thu, 15 Nov 2012 09:10:03 -0500
Content-Disposition: inline
In-Reply-To: <1352988119-2312-1-git-send-email-simon.marchi@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Simon Marchi (simon.marchi@polymtl.ca) wrote:
> I work on a platform that does not come with a time program. This patch
> makes it possible to specify the path of the time binary or not use it
> if none is available.
> 
> If the URCU_TEST_TIME_BIN environment variable exists and is executable,
> it is used. Otherwise it tries with /usr/bin/time, the most common
> location. If it is not there, the tests are ran without timing info.
> 
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>

I have a problem when running make check from userspace rcu tree root
with this patch applied:

Executing batch RCU test
./runtests-batch.sh: 3: ./runtests-batch.sh: source: not found

Thoughts ?

Mathieu

> ---
> 
> New in v2: removed #!/bin/sh at top of common.sh.
> 
>  tests/common.sh         |   12 ++++++++++++
>  tests/runtests-batch.sh |   15 +++++++++++++--
>  tests/runtests.sh       |   15 +++++++++++++--
>  3 files changed, 38 insertions(+), 4 deletions(-)
>  create mode 100755 tests/common.sh
> 
> diff --git a/tests/common.sh b/tests/common.sh
> new file mode 100755
> index 0000000..9eb03f8
> --- /dev/null
> +++ b/tests/common.sh
> @@ -0,0 +1,12 @@
> +#
> +# This file is meant to be sourced from other tests scripts.
> +#
> +
> +if [ -x "$URCU_TEST_TIME_BIN" ]; then
> +	test_time_bin="$URCU_TEST_TIME_BIN"
> +elif [ -x "/usr/bin/time" ]; then
> +	test_time_bin="/usr/bin/time"
> +else
> +	test_time_bin=""
> +fi
> +
> diff --git a/tests/runtests-batch.sh b/tests/runtests-batch.sh
> index 6c2340d..222069c 100755
> --- a/tests/runtests-batch.sh
> +++ b/tests/runtests-batch.sh
> @@ -1,8 +1,19 @@
>  #!/bin/sh
>  
> +source "./common.sh"
> +
> +log_file="runall.detail.log"
> +
> +# Check if time bin is defined
> +if [ -n "$test_time_bin" ]; then
> +	time_command="$test_time_bin -a -o $log_file"
> +else
> +	time_command=""
> +fi
> +
>  #for a in test_urcu_gc test_urcu_gc_mb test_urcu_qsbr_gc; do
>  for a in test_urcu_gc; do
> -	echo "./${a} $*" | tee -a runall.detail.log
> -	/usr/bin/time -a -o runall.detail.log ./${a} $*
> +	echo "./${a} $*" | tee -a "$log_file"
> +	$time_command ./${a} $*
>  done
>  
> diff --git a/tests/runtests.sh b/tests/runtests.sh
> index 79e54df..b3d3dc2 100755
> --- a/tests/runtests.sh
> +++ b/tests/runtests.sh
> @@ -1,10 +1,21 @@
>  #!/bin/sh
>  
> +source "./common.sh"
> +
> +log_file="runall.detail.log"
> +
> +# Check if time bin is defined
> +if [ -n "$test_time_bin" ]; then
> +	time_command="$test_time_bin -a -o $log_file"
> +else
> +	time_command=""
> +fi
> +
>  for a in test_urcu_gc test_urcu_signal_gc test_urcu_mb_gc test_urcu_qsbr_gc \
>  	test_urcu_lgc test_urcu_signal_lgc test_urcu_mb_lgc test_urcu_qsbr_lgc \
>  	test_urcu test_urcu_signal test_urcu_mb test_urcu_qsbr \
>  	test_rwlock test_perthreadlock test_mutex; do
> -	echo "./${a} $*" | tee -a runall.detail.log
> -	/usr/bin/time -a -o runall.detail.log ./${a} $*
> +	echo "./${a} $*" | tee -a "$log_file"
> +	$time_command ./${a} $*
>  done
>  
> -- 
> 1.7.1
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
