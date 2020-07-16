From: ahmadkhorrami <ahmadkhorrami@ut.ac.ir>
Subject: Re: Capturing User-Level Function Calls/Returns
Date: Thu, 16 Jul 2020 20:37:13 +0430
Message-ID: <42d8f4d107d2117fb246b8ff1890e301@ut.ac.ir>
References: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir>
 <20200715142849.0bfe909a@oasis.local.home>
 <CAM9d7chE3WQm2e4EA4i09Q1hOaGt2hrPHoF2d0tjqhciPceB9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <CAM9d7chE3WQm2e4EA4i09Q1hOaGt2hrPHoF2d0tjqhciPceB9g@mail.gmail.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Linux-trace Users <linux-trace-users@vger.kernel.org>, lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, =?UTF-8?Q?J=C3=A9r=C3=A9mi?= =?UTF-8?Q?e_Galarneau?= <jeremie.galarneau@efficios.com>, linux-trace-users-owner@vger.kernel.org
List-Id: lttng-dev@lists.lttng.org

Hi Namhyung,
This seems really interesting and is what I am looking for. Can it 
capture all function entries/exits? I mean does it fully handle variable 
instruction sizes in dynamic mode?
In any case, thanks! and I hope that it becomes stable as soon as 
possible, so that everyone can use it.
Regards.

On 2020-07-16 05:34, Namhyung Kim wrote:

> Hi all,
> 
> On Thu, Jul 16, 2020 at 3:28 AM Steven Rostedt <rostedt@goodmis.org> 
> wrote:
> On Wed, 15 Jul 2020 20:37:16 +0430
> ahmadkhorrami <ahmadkhorrami@ut.ac.ir> wrote:
> 
> Hi,
> What is the most efficient way to capture occurrence of a function
> call/return of a binary program in userspace?
> It seems the answer is Uprobes. 1) Am I right?
> But Uprobes use "int" instruction which leads to a switch into kernel
> mode. 2) Wouldn't it be better to avoid this transition?
> I'm looking forward to your reply and will be happy to read your
> opinions.
> Regards.
> 
> Hi, I believe LTTng has utilities that can help you trace user space
> programs.
> 
> I think there's also a users ftrace like utility that Namhyung was
> working on. But I don't know where in the development that is.

It's in https://github.com/namhyung/uftrace

Basically it also requires recompilation to add mcount calls for each 
function.
But it now also supports dynamic tracing without any recompilation.. :)
It's still experimental and has some limitation, but the idea is to copy
first 5 bytes (on x86_64) somewhere and replace it to a call 
instruction.

Thanks
Namhyung
