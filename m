From: Zifei Tong <soariez@gmail.com>
Subject: Re: [RFC] Dynamic instrumentation support in UST
Date: Mon, 29 Jul 2013 21:05:57 +0800
Message-ID: <CAJ7wx-E2_XcU3uJgS=Mkfiyo6Z5-MaJk+Cna2e2KAAag=fYHpw__23676.5889487744$1375103272$gmane$org@mail.gmail.com>
References: <CAJ7wx-FipDw6XVvYsugMhOrSEJVz5vASaJQnjX9HM5-ahu24bA@mail.gmail.com>
	<CAFXXi0kJaQwrcg81P159W9EPe6M+9hesNFj-haySyByncqF+fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1V3n9v-0000q7-Bu
	for lttng-dev@lists.lttng.org; Mon, 29 Jul 2013 09:06:51 -0400
Received: by mail-ve0-f175.google.com with SMTP id da11so2832161veb.6
	for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2013 06:06:37 -0700 (PDT)
In-Reply-To: <CAFXXi0kJaQwrcg81P159W9EPe6M+9hesNFj-haySyByncqF+fw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Sat, Jul 27, 2013 at 1:40 AM, Simon Marchi <simon.marchi@polymtl.ca> wrote:
> Hi Zifei,
>
> That looks great! Questions and comments below.
>
> On 26 July 2013 11:40, Zifei Tong <soariez@gmail.com> wrote:

Thanks.

>
> What is the difference if I do
>   --function foo
> vs
>   --probe foo
> ?
>

Good point, i've updated the RFC:

You can also enable a tracepoint at the entry/return of a given function:

     lttng enable-event NAME -u --pid PID
         --function (addr | symbol | symbol+offset)
                             Dynamic UST function entry/return probe.
                              Addr and offset can be octal (0NNN...),
                              decimal (NNN...) or hexadecimal (0xNNN...)

This will place a bare probe at the entry and return point of certain function.

In this way, `lttng enable-event -k --function` and `lttng
enable-event -u --function` will behave similar.

This could be implemented using dyninst straightforwardly (with
BPatch_entry, BPatch_exit), or somehow find a way to warp the
function.

>
> Does it make sense to put collected variable values in the context? I
> would instinctively put them as event fields. Backtrace and registers
> are probably more of a context though. Either way, it will require the
> use of per-event context. I don't think that this feature has been
> very much tested in the CTF parsers (looking at the ctf testsuite), so
> it will be a good test :)
>

I cannot find a more relevant existing command. I am thinking if it is
possible to reuse the add-context
command but put these data (registers, memory values) as event fields instead.

>
> You have to think about instructions that act relatively to the
> current ip. These have to be adjusted to give the correct result. See:
> https://github.com/MentorEmbedded/Debug-Agent-Library/blob/master/x86-64-linux-backend.c#L239
>

Yes, you are right. This is just kind of pseudo code to demonstrate
the concept. I'll take care when implementing it [1].

[1]: https://github.com/5kg/lttng-gsoc/blob/master/kaji/kaji.c#L134

Thanks,
Zifei Tong
