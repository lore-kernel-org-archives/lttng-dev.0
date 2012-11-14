From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH urcu] runtests: check for existence
	of	/usr/bin/time
Date: Wed, 14 Nov 2012 17:00:00 -0500
Message-ID: <20121114220000.GA7992__14937.2710533955$1352930458$gmane$org@Krystal>
References: <1352929853-13417-1-git-send-email-simon.marchi@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TYl06-0004gf-NS
	for lttng-dev@lists.lttng.org; Wed, 14 Nov 2012 17:00:02 -0500
Content-Disposition: inline
In-Reply-To: <1352929853-13417-1-git-send-email-simon.marchi@polymtl.ca>
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
> Otherwise, if /usr/bin/time does not exist, the tests won't run at all.

Hrm, wouldn't it be better if configure.ac checks that time is there ?

Thanks,

Mathieu

> 
> Signed-off-by: Simon Marchi <simon.marchi@polymtl.ca>
> ---
>  tests/runtests-batch.sh |    8 +++++++-
>  tests/runtests.sh       |    8 +++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/runtests-batch.sh b/tests/runtests-batch.sh
> index 6c2340d..d11609e 100755
> --- a/tests/runtests-batch.sh
> +++ b/tests/runtests-batch.sh
> @@ -1,8 +1,14 @@
>  #!/bin/sh
>  
> +if [ -x /usr/bin/time ]; then
> +	TIME_COMMAND="/usr/bin/time -a -o runnall.detail.log"
> +else
> +	TIME_COMMAND=""
> +fi
> +
>  #for a in test_urcu_gc test_urcu_gc_mb test_urcu_qsbr_gc; do
>  for a in test_urcu_gc; do
>  	echo "./${a} $*" | tee -a runall.detail.log
> -	/usr/bin/time -a -o runall.detail.log ./${a} $*
> +	$TIME_COMMAND ./${a} $*
>  done
>  
> diff --git a/tests/runtests.sh b/tests/runtests.sh
> index 79e54df..563ebd3 100755
> --- a/tests/runtests.sh
> +++ b/tests/runtests.sh
> @@ -1,10 +1,16 @@
>  #!/bin/sh
>  
> +if [ -x /usr/bin/time ]; then
> +	TIME_COMMAND="/usr/bin/time -a -o runnall.detail.log"
> +else
> +	TIME_COMMAND=""
> +fi
> +
>  for a in test_urcu_gc test_urcu_signal_gc test_urcu_mb_gc test_urcu_qsbr_gc \
>  	test_urcu_lgc test_urcu_signal_lgc test_urcu_mb_lgc test_urcu_qsbr_lgc \
>  	test_urcu test_urcu_signal test_urcu_mb test_urcu_qsbr \
>  	test_rwlock test_perthreadlock test_mutex; do
>  	echo "./${a} $*" | tee -a runall.detail.log
> -	/usr/bin/time -a -o runall.detail.log ./${a} $*
> +	$TIME_COMMAND ./${a} $*
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
