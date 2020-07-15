From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Capturing User-Level Function Calls/Returns
Date: Wed, 15 Jul 2020 14:28:49 -0400
Message-ID: <20200715142849.0bfe909a@oasis.local.home>
References: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <e9c7400ff0075f3beba2863c4432a905@ut.ac.ir>
Sender: linux-trace-users-owner@vger.kernel.org
To: ahmadkhorrami <ahmadkhorrami@ut.ac.ir>
Cc: Linux-trace Users <linux-trace-users@vger.kernel.org>, lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, =?UTF-8?B?SsOpcsOpbWll?= Galarneau <jeremie.galarneau@efficios.com>, Namhyung Kim <namhyung@kernel.org>
List-Id: lttng-dev@lists.lttng.org

On Wed, 15 Jul 2020 20:37:16 +0430
ahmadkhorrami <ahmadkhorrami@ut.ac.ir> wrote:

> Hi,
> What is the most efficient way to capture occurrence of a function 
> call/return of a binary program in userspace?
> It seems the answer is Uprobes. 1) Am I right?
> But Uprobes use "int" instruction which leads to a switch into kernel 
> mode. 2) Wouldn't it be better to avoid this transition?
> I'm looking forward to your reply and will be happy to read your 
> opinions.
> Regards.


Hi, I believe LTTng has utilities that can help you trace user space
programs.

I think there's also a users ftrace like utility that Namhyung was
working on. But I don't know where in the development that is.

-- Steve
