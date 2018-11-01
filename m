From: Joel Fernandes <joelaf@google.com>
Subject: Re: [diamon-discuss] [RELEASE] LTTng-modules 2.9.11, 2.10.8,
 2.11.0-rc2 (Linux kernel tracer)
Date: Thu, 1 Nov 2018 16:33:47 -0700
Message-ID: <CAJWu+ooEbjOXgVeq+g4MGEve9PTo7p7UUKjYYHhq-Wz6UbUhfg@mail.gmail.com>
References: <60988959.4070.1541112982406.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <60988959.4070.1541112982406.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, Nov 1, 2018 at 3:56 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Hi,
>
> This is a set of bugfix releases of the LTTng modules kernel tracer.
> It covers the three currently active lttng-modules branches: the
> 2.9 and 2.10 stable branches, as well as the 2.11 branch in release
> candidate cycle.
>
> Those releases add support for kernel 4.19.
>
> One important improvement is to prevent allocation of buffers larger
> than the available memory, which can cause the OOM killer to trigger.
> Even if the OOM killer end up having to trigger, the current OOM kill
> target is set to the current thread while allocating buffers.

This is interesting. Me and Steve were looking at exactly this issue
with the ftrace ring buffer a few months ago. Turns out that even
setting the OOM kill target may not be enough to prevent all OOMs. I
don't remember the reason why not, I'll have to dig out those threads
but that's what the -mm folks said at the time. I did remember vaguely
that I tested it and the kill target doesn't always get killed.. its
possible that something *other* parallel allocation can be victimized
AFAIR, even though the culprit is the kill target.

 - Joel
