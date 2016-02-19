From: Jeffrey Chen <cpthk@hotmail.com>
Subject: Re: LTTng buffer mode
Date: Fri, 19 Feb 2016 09:00:34 +0000
Message-ID: <BY2PR15MB07598F61A09D22D0CBF9B785ABA00__43718.3839538649$1455872507$gmane$org@BY2PR15MB0759.namprd15.prod.outlook.com>
References: <BY2PR15MB0759C952513EFB6E18812650ABAE0@BY2PR15MB0759.namprd15.prod.outlook.com>,
 <CAB4xu_1qu7ezjfafSHc_CmM=YzcNhu9Oxyim=kd7N2U-OTJwZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from blu004-omc1s38.hotmail.com ([65.55.116.49])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <cpthk@hotmail.com>) id 1aWgvY-0004jK-QF
 for lttng-dev@lists.lttng.org; Fri, 19 Feb 2016 04:00:44 -0500
In-Reply-To: <CAB4xu_1qu7ezjfafSHc_CmM=YzcNhu9Oxyim=kd7N2U-OTJwZw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Thanks.
If we make changes to LTTng to add this feature, would it violate the LTTng design principle in any way? Thanks.


________________________________________
From: Philippe Proulx <eeppeliteloop@gmail.com>
Sent: Tuesday, February 16, 2016 5:02 PM
To: Jeffrey Chen
Cc: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] LTTng buffer mode

No you cannot.

There's no hidden global buffering scheme option for user space tracing.

From the LTTng documentation:

> In the user space tracing domain, two buffering schemes are available
> when creating a channel:
>
> Per-PID buffering: keep one ring buffer per process.
> Per-UID buffering: keep one ring buffer for all processes of a single user.

and:

> The Linux kernel tracing domain only has one available buffering scheme
> which is to use a single ring buffer for the whole system.

Phil

On Tue, Feb 16, 2016 at 7:55 PM, Jeffrey Chen <cpthk@hotmail.com> wrote:
> Hi LTTng community:
>
>
> I have a question about LTTng buffer mode. According to documentation, LTTng
> supports 2 buffer modes, per-pid, and per-uid. Is there any mode to have a
> global buffer that does not have separate buffers? The reason I asked is
> because, LTTng writes different buffer traces to different directory/file.
> It is much more difficult for us to post-process separate directories. We
> would like to have all traces write into one single buffer and
> directory/file, so it is easier to do post-processing. Thanks.
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
