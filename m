From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: LTTng buffer mode
Date: Tue, 16 Feb 2016 20:02:56 -0500
Message-ID: <CAB4xu_1qu7ezjfafSHc_CmM=YzcNhu9Oxyim=kd7N2U-OTJwZw__36231.8948763006$1455671056$gmane$org@mail.gmail.com>
References: <BY2PR15MB0759C952513EFB6E18812650ABAE0@BY2PR15MB0759.namprd15.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1aVqWh-0008EM-UL
 for lttng-dev@lists.lttng.org; Tue, 16 Feb 2016 20:03:32 -0500
Received: by mail-lb0-f180.google.com with SMTP id x1so747780lbj.3
 for <lttng-dev@lists.lttng.org>; Tue, 16 Feb 2016 17:03:31 -0800 (PST)
In-Reply-To: <BY2PR15MB0759C952513EFB6E18812650ABAE0@BY2PR15MB0759.namprd15.prod.outlook.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jeffrey Chen <cpthk@hotmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

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
