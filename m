From: Otavio Salvador <otavio@ossystems.com.br>
Subject: Re: lttng-modules build failure for 3.12-rc6
Date: Thu, 31 Oct 2013 12:30:24 -0200
Message-ID: <CAP9ODKrLtSuFJUKryO9RJ5BHri9d7gL+5vZqOAw-o_OZ7cZn6A__7048.2877818451$1383229888$gmane$org@mail.gmail.com>
References: <CAP9ODKoqhtXmS94ZtV8hNPs=kUXWLU9msN+GR7Zf9DQrdQUmSg@mail.gmail.com>
	<1567008261.54443.1383229577346.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <otavio.salvador@gmail.com>) id 1VbtGZ-0007vO-S6
	for lttng-dev@lists.lttng.org; Thu, 31 Oct 2013 10:30:36 -0400
Received: by mail-ob0-f181.google.com with SMTP id wp4so3124222obc.12
	for <lttng-dev@lists.lttng.org>; Thu, 31 Oct 2013 07:30:24 -0700 (PDT)
In-Reply-To: <1567008261.54443.1383229577346.JavaMail.zimbra@efficios.com>
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

On Thu, Oct 31, 2013 at 12:26 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> ----- Original Message -----
>> From: "Otavio Salvador" <otavio@ossystems.com.br>
>> To: "lttng-dev" <lttng-dev@lists.lttng.org>
>> Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
>> Sent: Monday, October 28, 2013 9:47:01 AM
>> Subject: lttng-modules build failure for 3.12-rc6
>>
>> Hello,
>>
>> Part of build issues are now fixed in master (thanks Mathieu for
>> applying the need changes) but we're still not good:
>
> All fixed by this string of commits in lttng-modules master:
...
>
> Thanks for reporting these issues. 3.12 seems to build fine now.

Great; can you backport those to stable-2.3? I'd like to send the
update for Yocto including these changes and fix it for us directly
there.

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9981-7854            Mobile: +1 (347) 903-9750
