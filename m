From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: adding new channel
Date: Fri, 20 Feb 2015 14:05:06 -0500
Message-ID: <CAB4xu_3QRDuKefYVY4Bc_eTs5tnmaYDb4+Um1Rf3t2zYtZO1jQ__33961.3507771448$1424459184$gmane$org@mail.gmail.com>
References: <CAM5kDqydAEebJm0_MotZ0xTAMJo51j+Zxxw5-skppaJYcN6g0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f51.google.com ([209.85.215.51])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1YOstS-0003Rd-5P
 for lttng-dev@lists.lttng.org; Fri, 20 Feb 2015 14:05:44 -0500
Received: by lams18 with SMTP id s18so8028372lam.13
 for <lttng-dev@lists.lttng.org>; Fri, 20 Feb 2015 11:05:36 -0800 (PST)
In-Reply-To: <CAM5kDqydAEebJm0_MotZ0xTAMJo51j+Zxxw5-skppaJYcN6g0Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Fri, Feb 20, 2015 at 2:00 PM, Anand Neeli <anand.neeli@gmail.com> wrote:
> Hi All,
> Is adding a new channel to an existing(running) session supported?

No.
>
> i get following error when doing this.
> Error: Channel myc5: Tracing already started
>
> Is there any way to add channels on the fly?

No. LTTng's documentation [1] states:

    Note: Because of a current limitation, all channels must be
    created prior to beginning tracing in a given tracing session,
    i.e. before the first time you do lttng start.

    Since a channel is automatically created by enable-event
    only for the specified domain, you cannot, for example, enable
    a kernel domain event, start tracing and then enable a user
    space domain event because no user space channel exists
    yet and it's too late to create one.

    For this reason, make sure to configure your channels
    properly before starting the tracers for the first time!

Phil

[1] http://lttng.org/docs/#doc-enabling-disabling-channels

> I'm using 2.4.1 version
>
> Thanks,
> Anand Neeli
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
