From: Sergei Dyshel via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Have live session and rotation together
Date: Wed, 22 Apr 2020 00:37:05 +0300
Message-ID: <CAAeL1ME-1B6uLf9iGVWcpA=5MqAMLaCoq+eLkDCsd=GpXy5gJg@mail.gmail.com>
References: <CAAeL1MEpwm_HgfJOXfZuoe=f9SbG+uTdcLSUeJAEFe9+hNyc-g@mail.gmail.com>
 <211031090.61650.1587478983634.JavaMail.zimbra@efficios.com>
Reply-To: Sergei Dyshel <qyron.private@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by lists.lttng.org (Postfix) with ESMTPS id 496H3222lyz1hnF
 for <lttng-dev@lists.lttng.org>; Tue, 21 Apr 2020 17:37:18 -0400 (EDT)
Received: by mail-oi1-x234.google.com with SMTP id s202so94966oih.3
 for <lttng-dev@lists.lttng.org>; Tue, 21 Apr 2020 14:37:18 -0700 (PDT)
In-Reply-To: <211031090.61650.1587478983634.JavaMail.zimbra@efficios.com>
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

> I do not think this statement is factually correct. I recall that session
> rotation was available for sessions being streamed over the network. What
> makes you think otherwise ?

I think I tried to enable rotation for network streaming session and
failed but I don't have
2.11 version currently to reproduce this.

> Considering that there are few compelling use-cases for using both
> features together, and no customer have expressed interest in this,
> it is not part of our roadmap.

Here is my case: I'm using LTTNG for continuous tracing during the
whole system timeline,
generating pretty big volume of traces.

I'm using live and session and Babeltrace2 plugin which converts
processes these traces,
converts them to text and stores them
in some text file to which I apply "logrotate" so that old traces are
archived when needed.

However, as I see, "lttng-relayd" also writes binary traces in CTF
from to some directory, never discarding old traces. So assuming
system long runtime this directory is going to eat all the free space
sometime?! Rotation would allow me to discard old archives just as
"logrotate" does. How else can I discard old CTF files?

-- 
Regards,
Sergei Dyshel

On Tue, Apr 21, 2020 at 5:23 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Apr 20, 2020, at 4:17 PM, lttng-dev lttng-dev@lists.lttng.org wrote:
>
> > Hi all,
> >
> > When creating live session (lttng create --live) I can not enable rotation:
> >
> > # lttng enable-rotation --size=10M
> > Error: Failed to enable size-based rotation schedule on session BX
>
> This is indeed the expected behavior.
>
> >
> > In LTTNG 2.12 rotation is supported for network streaming mode  but it
> > was not yet supported in 2.11.
>
> I do not think this statement is factually correct. I recall that session
> rotation was available for sessions being streamed over the network. What
> makes you think otherwise ?
>
> >
> > Is there architectural reasons why we can't have live session with rotation?
> > Or is it just not implemented yet? In that case in what version is it
> > expected to appear?
>
> It is not impossible design-wise, but would make the implementation much more
> complex and require a very significant testing effort.
>
> Considering that there are few compelling use-cases for using both
> features together, and no customer have expressed interest in this,
> it is not part of our roadmap.
>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
