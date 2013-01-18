From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [BABELTRACE PATCH] Add missing runall.sh to
	dist	packaging
Date: Fri, 18 Jan 2013 13:16:00 -0500
Message-ID: <20130118181600.GA16664__31903.5650617026$1358533011$gmane$org@Krystal>
References: <1358527840-4543-1-git-send-email-yannick.brosseau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TwGTy-0004aL-17
	for lttng-dev@lists.lttng.org; Fri, 18 Jan 2013 13:16:02 -0500
Content-Disposition: inline
In-Reply-To: <1358527840-4543-1-git-send-email-yannick.brosseau@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
> Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>

merged, thanks!

Mathieu

> ---
>  tests/lib/Makefile.am |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/lib/Makefile.am b/tests/lib/Makefile.am
> index f7e32c2..e9e264b 100644
> --- a/tests/lib/Makefile.am
> +++ b/tests/lib/Makefile.am
> @@ -12,7 +12,7 @@ noinst_PROGRAMS = test-seeks
>  
>  test_seeks_SOURCES = test-seeks.c
>  
> -EXTRA_DIST = README.tap
> +EXTRA_DIST = README.tap runall.sh
>  
>  check-am:
>  	./runall.sh
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
