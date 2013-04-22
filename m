From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Fwd: Bug#705827: babeltrace: FTBFS on GNU/kFreeBSD
Date: Mon, 22 Apr 2013 12:14:42 -0400
Message-ID: <20130422161442.GA17918__43992.1566205614$1366647314$gmane$org@Krystal>
References: <20130422152417.GA13418@quintessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UUJO9-00005U-TQ
	for lttng-dev@lists.lttng.org; Mon, 22 Apr 2013 12:14:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by blackscsi.openrapids.net (Postfix) with ESMTP id BD9D71405F3
	for <lttng-dev@lists.lttng.org>; Mon, 22 Apr 2013 12:14:43 -0400 (EDT)
Received: from blackscsi.openrapids.net ([127.0.0.1])
	by localhost (blackscsi.openrapids.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id u1WTKkuasnPb for <lttng-dev@lists.lttng.org>;
	Mon, 22 Apr 2013 12:14:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20130422152417.GA13418@quintessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Fixed by:

commit 493330cb8cd73be8a598308b78f0fc1d4912843a
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date:   Mon Apr 22 12:12:50 2013 -0400

    Fix kFreeBSD build
    
    Use general error numbers available on kFreeBSD.
    
    Reported-by: Petr Salinger <Petr.Salinger@seznam.cz>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks for reporting,

Mathieu

* Jon Bernard (jbernard@debian.org) wrote:
> Hello all, I received this request over the weekend and wanted to pass it on.
> 
> ----- Forwarded message from Petr Salinger <Petr.Salinger@seznam.cz> -----
> 
> Date: Sat, 20 Apr 2013 19:19:11 +0200 (CEST)
> From: Petr Salinger <Petr.Salinger@seznam.cz>
> To: submit@bugs.debian.org
> Subject: Bug#705827: babeltrace: FTBFS on GNU/kFreeBSD
> 
> Package: babeltrace
> Version: 1.1.0-1
> Severity: serious
> Tags: patch
> User: debian-bsd@lists.debian.org
> Usertags: kfreebsd
> 
> Hi,
> 
> the current version fails to build on GNU/kFreeBSD.
> 
> The value ENODATA is linux specific,
> please use some general error number, like shown bellow.
> 
> It would also be nice if you can inform upstream about this.
> 
> Thanks
> 	Petr
> 
> --- formats/ctf/ctf.c
> +++ formats/ctf/ctf.c
> @@ -1032,7 +1032,7 @@
>         buflen = strlen(*buf);
>         if (!buflen) {
>                 *fp = NULL;
> -               return -ENODATA;
> +               return -ENOENT;
>         }
>         *fp = babeltrace_fmemopen(*buf, buflen, "rb");
>         if (!*fp) {
> 
> ----- End forwarded message -----
> 
> -- 
> Jon
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
