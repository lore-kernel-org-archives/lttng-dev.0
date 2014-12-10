From: Yan Grange <ygrange@gmail.com>
Subject: Re: Errors compiling converted tp file
Date: Wed, 10 Dec 2014 16:16:06 +0100
Message-ID: <3EBBABA4-87EC-4D36-9194-CDA28C8961CB__14305.3934014917$1418225872$gmane$org@gmail.com>
References: <23F748C6-C9DB-43D4-9355-F5817976B70F@gmail.com>
 <CA+jJMxscuLaU3dLahuFqhcz_CAdcCny4TXL=t=RxUg8ixkbFQw@mail.gmail.com>
 <2D967E0A-F79D-4650-B455-6F92097F1811@gmail.com>
 <CA+jJMxuMXbuwEfJTD_E5U6AdjSNyrv6gkA51mXrHZ6KR7W9M8Q@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ygrange@gmail.com>) id 1Xyizt-0002tQ-NB
 for lttng-dev@lists.lttng.org; Wed, 10 Dec 2014 10:16:22 -0500
Received: by mail-wg0-f50.google.com with SMTP id a1so3880686wgh.23
 for <lttng-dev@lists.lttng.org>; Wed, 10 Dec 2014 07:16:08 -0800 (PST)
In-Reply-To: <CA+jJMxuMXbuwEfJTD_E5U6AdjSNyrv6gkA51mXrHZ6KR7W9M8Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: =?windows-1252?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

Thanks for that.  I have asked our sysadmin to install a newer version via =
this method. Even though he gets several severe-lloking errors in this proc=
ess

$ apt-get install liblttng-ust-dev

Building initial module for 3.2.0-61-generic
Errors were encountered while processing:
 lttng-modules-dkms
 Error!  Build of lttng-probe-printk.ko failed for: 3.2.0-61-generic (x86_6=
4)

In the make log, we find the following three lines:

