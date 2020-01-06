From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] doc: Fix bind address example for
 lttng-relayd
Date: Mon, 6 Jan 2020 09:39:53 -0500 (EST)
Message-ID: <2006658589.17563.1578321593973.JavaMail.zimbra__29524.5326867857$1578321617$gmane$org@efficios.com>
References: <20200106051954.138370-1-benjamin.poirier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 47rypM3nQJz1VqV
 for <lttng-dev@lists.lttng.org>; Mon,  6 Jan 2020 09:39:55 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id C54DA692B26
 for <lttng-dev@lists.lttng.org>; Mon,  6 Jan 2020 09:39:54 -0500 (EST)
In-Reply-To: <20200106051954.138370-1-benjamin.poirier@gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Jan 6, 2020, at 12:19 AM, Benjamin Poirier benjamin.poirier@gmail.com wrote:

> INADDR_ANY is 0.0.0.0

Hi Benjamin,

Double-checking this seems to confirm what the man page states:

% lttng-relayd -b
% netstat -lnp | grep lttng-relayd
tcp        0      0 0.0.0.0:5342            0.0.0.0:*               LISTEN      4445/lttng-relayd   
tcp        0      0 0.0.0.0:5343            0.0.0.0:*               LISTEN      4445/lttng-relayd   
tcp        0      0 127.0.0.1:5344          0.0.0.0:*               LISTEN      4445/lttng-relayd   
unix  2      [ ACC ]     STREAM     LISTENING     56508    4445/lttng-relayd    /home/compudj/.lttng/relayd/health-4445

Based on this output, the "live" port of the relayd daemon appears to be listening
only on 127.0.0.1 by default.

What makes you think the man page needs to be updated ?

Thanks,

Mathieu

> 
> Fixes: c93eadade277 ("doc/man: use propagated default values in man pages")
> Signed-off-by: Benjamin Poirier <benjamin.poirier@gmail.com>
> ---
> doc/man/lttng-relayd.8.txt | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/man/lttng-relayd.8.txt b/doc/man/lttng-relayd.8.txt
> index be59675d..bf88a535 100644
> --- a/doc/man/lttng-relayd.8.txt
> +++ b/doc/man/lttng-relayd.8.txt
> @@ -40,7 +40,7 @@ it can write to the output directory and listen on the
> configured ports.
> If a user is within a secured network and/or has proper firewall
> settings, `lttng-relayd` can listen to LTTng live connections from _all_
> network interfaces by specifying
> -+--live-port=tcp://{default_network_viewer_bind_address}:{default_network_viewer_port}+.
> ++--live-port=tcp://0.0.0.0:{default_network_viewer_port}+.
> 
> Once a trace has been streamed completely, the trace can be processed by
> any tool that can process an LTTng trace located on the local
> --
> 2.25.0.rc0
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
