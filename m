From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Capturing User-Level Function Calls/Returns
Date: Wed, 15 Jul 2020 14:45:18 -0400 (EDT)
Message-ID: <83963025.14828.1594838718290.JavaMail.zimbra@efficios.com>
References: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir> <20200715142849.0bfe909a@oasis.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <20200715142849.0bfe909a@oasis.local.home>
Sender: linux-trace-users-owner@vger.kernel.org
To: ahmadkhorrami <ahmadkhorrami@ut.ac.ir>
Cc: linux-trace-users <linux-trace-users@vger.kernel.org>, lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jeremie.galarneau@efficios.com>, Namhyung Kim <namhyung@kernel.org>, rostedt <rostedt@goodmis.org>
List-Id: lttng-dev@lists.lttng.org

----- On Jul 15, 2020, at 2:28 PM, rostedt rostedt@goodmis.org wrote:

> On Wed, 15 Jul 2020 20:37:16 +0430
> ahmadkhorrami <ahmadkhorrami@ut.ac.ir> wrote:
> 
>> Hi,
>> What is the most efficient way to capture occurrence of a function
>> call/return of a binary program in userspace?
>> It seems the answer is Uprobes. 1) Am I right?
>> But Uprobes use "int" instruction which leads to a switch into kernel
>> mode. 2) Wouldn't it be better to avoid this transition?
>> I'm looking forward to your reply and will be happy to read your
>> opinions.
>> Regards.
> 
> 
> Hi, I believe LTTng has utilities that can help you trace user space
> programs.

Indeed, it is documented here:

https://lttng.org/docs/#doc-liblttng-ust-cyg-profile

If your program is generating function entry/exit at a very
high rate (which goes beyond your available I/O throughput and
lasts longer than the memory you have available for ring buffers),
you will also probably want to use the "blocking-timeout" option
documented at:

https://lttng.org/docs/#doc-enabling-disabling-channels

Thanks,

Mathieu

> 
> I think there's also a users ftrace like utility that Namhyung was
> working on. But I don't know where in the development that is.
> 
> -- Steve

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
