From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: BUG: optimized kprobes illegal instructions in v4.19 stable
 kernels
Date: Mon, 18 Feb 2019 09:55:35 -0500 (EST)
Message-ID: <843587666.153.1550501735273.JavaMail.zimbra@efficios.com>
References: <342740659.2887.1549307721609.JavaMail.zimbra@efficios.com> <CAGXu5jJYbc0xhQGqS6L43o_1tOdWmL=rhRmu_L8qT4-tOheHPw@mail.gmail.com> <20190206134115.baba291e33022a2f6b6ae5f8@kernel.org> <20190218122631.GE30260@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190218122631.GE30260@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Kees Cook <keescook@chromium.org>, William Cohen <wcohen@redhat.com>, stable <stable@vger.kernel.org>, Laura Abbott <labbott@redhat.com>, Russell King <rmk+kernel@armlinux.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, lttng <lttng@reliableembeddedsystems.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- On Feb 18, 2019, at 7:26 AM, Greg Kroah-Hartman gregkh@linuxfoundation.org wrote:

> On Wed, Feb 06, 2019 at 01:41:15PM +0900, Masami Hiramatsu wrote:
>> On Tue, 5 Feb 2019 15:06:10 +0000
>> Kees Cook <keescook@chromium.org> wrote:
>> 
>> > On Mon, Feb 4, 2019 at 7:15 PM Mathieu Desnoyers
>> > <mathieu.desnoyers@efficios.com> wrote:
>> > >
>> > > Hi,
>> > >
>> > > I notice this commit as a possible culprit of the illegal instructions my lttng
>> > > users are noticing on arm32 when using kprobes on a v4.19.13 Linux kernel
>> > > in a Yocto environment [1]. They were able to reproduce the issue with perf
>> > > as well.
>> > >
>> > > commit e46daee53bb50bde38805f1823a182979724c229
>> > > Author: Kees Cook <keescook@chromium.org>
>> > > Date:   Tue Oct 30 22:12:56 2018 +0100
>> > >
>> > >     ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE
>> > >
>> > > I *think* the intent there was to do
>> > >
>> > > -       memcpy(code, &optprobe_template_entry,
>> > > +       memcpy(code, (unsigned long *)&optprobe_template_entry,
>> > >
>> > > But if you look at the commit, the "&" seems to have been stripped away,
>> > > which happens to change the behavior significantly.
>> > 
>> > Yeah, this was a typo on my part. :(
>> 
>> Ah, I thought it had been fixed as same as x86.
>> On x86, all optprobe_template_* are defined as kprobe_opcode_t [],
>> but on arm, it still be kprobe_opcode_t.
>> 
>> Hmm, but I think we should use kprobe_opcode_t [] or char[] as asm/sections.h
>> does.
>> OK, I'll prepare for the change.
> 
> Did this ever get fixed in Linus's tree?  If so, what is the git commit
> id, I can't seem to find anything...

It seems to still be in the arm patch tracking system:

https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8834/1

If I understand its status correctly, it is applied to the arm tree, but
perhaps it has not been pulled by Linus yet ? The code is still broken
in Linus' master.

It would be important to get this arm kprobes fix upstream before 5.0
final.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
