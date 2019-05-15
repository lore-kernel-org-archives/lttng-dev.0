From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH lttng-tools 8/9] lttng-ctl: notifications:
 use epoll()/poll() instead of select()
Date: Wed, 15 May 2019 11:20:20 -0400
Message-ID: <20190515152020.GB14986__49428.2179324486$1557933635$gmane$org@joraj-alpa>
References: <20190503135547.12968-1-mathieu.desnoyers@efficios.com>
 <20190503135547.12968-9-mathieu.desnoyers@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 453ysx3qYpz11qT
 for <lttng-dev@lists.lttng.org>; Wed, 15 May 2019 11:20:21 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20190503135547.12968-9-mathieu.desnoyers@efficios.com>
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
Cc: lttng-dev@lists.lttng.org, jgalar@efficios.com, joraj@efficios.com
List-Id: lttng-dev@lists.lttng.org

On Fri, May 03, 2019 at 09:55:46AM -0400, Mathieu Desnoyers wrote:
> The select(2) system call is an ancient ABI limited to processes
> containing at most FD_SETSIZE file descriptors overall (typically
> 1024).
> 
> Those notification APIs will fail if the target file descriptor
> is above FD_SETSIZE in a process containing many file descriptors.
> 
> Never use select, use the lttng epoll/poll wrapper instead.
> 
> This patch depends on "Change lttng_poll_wait behaviour of compat-poll
> to match compat-epoll" posted by Yannick Lamarre.

Please split the current patchset in two. It will accelerate the acceptation of
the patches not depending on this work.

This is valid for 7,8,9 if I'm not mistaken.

Cheers
