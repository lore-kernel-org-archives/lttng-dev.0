From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: adding new channel
Date: Fri, 20 Feb 2015 15:54:11 -0500
Message-ID: <54E79EF3.3070506__39576.8483089798$1424465736$gmane$org@efficios.com>
References: <CAM5kDqydAEebJm0_MotZ0xTAMJo51j+Zxxw5-skppaJYcN6g0Q@mail.gmail.com>
 <CAB4xu_3QRDuKefYVY4Bc_eTs5tnmaYDb4+Um1Rf3t2zYtZO1jQ@mail.gmail.com>
 <CAM5kDqzCq1ALXOSy2aAE+hB6=e2aFOQQ2snHdGx1WA0vjnBHtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([85.12.144.25])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jdesfossez@efficios.com>) id 1YOuaZ-00040p-M4
 for lttng-dev@lists.lttng.org; Fri, 20 Feb 2015 15:54:25 -0500
In-Reply-To: <CAM5kDqzCq1ALXOSy2aAE+hB6=e2aFOQQ2snHdGx1WA0vjnBHtA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>, Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

I'm just curious, is there a problem with creating new sessions when
needed for this kind of use-case ?

Thanks,

Julien

On 15-02-20 02:25 PM, Anand Neeli wrote:
> Thanks for the reply.
> 
> I think adding channels on the fly must be supported.
> From debugging point of view, it will be good if we can add channels on
> the fly with each channel having different set of events.
> Even "stop tracing" and adding channel doesnt help now.
> 
> Thanks,
> Anand Neeli
> 
> On Sat, Feb 21, 2015 at 12:35 AM, Philippe Proulx
> <eeppeliteloop@gmail.com <mailto:eeppeliteloop@gmail.com>> wrote:
> 
>     On Fri, Feb 20, 2015 at 2:00 PM, Anand Neeli <anand.neeli@gmail.com
>     <mailto:anand.neeli@gmail.com>> wrote:
>     > Hi All,
>     > Is adding a new channel to an existing(running) session supported?
> 
>     No.
>     >
>     > i get following error when doing this.
>     > Error: Channel myc5: Tracing already started
>     >
>     > Is there any way to add channels on the fly?
> 
>     No. LTTng's documentation [1] states:
> 
>         Note: Because of a current limitation, all channels must be
>         created prior to beginning tracing in a given tracing session,
>         i.e. before the first time you do lttng start.
> 
>         Since a channel is automatically created by enable-event
>         only for the specified domain, you cannot, for example, enable
>         a kernel domain event, start tracing and then enable a user
>         space domain event because no user space channel exists
>         yet and it's too late to create one.
> 
>         For this reason, make sure to configure your channels
>         properly before starting the tracers for the first time!
> 
>     Phil
> 
>     [1] http://lttng.org/docs/#doc-enabling-disabling-channels
> 
>     > I'm using 2.4.1 version
>     >
>     > Thanks,
>     > Anand Neeli
>     >
>     > _______________________________________________
>     > lttng-dev mailing list
>     > lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
>     > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>     >
> 
> 
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