/var/lib/dkms/lttng-modules/2.5.x+stable+bzr633+pack21+201412020446~ubuntu1=
2.04.1/build/probes/Makefile:30: File /usr/src/linux-headers-3.2.0-61-gener=
ic/virt/kvm/iodev.h not found. Probe "kvm" x86-specific is disabled. Use fu=
ll kernel source tree to enable it.
/var/lib/dkms/lttng-modules/2.5.x+stable+bzr633+pack21+201412020446~ubuntu1=
2.04.1/build/probes/Makefile:142: Files /usr/src/linux-headers-3.2.0-61-gen=
eric/fs/btrfs/*.h not found. Probe "btrfs" is disabled. Use full kernel sou=
rce tree to enable it.
/var/lib/dkms/lttng-modules/2.5.x+stable+bzr633+pack21+201412020446~ubuntu1=
2.04.1/build/probes/Makefile:158: Files /usr/src/linux-headers-3.2.0-61-gen=
eric/fs/ext4/*.h not found. Probe "ext4" is disabled. Use full kernel sourc=
e tree to enable it.

The full kernel source tree is already installed. =


However it actually works to create a header file from a tp file and compil=
e (and run) the code. However I now get in trouble when executing:

$ lttng list --userspace
Error: Unable to list UST events: Undefined command
Error: Command error

So I guess something still went somewhat wrong but I can't really see what.

Cheers

Yan Grange

On 9 dec. 2014, at 21:26, J=E9r=E9mie Galarneau <jeremie.galarneau@efficios=
.com> wrote:

> On Tue, Dec 9, 2014 at 2:02 PM, Yan Grange <ygrange@gmail.com> wrote:
>> Hi,
>> =

>> It reports:
>> lttng version 2.0.1 - Annedd'ale
>> =

> =

> Hmm... unfortunately, we don't support 2.0 anymore. Would you mind
> testing with a more recent version?
> =

> You can use the LTTng PPA to install the 2.5 version following this
> documentation:
> https://lttng.org/docs/#doc-ubuntu-ppa
> =

> Let me know how that works out.
> =

> J=E9r=E9mie
> =

>> Regards,
>> =

>> Yan
>> --
>> Y. Grange
>> =

>>> Op 9 dec. 2014 om 19:42 heeft J=E9r=E9mie Galarneau <jeremie.galarneau@=
efficios.com> het volgende geschreven:
>>> =

>>>> On Tue, Dec 9, 2014 at 8:48 AM, Yan Grange <ygrange@gmail.com> wrote:
>>>> Hi,
>>>> =

>>>> I try to reproduce the examle of tracing an application in user space =
as present in the documentation. The conversion of the .tp file, which is a=
 copy paste of the example in the docs provides me with many errors=85
>>>> =

>>>> I am using gcc 4.6.3 on Ubuntu 12.04 (LTS). I have the following lttng=
-packages installed:
>>>> liblttng-ctl-dev
>>>> liblttng-ctl0
>>>> liblttng-ust-dev
>>>> liblttng-ust0
>>>> lttng-modules-dkms
>>>> lttng-tools
>>> =

>>> Hi,
>>> =

>>> Which version of lttng are you using?
>>> =

>>> J=E9r=E9mie
>>> =

>>>> Am I doing something wrong or is there some issue with my environment?
>>>> =

>>>> =

>>>> The following errors occur:
>>>> =

>>>> ~/lttng$ lttng-gen-tp hello-tp.tp
>>>> =

>>>> In file included from hello-tp.c:7:0:
>>>> hello-tp.h:13:20: error: missing ')' after "defined"
>>>> hello-tp.h:13:21: error: missing binary operator before token "TP_H"
>>>> In file included from /usr/include/lttng/tracepoint-event.h:39:0,
>>>>                from hello-tp.h:33,
>>>>                from hello-tp.c:7:
>>>> ././hello-tp.h:13:20: error: missing ')' after "defined"
>>>> ././hello-tp.h:13:21: error: missing binary operator before token "TP_=
H"
>>>> In file included from /usr/include/lttng/tracepoint-event.h:41:0,
>>>>                from hello-tp.h:33,
>>>>                from hello-tp.c:7:
>>>> /usr/include/lttng/ust-tracepoint-event.h:103:6: error: =91_TP_COMBINE=
_TOKENS=92 declared as function returning a function
>>>> /usr/include/lttng/ust-tracepoint-event.h:116:6: error: =91_TP_COMBINE=
_TOKENS=92 declared as function returning a function
>>>> /usr/include/lttng/ust-tracepoint-event.h:116:6: error: redefinition o=
f =91_TP_COMBINE_TOKENS=92
>>>> /usr/include/lttng/ust-tracepoint-event.h:103:6: note: previous defini=
tion of =91_TP_COMBINE_TOKENS=92 was here
>>>> In file included from /usr/include/lttng/ust-tracepoint-event.h:118:0,
>>>>                from /usr/include/lttng/tracepoint-event.h:41,
>>>>                from hello-tp.h:33,
>>>>                from hello-tp.c:7:
>>>> ././hello-tp.h: In function =91_TP_COMBINE_TOKENS=92:
>>>> ././hello-tp.h:13:20: error: missing ')' after "defined"
>>>> ././hello-tp.h:13:21: error: missing binary operator before token "TP_=
H"
>>>> In file included from /usr/include/lttng/ust-tracepoint-event.h:138:0,
>>>>                from /usr/include/lttng/tracepoint-event.h:41,
>>>>                from hello-tp.h:33,
>>>>                from hello-tp.c:7:
>>>> ././hello-tp.h: At top level:
>>>> ././hello-tp.h:13:20: error: missing ')' after "defined"
>>>> ././hello-tp.h:13:21: error: missing binary operator before token "TP_=
H"
>>>> In file included from /usr/include/lttng/ust-tracepoint-event.h:215:0,
>>>>                from /usr/include/lttng/tracepoint-event.h:41,
>>>>                from hello-tp.h:33,
>>>>                from hello-tp.c:7:
>>>> ././hello-tp.h:13:20: error: missing ')' after "defined"
>>>> ././hello-tp.h:13:21: error: missing binary operator before token "TP_=
H"
>>>> In file included from /usr/include/lttng/ust-tracepoint-event.h:233:0,
>>>>                from /usr/include/lttng/tracepoint-event.h:41,
>>>>                from hello-tp.h:33,
>>>>                from hello-tp.c:7:
>>>> ././hello-tp.h:13:20: error: missing ')' after "defined"
>>>> ././hello-tp.h:13:21: error: missing binary operator before token "TP_=
H"
>>>> In file included from /usr/include/lttng/ust-tracepoint-event.h:292:0,
>>>>                from /usr/include/lttng/tracepoint-event.h:41,
>>>>                from hello-tp.h:33,
>>>>                from hello-tp.c:7:
>>>> ././hello-tp.h:13:20: error: missing ')' after "defined"
>>>> ././hello-tp.h:13:21: error: missing binary operator before token "TP_=
H"
>>>> In file included from /usr/include/lttng/ust-tracepoint-event.h:340:0,
>>>>                from /usr/include/lttng/tracepoint-event.h:41,
>>>>                from hello-tp.h:33,
>>>>                from hello-tp.c:7:
>>>> ././hello-tp.h:13:20: error: missing ')' after "defined"
>>>> ././hello-tp.h:13:21: error: missing binary operator before token "TP_=
H"
>>>> In file included from /usr/include/lttng/ust-tracepoint-event.h:433:0,
>>>>                from /usr/include/lttng/tracepoint-event.h:41,
>>>>                from hello-tp.h:33,
>>>>                from hello-tp.c:7:
>>>> ././hello-tp.h:13:20: error: missing ')' after "defined"
>>>> ././hello-tp.h:13:21: error: missing binary operator before token "TP_=
H"
>>>> In file included from /usr/include/lttng/ust-tracepoint-event.h:454:0,
>>>>                from /usr/include/lttng/tracepoint-event.h:41,
>>>>                from hello-tp.h:33,
>>>>                from hello-tp.c:7:
>>>> ././hello-tp.h:13:20: error: missing ')' after "defined"
>>>> ././hello-tp.h:13:21: error: missing binary operator before token "TP_=
H"
>>>> In file included from /usr/include/lttng/ust-tracepoint-event.h:474:0,
>>>>                from /usr/include/lttng/tracepoint-event.h:41,
>>>>                from hello-tp.h:33,
>>>>                from hello-tp.c:7:
>>>> ././hello-tp.h:13:20: error: missing ')' after "defined"
>>>> ././hello-tp.h:13:21: error: missing binary operator before token "TP_=
H"
>>>> In file included from /usr/include/lttng/ust-tracepoint-event.h:501:0,
>>>>                from /usr/include/lttng/tracepoint-event.h:41,
>>>>                from hello-tp.h:33,
>>>>                from hello-tp.c:7:
>>>> ././hello-tp.h:13:20: error: missing ')' after "defined"
>>>> ././hello-tp.h:13:21: error: missing binary operator before token "TP_=
H"
>>>> In file included from /usr/include/lttng/tracepoint-event.h:41:0,
>>>>                from hello-tp.h:33,
>>>>                from hello-tp.c:7:
>>>> /usr/include/lttng/ust-tracepoint-event.h:516:39: error: =91_TP_COMBIN=
E_TOKENS=92 declared as function returning an array
>>>> /usr/include/lttng/ust-tracepoint-event.h:516:21: error: function =91_=
TP_COMBINE_TOKENS=92 is initialized like a variable
>>>> In file included from /usr/include/lttng/ust-tracepoint-event.h:517:0,
>>>>                from /usr/include/lttng/tracepoint-event.h:41,
>>>>                from hello-tp.h:33,
>>>>                from hello-tp.c:7:
>>>> ././hello-tp.h:13:20: error: missing ')' after "defined"
>>>> ././hello-tp.h:13:21: error: missing binary operator before token "TP_=
H"
>>>> In file included from /usr/include/lttng/tracepoint-event.h:41:0,
>>>>                from hello-tp.h:33,
>>>>                from hello-tp.c:7:
>>>> /usr/include/lttng/ust-tracepoint-event.h:518:1: error: empty scalar i=
nitializer
>>>> /usr/include/lttng/ust-tracepoint-event.h:518:1: error: (near initiali=
zation for =91_TP_COMBINE_TOKENS=92)
>>>> /usr/include/lttng/ust-tracepoint-event.h:528:15: error: function =91_=
TP_COMBINE_TOKENS=92 is initialized like a variable
>>>> /usr/include/lttng/ust-tracepoint-event.h:528:32: error: conflicting t=
ypes for =91_TP_COMBINE_TOKENS=92
>>>> /usr/include/lttng/ust-tracepoint-event.h:116:6: note: previous defini=
tion of =91_TP_COMBINE_TOKENS=92 was here
>>>> /usr/include/lttng/ust-tracepoint-event.h:529:2: error: field name not=
 in record or union initializer
>>>> /usr/include/lttng/ust-tracepoint-event.h:529:2: error: (near initiali=
zation for =91_TP_COMBINE_TOKENS=92)
>>>> /usr/include/lttng/ust-tracepoint-event.h:529:2: error: invalid initia=
lizer
>>>> /usr/include/lttng/ust-tracepoint-event.h:529:2: error: (near initiali=
zation for =91_TP_COMBINE_TOKENS=92)
>>>> /usr/include/lttng/ust-tracepoint-event.h:530:2: error: field name not=
 in record or union initializer
>>>> /usr/include/lttng/ust-tracepoint-event.h:530:2: error: (near initiali=
zation for =91_TP_COMBINE_TOKENS=92)
>>>> /usr/include/lttng/ust-tracepoint-event.h:530:35: error: =91__event_de=
sc___=92 undeclared here (not in a function)
>>>> /usr/include/lttng/ust-tracepoint-event.h:530:52: error: =91hello_worl=
d=92 undeclared here (not in a function)
>>>> /usr/include/lttng/ust-tracepoint-event.h:531:2: error: field name not=
 in record or union initializer
>>>> /usr/include/lttng/ust-tracepoint-event.h:531:2: error: (near initiali=
zation for =91_TP_COMBINE_TOKENS=92)
>>>> In file included from /usr/include/lttng/tracepoint-event.h:41:0,
>>>>                from hello-tp.h:33,
>>>>                from hello-tp.c:7:
>>>> /usr/include/lttng/ust-tracepoint-event.h:546:1: error: =91_TP_COMBINE=
_TOKENS=92 declared as function returning a function
>>>> /usr/include/lttng/ust-tracepoint-event.h:546:1: error: conflicting ty=
pes for =91_TP_COMBINE_TOKENS=92
>>>> /usr/include/lttng/ust-tracepoint-event.h:528:32: note: previous decla=
ration of =91_TP_COMBINE_TOKENS=92 was here
>>>> /usr/include/lttng/ust-tracepoint-event.h: In function =91_TP_COMBINE_=
TOKENS=92:
>>>> /usr/include/lttng/ust-tracepoint-event.h:550:47: error: =91__probe_de=
sc___=92 undeclared (first use in this function)
>>>> /usr/include/lttng/ust-tracepoint-event.h:550:47: note: each undeclare=
d identifier is reported only once for each function it appears in
>>>> /usr/include/lttng/ust-tracepoint-event.h: At top level:
>>>> /usr/include/lttng/ust-tracepoint-event.h:555:1: error: =91_TP_COMBINE=
_TOKENS=92 declared as function returning a function
>>>> /usr/include/lttng/ust-tracepoint-event.h:555:1: error: redefinition o=
f =91_TP_COMBINE_TOKENS=92
>>>> /usr/include/lttng/ust-tracepoint-event.h:546:1: note: previous defini=
tion of =91_TP_COMBINE_TOKENS=92 was here
>>>> /usr/include/lttng/ust-tracepoint-event.h: In function =91_TP_COMBINE_=
TOKENS=92:
>>>> /usr/include/lttng/ust-tracepoint-event.h:557:43: error: =91__probe_de=
sc___=92 undeclared (first use in this function)
>>>> =

>>>> =

>>>> Cheers and thanks
>>>> =

>>>> Yan Grange
>>>> _______________________________________________
>>>> lttng-dev mailing list
>>>> lttng-dev@lists.lttng.org
>>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>> =

>>> =

>>> =

>>> --
>>> J=E9r=E9mie Galarneau
>>> EfficiOS Inc.
>>> http://www.efficios.com
> =

> =

> =

> -- =

> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com
