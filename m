From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Fix (another) linker library order
Date: Sat, 11 May 2013 23:00:25 -0400
Message-ID: <20130512030024.GD405__43333.8820621886$1368327651$gmane$org@Krystal>
References: <1368319479-7433-1-git-send-email-francis.giraldeau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UbMWP-0006nF-Vk
	for lttng-dev@lists.lttng.org; Sat, 11 May 2013 23:00:26 -0400
Content-Disposition: inline
In-Reply-To: <1368319479-7433-1-git-send-email-francis.giraldeau@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Giraldeau <francis.giraldeau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> Libraries must be specified after the binary target.

merged, thanks,

Mathieu

> 
> Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
> ---
>  doc/examples/hello-static-lib/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/examples/hello-static-lib/Makefile b/doc/examples/hello-static-lib/Makefile
> index a5bf2df..dd246f7 100644
> --- a/doc/examples/hello-static-lib/Makefile
> +++ b/doc/examples/hello-static-lib/Makefile
> @@ -46,7 +46,7 @@ hello.o: hello.c
>  	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
>  
>  hello: hello.o lttng-ust-provider-hello.a
> -	$(CC) -o $@ $(LDFLAGS) $(LIBS) $^
> +	$(CC) -o $@ $(LDFLAGS) $^ $(LIBS)
>  
>  .PHONY: clean
>  clean:
> -- 
> 1.8.1.2
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
