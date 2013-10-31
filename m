From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: lttng-modules build failure for 3.12-rc6
Date: Thu, 31 Oct 2013 18:05:20 +0000 (UTC)
Message-ID: <1328648078.54590.1383242720354.JavaMail.zimbra__36465.5005898841$1383242784$gmane$org@efficios.com>
References: <CAP9ODKoqhtXmS94ZtV8hNPs=kUXWLU9msN+GR7Zf9DQrdQUmSg@mail.gmail.com>
	<1567008261.54443.1383229577346.JavaMail.zimbra@efficios.com>
	<CAP9ODKrLtSuFJUKryO9RJ5BHri9d7gL+5vZqOAw-o_OZ7cZn6A@mail.gmail.com>
	<544819642.54467.1383230288963.JavaMail.zimbra@efficios.com>
	<CAP9ODKokvCH16Qwq6ftBvWLpRHo+=T_1SggJa-3GOcy7aE2yeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1VbwcV-000136-VS
	for lttng-dev@lists.lttng.org; Thu, 31 Oct 2013 14:05:30 -0400
In-Reply-To: <CAP9ODKokvCH16Qwq6ftBvWLpRHo+=T_1SggJa-3GOcy7aE2yeA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Otavio Salvador <otavio@ossystems.com.br>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> From: "Otavio Salvador" <otavio@ossystems.com.br>
> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> Cc: "lttng-dev" <lttng-dev@lists.lttng.org>
> Sent: Thursday, October 31, 2013 10:46:32 AM
> Subject: Re: lttng-modules build failure for 3.12-rc6
> 
> On Thu, Oct 31, 2013 at 12:38 PM, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> > ----- Original Message -----
> >> From: "Otavio Salvador" <otavio@ossystems.com.br>
> >> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> >> Cc: "lttng-dev" <lttng-dev@lists.lttng.org>
> >> Sent: Thursday, October 31, 2013 10:30:24 AM
> >> Subject: Re: lttng-modules build failure for 3.12-rc6
> >>
> >> On Thu, Oct 31, 2013 at 12:26 PM, Mathieu Desnoyers
> >> <mathieu.desnoyers@efficios.com> wrote:
> >> > ----- Original Message -----
> >> >> From: "Otavio Salvador" <otavio@ossystems.com.br>
> >> >> To: "lttng-dev" <lttng-dev@lists.lttng.org>
> >> >> Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
> >> >> Sent: Monday, October 28, 2013 9:47:01 AM
> >> >> Subject: lttng-modules build failure for 3.12-rc6
> >> >>
> >> >> Hello,
> >> >>
> >> >> Part of build issues are now fixed in master (thanks Mathieu for
> >> >> applying the need changes) but we're still not good:
> >> >
> >> > All fixed by this string of commits in lttng-modules master:
> >> ...
> >> >
> >> > Thanks for reporting these issues. 3.12 seems to build fine now.
> >>
> >> Great; can you backport those to stable-2.3? I'd like to send the
> >> update for Yocto including these changes and fix it for us directly
> >> there.
> >
> > Strictly speaking, supporting a new kernel can be seen as a new feature.
> > stable-2.3 was released for 3.11. Moreover, 3.12 kernel is still in rc
> > stage, so things can still change (and even be reverted, this has happened
> > in the past).
> >
> > Unfortunately, we don't add features in the stable branches, only bug
> > fixes. But keep in mind that 2.4 should come within the coming weeks.
> 
> Humm in this case stable-2.3 should had a #warning saying it support
> kernels up to 3.11 only. As it does not state it somewhere it seems
> like a fix for me.
> 
> I will end doing the backport in  this case, but it is something which
> could be fixed for 2.4 than and include such warning.

I just discussed this with David and Julien, and here is what we came up with:

- when a final kernel release comes up (e.g. 3.12), it makes sense to add support for it into a stable release if the modifications are small,
- however, it does not make sense to add support for a release candidate Linux kernel, since those are known to change a lot during the RC cycle, (chasing a moving target is never fun)

Therefore, I'd be open to cherry-pick the master commits into stable-2.3 when 3.12 final comes out. I don't promise I'll remember to do so, so a gentle "ping" when 3.12 final comes out to remind me which commit ID I should cherry-pick from master into stable-2.3 would be welcome,

Thanks!

Mathieu

> 
> --
> Otavio Salvador                             O.S. Systems
> http://www.ossystems.com.br        http://code.ossystems.com.br
> Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
