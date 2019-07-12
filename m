From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: Need help with CTF
Date: Fri, 12 Jul 2019 09:22:03 -0400
Message-ID: <CAB4xu_3oTAYHrmYg5pLBy+OT0rwzmEm3G0jeWxTOPnhFKPgQVg__9654.277602543$1562937769$gmane$org@mail.gmail.com>
References: <CAEWVvOQHcvj3A=8Rufusv9Ti3aF=+yR4ZqWQFc-DpOvgVZUfvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by lists.lttng.org (Postfix) with ESMTPS id 45lYWD0t3Bz1DGn
 for <lttng-dev@lists.lttng.org>; Fri, 12 Jul 2019 09:22:31 -0400 (EDT)
Received: by mail-lf1-x134.google.com with SMTP id h28so6477198lfj.5
 for <lttng-dev@lists.lttng.org>; Fri, 12 Jul 2019 06:22:31 -0700 (PDT)
In-Reply-To: <CAEWVvOQHcvj3A=8Rufusv9Ti3aF=+yR4ZqWQFc-DpOvgVZUfvg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Ravindra Kumar Meena <rmeena840@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Fri, Jul 12, 2019 at 2:04 AM Ravindra Kumar Meena
<rmeena840@gmail.com> wrote:
>
> Hi developers,
>
> trace {
>     major = 1;
>     minor = 8;
>     uuid = "6a7715d0-b502-4c65-8678-6777ac7f755a";
>     byte_order = le;
>     packet.header := struct {
>         uint32_t magic;
>         uint8_t  uuid[16];
>         uint32_t stream_id;
>         uint64_t stream_instance_id;
>     };
> };
>
> In the above what does stream_instance_id does? In CTF documentation [1] it looks like packet.header can contain three values(magic, uuid, stream_id) then what is stream_instance_id?

This is the ID of the stream itself, whereas `stream_id` is in fact the
ID of the class or type of stream. Many streams (one per CPU, for
example) can share the same stream class ID (`stream_id`), but have
different stream IDs (`stream_instance_id`).

In LTTng, we use the stream ID property to group different stream files
which contain data which belong to the same logical stream, in
particular when you use the trace file rotation feature. It's important
to do that because otherwise you can't know which stream file contains
which stream. There's `cpu_id` in the packet context, but that's not
specified.

When the `stream_instance_id` member does not exist, then, for a CTF
trace on the file system, each stream file implicitly represents a
different stream.

>
> Please attend this ASAP

Was that turnaround time good enough for you?

Phil

>
> Thanks
>
> --
> Ravindra Kumar Meena,
> B. Tech. Computer Science and Engineering,
> Indian Institute of Technology (Indian School of Mines), Dhanbad
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
