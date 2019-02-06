From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: BUG: optimized kprobes illegal instructions in v4.19 stable
 kernels
Date: Wed, 6 Feb 2019 13:41:15 +0900
Message-ID: <20190206134115.baba291e33022a2f6b6ae5f8@kernel.org>
References: <342740659.2887.1549307721609.JavaMail.zimbra@efficios.com>
        <CAGXu5jJYbc0xhQGqS6L43o_1tOdWmL=rhRmu_L8qT4-tOheHPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGXu5jJYbc0xhQGqS6L43o_1tOdWmL=rhRmu_L8qT4-tOheHPw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, William Cohen <wcohen@redhat.com>, "# 3.4.x" <stable@vger.kernel.org>, Laura Abbott <labbott@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, lttng@reliableembeddedsystems.com, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Tue, 5 Feb 2019 15:06:10 +0000
Kees Cook <keescook@chromium.org> wrote:

> On Mon, Feb 4, 2019 at 7:15 PM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > Hi,
> >
> > I notice this commit as a possible culprit of the illegal instructions my lttng
> > users are noticing on arm32 when using kprobes on a v4.19.13 Linux kernel
> > in a Yocto environment [1]. They were able to reproduce the issue with perf
> > as well.
> >
> > commit e46daee53bb50bde38805f1823a182979724c229
> > Author: Kees Cook <keescook@chromium.org>
> > Date:   Tue Oct 30 22:12:56 2018 +0100
> >
> >     ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE
> >
> > I *think* the intent there was to do
> >
> > -       memcpy(code, &optprobe_template_entry,
> > +       memcpy(code, (unsigned long *)&optprobe_template_entry,
> >
> > But if you look at the commit, the "&" seems to have been stripped away,
> > which happens to change the behavior significantly.
> 
> Yeah, this was a typo on my part. :(

Ah, I thought it had been fixed as same as x86.
On x86, all optprobe_template_* are defined as kprobe_opcode_t [],
but on arm, it still be kprobe_opcode_t.

Hmm, but I think we should use kprobe_opcode_t [] or char[] as asm/sections.h does.
OK, I'll prepare for the change.

Thank you,


> 
> > Has this change ever been runtime-tested ?
> 
> I thought I had, given the details from the original bug report, but
> clearly it didn't exercise it.
> 
> Thanks for fixing this!
> 
> -Kees
> 
> >
> > It has been backported to:
> > - 4.19 stable as commit 3fe0c68aea21
> > - 4.14 stable as commit f9e0bc710347
> >
> > Thanks,
> >
> > Mathieu
> >
> > [1] https://bugs.lttng.org/issues/1174
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> 
> 
> 
> -- 
> Kees Cook


-- 
Masami Hiramatsu <mhiramat@kernel.org>
