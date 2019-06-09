From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: [PATCH lttng-ust v2] Add setuid wrappers for
 per-UID buffers
Date: Sun, 9 Jun 2019 12:08:24 -0400
Message-ID: <CAB4xu_2JZCa89TD3VquKO=ePosY2OjwBTN2PCCVTTNoQ9w2icw__19595.5426593841$1560096548$gmane$org@mail.gmail.com>
References: <20190605185621.17226-1-gabriel.pollo-guilbert@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 by lists.lttng.org (Postfix) with ESMTPS id 45MLmN4lcXz17xB
 for <lttng-dev@lists.lttng.org>; Sun,  9 Jun 2019 12:08:52 -0400 (EDT)
Received: by mail-lf1-x143.google.com with SMTP id j29so4933624lfk.10
 for <lttng-dev@lists.lttng.org>; Sun, 09 Jun 2019 09:08:52 -0700 (PDT)
In-Reply-To: <20190605185621.17226-1-gabriel.pollo-guilbert@efficios.com>
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

On Wed, Jun 5, 2019 at 2:57 PM Gabriel-Andrew Pollo-Guilbert
<gabriel.pollo-guilbert@efficios.com> wrote:
>
> diff --git a/doc/man/lttng-ust.3.txt b/doc/man/lttng-ust.3.txt
> index 5c9c9f5d..d58b43c7 100644
> --- a/doc/man/lttng-ust.3.txt
> +++ b/doc/man/lttng-ust.3.txt
> @@ -744,6 +744,17 @@ library before you start the application. Typical use cases include
>  daemons closing all file descriptors after man:fork(2), and buggy
>  applications doing ``double-closes''.

A few documentation fixes:

>
> +Using LTTng-UST with applications that change user

... that change the effective user ID

> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +If your application is traced using per-UID buffers and changes user ID using

If LTTng traces your application using per-UID buffers (see the
nloption:--buffers-uid option of man:lttng-enable-channel(1)) and
changes the process's effective user ID with

> +man:setuid(2), the library `liblttng-ust-setuid.so` needs to be preloaded
> +before starting the application with the `LD_PRELOAD` environment variable (see
> +man:ld.so(8)). This way, events generated after the UID change will be forwarded

... event records generated after the user ID change are forwarded ...

> +to the correct buffer.
> +
> +This workaround requires that the tracing session be global (root
> +lttng-sessiond) in order to avoid permission problems between a session

... be global (created by a root session daemon; see man:lttng-sessiond(1))
to avoid permission problems of a session

> +daemon started by another user.

Phil

> --
> 2.21.0
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
