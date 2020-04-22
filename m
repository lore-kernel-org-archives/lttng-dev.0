From: Sergei Dyshel via lttng-dev <lttng-dev@lists.lttng.org>
Subject: Re: Have live session and rotation together
Date: Wed, 22 Apr 2020 21:18:47 +0300
Message-ID: <CAAeL1MEWf=qo59pPCOEcqOm_obg3w0v=LHSmcZtfdt8=QM_vOA@mail.gmail.com>
References: <CAAeL1MEpwm_HgfJOXfZuoe=f9SbG+uTdcLSUeJAEFe9+hNyc-g@mail.gmail.com>
 <211031090.61650.1587478983634.JavaMail.zimbra@efficios.com>
 <CAAeL1ME-1B6uLf9iGVWcpA=5MqAMLaCoq+eLkDCsd=GpXy5gJg@mail.gmail.com>
 <1540290911.63019.1587510939096.JavaMail.zimbra@efficios.com>
Reply-To: Sergei Dyshel <qyron.private@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by lists.lttng.org (Postfix) with ESMTPS id 496pbl6q4Nz1j5M
 for <lttng-dev@lists.lttng.org>; Wed, 22 Apr 2020 14:18:59 -0400 (EDT)
Received: by mail-oi1-x231.google.com with SMTP id j16so2672864oih.10
 for <lttng-dev@lists.lttng.org>; Wed, 22 Apr 2020 11:18:59 -0700 (PDT)
In-Reply-To: <1540290911.63019.1587510939096.JavaMail.zimbra@efficios.com>
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

Thanks! I really missed this feature somehow.

However I see that passing 0 as "tracefile size" will remove size
limitation. Is it possible to disable CTF trace writing altogether?
-- 
Regards,
Sergei Dyshel

On Wed, Apr 22, 2020 at 2:15 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Apr 21, 2020, at 5:37 PM, Sergei Dyshel qyron.private@gmail.com wrote:
>
> [...]
> >
> >> Considering that there are few compelling use-cases for using both
> >> features together, and no customer have expressed interest in this,
> >> it is not part of our roadmap.
> >
> > Here is my case: I'm using LTTNG for continuous tracing during the
> > whole system timeline,
> > generating pretty big volume of traces.
> >
> > I'm using live and session and Babeltrace2 plugin which converts
> > processes these traces,
> > converts them to text and stores them
> > in some text file to which I apply "logrotate" so that old traces are
> > archived when needed.
> >
> > However, as I see, "lttng-relayd" also writes binary traces in CTF
> > from to some directory, never discarding old traces. So assuming
> > system long runtime this directory is going to eat all the free space
> > sometime?! Rotation would allow me to discard old archives just as
> > "logrotate" does. How else can I discard old CTF files?
>
> The feature you need is called "tracefile rotation", with the channel
> attributes "tracefile count" and "tracefile size". It was implemented at
> the same time as the live mode for exactly the purpose you describe.
>
> See https://lttng.org/docs/#doc-tracefile-rotation for more information.
>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
