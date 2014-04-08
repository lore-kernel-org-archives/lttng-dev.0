From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PATCH 1/1] Disable liblttng-ust-dl if dlinfo is
 not available in C library.
Date: Tue, 8 Apr 2014 13:03:09 -0400
Message-ID: <CAFXXi0kAZJDD7ygqs493ZPvJHMpkeuMTDvxHqMg9B722pJHHxQ__4676.58379716358$1396976699$gmane$org@mail.gmail.com>
References: <1396818161-20204-1-git-send-email-romain.naour@openwide.fr>
 <794709247.8287.1396903345152.JavaMail.zimbra@efficios.com>
 <53430E92.9060401@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1WXZR3-0001cW-3w
 for lttng-dev@lists.lttng.org; Tue, 08 Apr 2014 13:03:51 -0400
Received: by mail-ig0-f176.google.com with SMTP id uy17so5329389igb.15
 for <lttng-dev@lists.lttng.org>; Tue, 08 Apr 2014 10:03:39 -0700 (PDT)
In-Reply-To: <53430E92.9060401@openwide.fr>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Romain Naour <romain.naour@openwide.fr>
Cc: buildroot <buildroot@busybox.net>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Yann E. MORIN" <yann.morin.1998@free.fr>
List-Id: lttng-dev@lists.lttng.org

Hi Romain,

It seems like with that commit, dlinfo is not found even on a glibc
based system, where it is present.

See https://bugs.lttng.org/issues/778

Do you have a suggestion to fix that ?

Simon

On 7 April 2014 16:46, Romain Naour <romain.naour@openwide.fr> wrote:
> Hi Mathieu,
>
> Le 07/04/2014 22:42, Mathieu Desnoyers a =E9crit :
>
>> Merged into master and stable-2.4, thanks!
>>
>> Mathieu
>
> You're welcome.
>
> Best regards,
> Romain Naour
>
>
>>
>> ----- Original Message -----
>>>
>>> From: "Romain Naour" <romain.naour@openwide.fr>
>>> To: lttng-dev@lists.lttng.org
>>> Cc: "Romain Naour" <romain.naour@openwide.fr>
>>> Sent: Sunday, April 6, 2014 5:02:41 PM
>>> Subject: [lttng-dev] [PATCH 1/1] Disable liblttng-ust-dl if dlinfo is n=
ot
>>> available in C library.
>>>
>>> According to uClibc commit [1], dlinfo is not available.
>>> To be able to use LTTng UST with uClibc, we need to disable
>>> the Dynamic Linker Tracing functionality [2].
>>>
>>> [1]
>>>
>>> http://git.uclibc.org/uClibc/commit/?id=3Df3c9dc499c5c787ddd8c4320f2d44=
d2ae6e40c22
>>> [2] http://lists.lttng.org/pipermail/lttng-dev/2014-February/022423.html
>>>
>>> Signed-off-by: Romain Naour <romain.naour@openwide.fr>
>>> ---
>>>   Makefile.am  | 5 ++++-
>>>   configure.ac | 3 +++
>>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Makefile.am b/Makefile.am
>>> index b79d2dd..c907ff1 100644
>>> --- a/Makefile.am
>>> +++ b/Makefile.am
>>> @@ -4,11 +4,14 @@ SUBDIRS =3D . include snprintf libringbuffer
>>> liblttng-ust-comm \
>>>                 liblttng-ust \
>>>                 liblttng-ust-ctl \
>>>                 liblttng-ust-fork \
>>> -               liblttng-ust-dl \
>>>                 liblttng-ust-libc-wrapper \
>>>                 liblttng-ust-cyg-profile \
>>>                 tools
>>>   +if HAVE_DLINFO
>>> +SUBDIRS +=3D liblttng-ust-dl
>>> +endif
>>> +
>>>   if BUILD_JNI_INTERFACE
>>>   SUBDIRS +=3D liblttng-ust-java liblttng-ust-jul
>>>   endif
>>> diff --git a/configure.ac b/configure.ac
>>> index b04d4e3..de6300e 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -146,6 +146,9 @@ AC_C_INLINE
>>>   AC_FUNC_MALLOC
>>>   AC_CHECK_FUNCS([gettimeofday munmap socket strerror strtol sched_getc=
pu
>>>   sysconf])
>>>   +AC_CHECK_FUNCS([dlinfo])
>>> +AM_CONDITIONAL([HAVE_DLINFO], [test "${ac_cv_func_dlinfo}" =3D "yes"])
>>> +
>>>   CFLAGS=3D"-Wall $CFLAGS"
>>>     # URCU
>>> --
>>> 1.9.0
>>>
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
