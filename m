From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [Babeltrace PATCH] Remove extra -I for python
	bindings
Date: Fri, 21 Jun 2013 11:21:38 -0400
Message-ID: <20130621152138.GA7591__11119.1296171912$1371828136$gmane$org@Krystal>
References: <1371826196-25578-1-git-send-email-yannick.brosseau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Uq39h-0004up-SO
	for lttng-dev@lists.lttng.org; Fri, 21 Jun 2013 11:21:41 -0400
Content-Disposition: inline
In-Reply-To: <1371826196-25578-1-git-send-email-yannick.brosseau@gmail.com>
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

Merged into bindings/python branch.

Thanks,

Mathieu

* Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
> Same fix as for lttng-tools commit f7cbc765ad2526667f1f20b3a89c596b3422ac34
> 
> Signed-off-by: Yannick Brosseau <yannick.brosseau@gmail.com>
> ---
>  bindings/python/Makefile.am |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/bindings/python/Makefile.am b/bindings/python/Makefile.am
> index 536e07f..b25ce92 100644
> --- a/bindings/python/Makefile.am
> +++ b/bindings/python/Makefile.am
> @@ -1,7 +1,7 @@
>  babeltrace.i: babeltrace.i.in
>  	sed "s/BABELTRACE_VERSION_STR/Babeltrace $(PACKAGE_VERSION)/g" <babeltrace.i.in >babeltrace.i
>  
> -AM_CFLAGS = -I$(PYTHON_INCLUDE) -I$(top_srcdir)/include/
> +AM_CFLAGS = $(PYTHON_INCLUDE) -I$(top_srcdir)/include/
>  
>  EXTRA_DIST = babeltrace.i
>  python_PYTHON = babeltrace.py
> -- 
> 1.7.10.4
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
