From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Add setuid wrappers for per-UID
 buffers
Date: Tue, 4 Jun 2019 15:47:14 -0400 (EDT)
Message-ID: <1438409627.28159.1559677634718.JavaMail.zimbra__28445.8440075227$1559677652$gmane$org@efficios.com>
References: <20190531210401.13480-1-gabriel.pollo-guilbert@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45JMrh5lWkzylq
 for <lttng-dev@lists.lttng.org>; Tue,  4 Jun 2019 15:47:16 -0400 (EDT)
In-Reply-To: <20190531210401.13480-1-gabriel.pollo-guilbert@efficios.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Gabriel-Andrew Pollo-Guilbert <gabriel.pollo-guilbert@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On May 31, 2019, at 5:04 PM, Gabriel-Andrew Pollo-Guilbert gabriel.pollo-guilbert@efficios.com wrote:

> In case of a per-UID buffer, events following a change of user ID should be
> forwarded to buffers of the new UID. In order to do so, we add a wrapper around
> setuid(3), setreuid(3) and setresuid(2) that unregister and re-register the
> application from the session daemon.
> 
> While there exist some other functions such as seteuid(3) or setfsuid(2), we
> don't need to add a wrapper for them since they do not edit the real user ID,
> the actual ID returned by getuid(3) and used for creating the buffers.

[...]

> 
> diff --git a/doc/man/lttng-ust.3.txt b/doc/man/lttng-ust.3.txt
> index 5c9c9f5d..b252c11d 100644
> --- a/doc/man/lttng-ust.3.txt
> +++ b/doc/man/lttng-ust.3.txt
> @@ -744,6 +744,17 @@ library before you start the application. Typical use cases
> include
> daemons closing all file descriptors after man:fork(2), and buggy
> applications doing ``double-closes''.
> 
> +Using LTTng-UST with applications that change user
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +If your application is traced using per-UID buffers and changes user ID using
> +man:setuid(2), the library `liblttng-ust-setuid.so` needs to be preloaded
> +before starting the application with the `LD_PRELOAD` environment variable (see
> +man:ld.so(8)). This way, events generated after the UID change will be fowarded

fowarded -> forwarded

The rest looks good, please add this tag to your next round for this patch:

Acked-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

I'll wait until feedback is provided on the testing side (lttng-tools) and
the work on that front is finalized before merging this patch into lttng-ust.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
