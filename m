From: Benjamin Poirier <benjamin.poirier@gmail.com>
Subject: Re: [PATCH] doc: Fix bind address example for
 lttng-relayd
Date: Tue, 7 Jan 2020 10:58:43 +0900
Message-ID: <20200107015843.GA159599__38023.3379358955$1578362357$gmane$org@f3>
References: <20200106051954.138370-1-benjamin.poirier@gmail.com>
 <2006658589.17563.1578321593973.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 by lists.lttng.org (Postfix) with ESMTPS id 47sFsl59Qdz1ZkY
 for <lttng-dev@lists.lttng.org>; Mon,  6 Jan 2020 20:58:51 -0500 (EST)
Received: by mail-pl1-x643.google.com with SMTP id c13so22556574pls.0
 for <lttng-dev@lists.lttng.org>; Mon, 06 Jan 2020 17:58:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2006658589.17563.1578321593973.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 2020/01/06 09:39, Mathieu Desnoyers wrote:
> ----- On Jan 6, 2020, at 12:19 AM, Benjamin Poirier benjamin.poirier@gmail.com wrote:
> 
> > INADDR_ANY is 0.0.0.0
> 
> Hi Benjamin,
> 
> Double-checking this seems to confirm what the man page states:
> 
> % lttng-relayd -b
> % netstat -lnp | grep lttng-relayd
> tcp        0      0 0.0.0.0:5342            0.0.0.0:*               LISTEN      4445/lttng-relayd   
> tcp        0      0 0.0.0.0:5343            0.0.0.0:*               LISTEN      4445/lttng-relayd   
> tcp        0      0 127.0.0.1:5344          0.0.0.0:*               LISTEN      4445/lttng-relayd   
> unix  2      [ ACC ]     STREAM     LISTENING     56508    4445/lttng-relayd    /home/compudj/.lttng/relayd/health-4445
> 
> Based on this output, the "live" port of the relayd daemon appears to be listening
> only on 127.0.0.1 by default.

That's right but not relevant to this patch. The part of the man page
changed by this patch is not stating the defaults.

> 
> What makes you think the man page needs to be updated ?

The part of the man page changed by this patch is:
	If a user is within a secured network and/or has proper firewall
	settings, lttng-relayd can listen to LTTng live connections from
	all network interfaces by specifying
	--live-port=tcp://localhost:5344.

That is incorrect. To listen for connections to all addresses on the host,
the socket has to be bound to INADDR_ANY, 0.0.0.0.
