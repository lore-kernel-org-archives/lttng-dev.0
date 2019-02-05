From: Kees Cook <keescook@chromium.org>
Subject: Re: BUG: optimized kprobes illegal instructions in v4.19 stable kernels
Date: Tue, 5 Feb 2019 15:06:10 +0000
Message-ID: <CAGXu5jJYbc0xhQGqS6L43o_1tOdWmL=rhRmu_L8qT4-tOheHPw@mail.gmail.com>
References: <342740659.2887.1549307721609.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <342740659.2887.1549307721609.JavaMail.zimbra@efficios.com>
Sender: stable-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: William Cohen <wcohen@redhat.com>, "# 3.4.x" <stable@vger.kernel.org>, Laura Abbott <labbott@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, linux-kernel <linux-kernel@vger.kernel.org>, lttng@reliableembeddedsystems.com, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Mon, Feb 4, 2019 at 7:15 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Hi,
>
> I notice this commit as a possible culprit of the illegal instructions my lttng
> users are noticing on arm32 when using kprobes on a v4.19.13 Linux kernel
> in a Yocto environment [1]. They were able to reproduce the issue with perf
> as well.
>
> commit e46daee53bb50bde38805f1823a182979724c229
> Author: Kees Cook <keescook@chromium.org>
> Date:   Tue Oct 30 22:12:56 2018 +0100
>
>     ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE
>
> I *think* the intent there was to do
>
> -       memcpy(code, &optprobe_template_entry,
> +       memcpy(code, (unsigned long *)&optprobe_template_entry,
>
> But if you look at the commit, the "&" seems to have been stripped away,
> which happens to change the behavior significantly.

Yeah, this was a typo on my part. :(

> Has this change ever been runtime-tested ?

I thought I had, given the details from the original bug report, but
clearly it didn't exercise it.

Thanks for fixing this!

-Kees

>
> It has been backported to:
> - 4.19 stable as commit 3fe0c68aea21
> - 4.14 stable as commit f9e0bc710347
>
> Thanks,
>
> Mathieu
>
> [1] https://bugs.lttng.org/issues/1174
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com



-- 
Kees Cook
