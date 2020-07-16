From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: Capturing User-Level Function Calls/Returns
Date: Thu, 16 Jul 2020 10:04:15 +0900
Message-ID: <CAM9d7chE3WQm2e4EA4i09Q1hOaGt2hrPHoF2d0tjqhciPceB9g@mail.gmail.com>
References: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir> <20200715142849.0bfe909a@oasis.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20200715142849.0bfe909a@oasis.local.home>
Sender: linux-trace-users-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: ahmadkhorrami <ahmadkhorrami@ut.ac.ir>, Linux-trace Users <linux-trace-users@vger.kernel.org>, lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Hi all,

On Thu, Jul 16, 2020 at 3:28 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 15 Jul 2020 20:37:16 +0430
> ahmadkhorrami <ahmadkhorrami@ut.ac.ir> wrote:
>
> > Hi,
> > What is the most efficient way to capture occurrence of a function
> > call/return of a binary program in userspace?
> > It seems the answer is Uprobes. 1) Am I right?
> > But Uprobes use "int" instruction which leads to a switch into kernel
> > mode. 2) Wouldn't it be better to avoid this transition?
> > I'm looking forward to your reply and will be happy to read your
> > opinions.
> > Regards.
>
>
> Hi, I believe LTTng has utilities that can help you trace user space
> programs.
>
> I think there's also a users ftrace like utility that Namhyung was
> working on. But I don't know where in the development that is.

It's in https://github.com/namhyung/uftrace

Basically it also requires recompilation to add mcount calls for each function.
But it now also supports dynamic tracing without any recompilation.. :)
It's still experimental and has some limitation, but the idea is to copy
first 5 bytes (on x86_64) somewhere and replace it to a call instruction.

Thanks
Namhyung
