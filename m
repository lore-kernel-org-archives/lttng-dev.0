From: ahmadkhorrami <ahmadkhorrami@ut.ac.ir>
Subject: Re: Capturing User-Level Function Calls/Returns
Date: Thu, 16 Jul 2020 02:09:50 +0430
Message-ID: <98de6fe15a816d8f06ba3d5df0f10540@ut.ac.ir>
References: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir>
 <20200715142849.0bfe909a@oasis.local.home>
 <83963025.14828.1594838718290.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <83963025.14828.1594838718290.JavaMail.zimbra@efficios.com>
Sender: linux-trace-users-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-users <linux-trace-users@vger.kernel.org>, lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jeremie.galarneau@efficios.com>, Namhyung Kim <namhyung@kernel.org>, rostedt <rostedt@goodmis.org>, linux-trace-users-owner@vger.kernel.org
List-Id: lttng-dev@lists.lttng.org

Hi Steven and Mathieu,
Firstly, many thanks! This method seems to be the most efficient method. 
But, IIUC, what you suggest requires source code compilation. I need an 
efficient dynamic method that, given the function address, captures its 
occurrence and stores some information from the execution context. Is 
there anything better than Uprobes perhaps with no trap into the kernel? 
Why do we need traps?
Regards.

On 2020-07-15 23:15, Mathieu Desnoyers wrote:

> ----- On Jul 15, 2020, at 2:28 PM, rostedt rostedt@goodmis.org wrote:
> 
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

> I think there's also a users ftrace like utility that Namhyung was
> working on. But I don't know where in the development that is.
> 
> -- Steve
