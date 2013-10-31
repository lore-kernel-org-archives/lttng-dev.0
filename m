From: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: lttng-modules build failure for 3.12-rc6
Date: Thu, 31 Oct 2013 12:46:32 -0200
Message-ID: <CAP9ODKokvCH16Qwq6ftBvWLpRHo+=T_1SggJa-3GOcy7aE2yeA__34295.1501989321$1383230855$gmane$org@mail.gmail.com>
References: <CAP9ODKoqhtXmS94ZtV8hNPs=kUXWLU9msN+GR7Zf9DQrdQUmSg@mail.gmail.com>
	<1567008261.54443.1383229577346.JavaMail.zimbra@efficios.com>
	<CAP9ODKrLtSuFJUKryO9RJ5BHri9d7gL+5vZqOAw-o_OZ7cZn6A@mail.gmail.com>
	<544819642.54467.1383230288963.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <otavio.salvador@gmail.com>) id 1VbtWA-0001Yy-7I
	for lttng-dev@lists.lttng.org; Thu, 31 Oct 2013 10:46:43 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so3157562oag.17
	for <lttng-dev@lists.lttng.org>; Thu, 31 Oct 2013 07:46:32 -0700 (PDT)
In-Reply-To: <544819642.54467.1383230288963.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, Oct 31, 2013 at 12:38 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> ----- Original Message -----
>> From: "Otavio Salvador" <otavio@ossystems.com.br>
>> To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
>> Cc: "lttng-dev" <lttng-dev@lists.lttng.org>
>> Sent: Thursday, October 31, 2013 10:30:24 AM
>> Subject: Re: lttng-modules build failure for 3.12-rc6
>>
>> On Thu, Oct 31, 2013 at 12:26 PM, Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>> > ----- Original Message -----
>> >> From: "Otavio Salvador" <otavio@ossystems.com.br>
>> >> To: "lttng-dev" <lttng-dev@lists.lttng.org>
>> >> Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
>> >> Sent: Monday, October 28, 2013 9:47:01 AM
>> >> Subject: lttng-modules build failure for 3.12-rc6
>> >>
>> >> Hello,
>> >>
>> >> Part of build issues are now fixed in master (thanks Mathieu for
>> >> applying the need changes) but we're still not good:
>> >
>> > All fixed by this string of commits in lttng-modules master:
>> ...
>> >
>> > Thanks for reporting these issues. 3.12 seems to build fine now.
>>
>> Great; can you backport those to stable-2.3? I'd like to send the
>> update for Yocto including these changes and fix it for us directly
>> there.
>
> Strictly speaking, supporting a new kernel can be seen as a new feature. stable-2.3 was released for 3.11. Moreover, 3.12 kernel is still in rc stage, so things can still change (and even be reverted, this has happened in the past).
>
> Unfortunately, we don't add features in the stable branches, only bug fixes. But keep in mind that 2.4 should come within the coming weeks.

Humm in this case stable-2.3 should had a #warning saying it support
kernels up to 3.11 only. As it does not state it somewhere it seems
like a fix for me.

I will end doing the backport in  this case, but it is something which
could be fixed for 2.4 than and include such warning.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
