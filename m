From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [diamon-discuss] [RELEASE] LTTng-modules 2.9.11, 2.10.8,
 2.11.0-rc2 (Linux kernel tracer)
Date: Fri, 22 Mar 2019 09:48:14 -0400
Message-ID: <20190322134814.GB56461@google.com>
References: <60988959.4070.1541112982406.JavaMail.zimbra@efficios.com>
 <CAJWu+ooEbjOXgVeq+g4MGEve9PTo7p7UUKjYYHhq-Wz6UbUhfg@mail.gmail.com>
 <1199524058.2398.1553016874435.JavaMail.zimbra@efficios.com>
 <20190321124122.GA30542@google.com>
 <20190321091356.38a6988d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190321091356.38a6988d@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, diamon-discuss@lists.linuxfoundation.org, lttng-dev <lttng-dev@lists.lttng.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, Mar 21, 2019 at 09:13:56AM -0400, Steven Rostedt wrote:
> On Thu, 21 Mar 2019 08:41:22 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > Also does it also make sense for lttng ring buffer to use the ftrace code for
> > ring buffer, or make the ftrace ring buffer better and have lttng use it? Or
> > is the lttng ring buffer design too radically different?
> 
> We tried in the past and never actually got something that we both
> could agree on. Now I believe the user space tools depend on the way
> each one is, so to change one will break the tools that read it.

I understand :-\

thanks,

 - Joel
