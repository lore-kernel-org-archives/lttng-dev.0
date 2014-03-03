From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [GSoC 2014]
Date: Mon, 3 Mar 2014 13:12:58 -0500
Message-ID: <CA+jJMxtEkhoZGBcwhQw4TcsEPY7Rdsb5gRavpJFMKKTu3o0B5A__22724.6478236795$1393870446$gmane$org@mail.gmail.com>
References: <tencent_6CE862C660BA09B058533BE4@qq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WKXMN-00072T-O6
	for lttng-dev@lists.lttng.org; Mon, 03 Mar 2014 13:13:09 -0500
Received: by mail-qc0-f169.google.com with SMTP id i17so1229065qcy.0
	for <lttng-dev@lists.lttng.org>; Mon, 03 Mar 2014 10:12:58 -0800 (PST)
In-Reply-To: <tencent_6CE862C660BA09B058533BE4@qq.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: zlynus <302590304@qq.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Sun, Mar 2, 2014 at 11:07 AM, zlynus <302590304@qq.com> wrote:
> Hi,
> I'm a graduate student from China. Due to my last experience using System=
Tap
> to trace kernel's submit_bio() function activity in my recent research on
> disk blocks' correlation, I get interested in system trace tool .So I thi=
nk
> contributing  to lttng in GSoC would be a great adventure.
>

Absolutely!

> According to the idea page, the kernel side tracer has no comparable
> filtering mechanism like the one in user-space side however, it is propos=
ed
> that the filtering be implemented in the babeltrace , rather than in kern=
el
> side. Can you please  tell me the reason?
>

We have been looking at kernel-level filtering for quite some time and
are interested in the feature.

The reason we are proposing the implementation of a filtering system
in Babeltrace is to both address this shortcoming and provide a
non-destructive way of filtering events. It would make it easier for
users to search for events in a trace and lower Babeltrace's output
volume to speed-up scripts based on it.

Ideally, we'd have filtering both in Babeltrace and the kernel,
although the latter is out of GSoC's scope.

> Nevertheless, I think implementing a usable and relatively optimized filt=
er
> is a great work worth working on. I have read the man page and tested the
> toolchain. Now I have got a whole picture of it. And in order to get
> familiar with you guys and prove my skills I should try to submit patches=
 to
> this list, right? Beside that I hope hear your discussion on filter
> mechanism.
>

That would be the way to go. Looking forward to your patches!

Thanks,
J=E9r=E9mie

> Best regards,
> Lingyu Zhu
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
