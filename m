From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH lttng-modules 4/5] fix: mm: move recent_rotated pages
 calculation to shrink_inactive_list() (v5.2)
Date: Tue, 21 May 2019 17:16:02 -0400
Message-ID: <20190521171602.09481e99@gandalf.local.home>
References: <20190521203314.8577-1-mjeanson@efficios.com>
        <20190521203314.8577-4-mjeanson@efficios.com>
        <1045726286.6695.1558472016130.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1045726286.6695.1558472016130.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Michael Jeanson <mjeanson@efficios.com>, lttng-dev <lttng-dev@lists.lttng.org>, Kirill Tkhai <ktkhai@virtuozzo.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

On Tue, 21 May 2019 16:53:36 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> So I recommend we do the following in lttng-modules:
> 
> Rename the field nr_activate0 to nr_activate_anon,
> Rename the field nr_activate1 to nr_activate_file.
> 
> So users can make something out of those tracepoints without digging
> into the kernel source code.
> 
> Even if Steven and Kirill end up choosing to change the name of those
> fields upstream in trace-event, it won't have any impact on lttng-modules.
> 
> It would make sense to change those newly introduced exposed names in the
> upstream kernel as well though.

I'm fine with whatever Kirill decides.

-- Steve
