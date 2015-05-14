From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: No kernel tracer available
Date: Thu, 14 May 2015 11:30:16 -0400
Message-ID: <CAFXXi0nWomHwkmgE7njmq3vv6PaGk4XiJ-GSo9ATxSda98RVOg__36127.2085262046$1431617572$gmane$org@mail.gmail.com>
References: <CAG4vvd4Fa2dWpWoO_sJqm+6=K4g9W5Cmvz3LuzkzUAQsGTSPPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1Ysv64-0007YP-7t
 for lttng-dev@lists.lttng.org; Thu, 14 May 2015 11:31:06 -0400
Received: by iecmd7 with SMTP id md7so63519461iec.1
 for <lttng-dev@lists.lttng.org>; Thu, 14 May 2015 08:30:46 -0700 (PDT)
In-Reply-To: <CAG4vvd4Fa2dWpWoO_sJqm+6=K4g9W5Cmvz3LuzkzUAQsGTSPPw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Francis Rivest <francis.rivest13@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> Hello, I'm a student at Polytechnique Montreal and we are trying to use
> lttng on ubuntu(Ubuntu 14.04.2 LTS) but always encounter the same problem :
>
> "Error: Unable to list kernel events: Kernel tracer not available"
>
> This happens even though we are root using the command line : sudo su
>
> We reinstalled the packages multiples time for lttng.org and from this
> source : https://launchpad.net/~lttng/+archive/ubuntu/ppa/
>
> We are able to create a session but we can't enable event (kernel tracer not
> available) or start tracing (error : no channel found).
>
> If someone has advice on how to deal we this, it would be appreciated a lot.
>
> Thank you,
>
> -Francis R.
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>

Hi Francis,

I'll start with the obvious stuff. After the "enable-event" command
fails (btw, could you give the exact commands you run?), please check:

1. Is there an "lttng-sessiond" process owned by the root user active
(ps aux | grep lttng-sessiond) ?
2. Are the LTTng kernel modules loaded (lsmod | grep lttng) ?

If the answer to any of those two is no, you will need to investigate
why that is. Perhaps you could provide the output of "dpkg -l | grep
lttng" to see what you have installed exactly.

Simon
