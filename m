From: Jesper Derehag <jderehag@hotmail.com>
Subject: Re: [PATCH lttng-ust] Fix: Corrected python version
 assumptions in lttng-gen-tp
Date: Tue, 25 Mar 2014 18:03:53 +0000
Message-ID: <DUB123-W18FF6C4DAEAEC5A2346C92DD650__30881.9286562086$1395770712$gmane$org@phx.gbl>
References: <1395671384-24750-1-git-send-email-jderehag@hotmail.com>,
	<654526496.119.1395756962956.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from dub0-omc2-s13.dub0.hotmail.com ([157.55.1.152])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jderehag@hotmail.com>) id 1WSVhg-0007hN-Cn
	for lttng-dev@lists.lttng.org; Tue, 25 Mar 2014 14:04:06 -0400
In-Reply-To: <654526496.119.1395756962956.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> Date: Tue, 25 Mar 2014 14:16:02 +0000
> From: mathieu.desnoyers@efficios.com
> To: jderehag@hotmail.com
> CC: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] [PATCH lttng-ust] Fix: Corrected python version	=
assumptions in lttng-gen-tp
> =

> ----- Original Message -----
>> From: jderehag@hotmail.com
>> To: lttng-dev@lists.lttng.org
>> Cc: "Jesper Derehag" <jderehag@hotmail.com>
>> Sent: Monday, March 24, 2014 10:29:44 AM
>> Subject: [lttng-dev] [PATCH lttng-ust] Fix: Corrected python version	ass=
umptions in lttng-gen-tp
>> =

>> From: Jesper Derehag <jderehag@hotmail.com>
>> =

>> This modification calls the interpreter through env instead of
>> directly, which should be more portable for those distros which do not
>> install
>> python into /usr/bin/.
>> =

>> Also, since lttng-gen-tp is not python2 compatible, I changed it to stri=
ctly
>> call python3 which is the recommended way.
>> See PEP 394.
>> http://legacy.python.org/dev/peps/pep-0394/
> =

> Hi Jesper,
> =

> I somehow thought that lttng-gen-tp was meant to work with
> Python 2.7 and Python 3. But maybe I'm missing something.
> Where have you seen the dependency of this script on python
> 3 in our docs ?
> =

> Thanks,
> =

> Mathieu

Hmm... The reason for why I changed into python3 was due to that I got synt=
ax error when trying to run it:
-----
./lttng-gen-tp=A0
=A0 File "./lttng-gen-tp", line 100
=A0 =A0 except OSError as msg:
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^
SyntaxError: invalid syntax
------
I *thought* I was running on python2.7 but as it turns out I was not.=A0
When resolving "python" I get python2.7 but when I check the explicit versi=
on laying at /usr/bin/python its actually a 2.4 version so no wonder it was=
 failing.=A0

Checking the PEP for when "except XX as yy" was introduced points to that i=
t was introduced in python 2.6 so entirely my mistake.
Reran it now with the a 2.7 version and it works as intended.

However, I still think you should run it through env as proposed in the pat=
ch and not use the explicit path to python.

If you agree, do you want me to send you another patch removing the "3"?

Otherwise, I apologize for my blunder.

Regards,
Jesper

> =

> =

>> ---
>> tools/lttng-gen-tp | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> =

>> diff --git a/tools/lttng-gen-tp b/tools/lttng-gen-tp
>> index c49e8a5..c7bf295 100755
>> --- a/tools/lttng-gen-tp
>> +++ b/tools/lttng-gen-tp
>> @@ -1,4 +1,4 @@
>> -#!/usr/bin/python
>> +#!/usr/bin/env python3
>> #
>> # Copyright (c) 2012 Yannick Brosseau <yannick.brosseau@gmail.com>
>> #
>> --
>> 1.7.9.5
>> =

>> =

>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> =

> =

> -- =

> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com 		 	   		  =
