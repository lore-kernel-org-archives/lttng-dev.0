From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust 3/3] Update .gitignore
Date: Tue, 6 Aug 2013 11:38:30 -0400
Message-ID: <20130806153830.GB13118__2985.37341082028$1375803626$gmane$org@Krystal>
References: <1374645347-20312-1-git-send-email-soariez@gmail.com>
	<1374645347-20312-3-git-send-email-soariez@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V6jLC-0001pv-Po
	for lttng-dev@lists.lttng.org; Tue, 06 Aug 2013 11:38:36 -0400
Content-Disposition: inline
In-Reply-To: <1374645347-20312-3-git-send-email-soariez@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Zifei Tong <soariez@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

merged, thanks!

* Zifei Tong (soariez@gmail.com) wrote:
> Signed-off-by: Zifei Tong <soariez@gmail.com>
> ---
>  .gitignore | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 3d17940..07d1306 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -34,6 +34,8 @@ ust-consumerd/ust-consumerd
>  doc/examples/demo/demo
>  doc/examples/easy-ust/sample
>  doc/examples/hello-static-lib/hello
> +doc/examples/gen-tp/sample
> +doc/examples/gen-tp/sample_tracepoint.h
>  
>  tests/hello/hello
>  tests/hello.cxx/hello
> @@ -44,3 +46,5 @@ tests/trace_event/trace_event_test
>  tests/tracepoint/benchmark/tracepoint_benchmark
>  tests/tracepoint/tracepoint_test
>  tests/snprintf/prog
> +tests/benchmark/bench1
> +tests/benchmark/bench2
> -- 
> 1.8.3.3
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
