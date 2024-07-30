Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0580C3DA49
	for <lttng-dev@archiver.kernel.org>; Tue, 30 Jul 2024 15:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1722354878;
	bh=Rlr/rFWWeHyG2xfybtZsYlG2PKSFMARS7WJngUu2/nU=;
	h=References:In-Reply-To:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=SEggbaGDd7Mhry4zscUpzaPol1ZKdAN6NTY5plqsQ7lm74gfS7X7kYCR6JHjRfwKl
	 KxnTAvwPI5up+4aNRZ6T24W+2+94zOiUulrz5VRY5BDpA+qxAspvbDCS8igBJB5EKG
	 Fc2F9EgrgnttPz4+9+/dby4vx2jwUFItHkGr5JpaaZEWJFVMG0YiCbfs/aAA4jUcU2
	 DJQFHX6IGcc71y9WivU2JbeKZ6RzBTP1moAunx5LaW3OvWMxxNwxH09G4+z+iSE6gy
	 H27gh6Iannoq2g1h+YEohIc6WotAz7yGQZJ/cwH2D7EHd4XF2dnDcUZg+4M2t4qHMR
	 DPT88A06gDPOA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4WYKYB0XRkz159K;
	Tue, 30 Jul 2024 11:54:38 -0400 (EDT)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 by lists.lttng.org (Postfix) with ESMTPS id 4WYKY867c1z15L3
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jul 2024 11:54:36 -0400 (EDT)
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e05eccfcdb3so3164489276.1
 for <lttng-dev@lists.lttng.org>; Tue, 30 Jul 2024 08:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722354876; x=1722959676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lAFnQl4ZlPd32lcBCQod96VP2BZimZvdfY8Lo7feZMk=;
 b=CF9Mn422whfM++2Mw2uc6odn4VJbc7rJBIpuqO/JXTim7dsVHcne1Z+kzqNkLfheep
 UHvUThfK8PFm6majZYOGTryXdYFx/yRNwzxYnHkLNbUHzZ8BhnPT1uln565L0CGxlfuc
 34x9vCuX/7kjw/23ZIDvkCESQq3q+E7YQyAK4QkVMZA0dRuKJRlveenLXHIYUShQxyMg
 rVsqCYt7nx4opRqM1mdB672bHrJ8rVhZyiDkEhYskiiaxLHROqDieUJ4NhbR2uUVuO0F
 AAHHcGh2l8jPiiUbcBtX85XexQZ7/d3tefJsFanDJ5TS478fylok9oSFbdkBz6cwyaUG
 wa3Q==
X-Gm-Message-State: AOJu0YyZF4sjrHqpsybE/grIpnUggm5ntSyoDIVHhb4R3rbM+HIxEphZ
 GTRzUv4TaUatsv1WLjmPxpwBWrVNh998ftJ8OQr3A4zYoTjYfwTcsJDf6aNDC03TxaBysfnx7W2
 XYAUhMhn77EYEngw3qpF+Rho5W5c=
X-Google-Smtp-Source: AGHT+IFOB2WGb4C70kTT8TfOzgaz9/l1D93jaXJtSqmFplR+c4i8PwmAWzoZ1L1rgBd1yj+A0Q6leUdd2ApchgZi8G8=
X-Received: by 2002:a05:6902:120a:b0:e0b:5b37:d0c9 with SMTP id
 3f1490d57ef6-e0b5b37d241mr10426635276.14.1722354875537; Tue, 30 Jul 2024
 08:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAFZh4h_wh01sjAar-QqHsQ=KY4zLjmpmXuJc83OeYue7YyYW3A@mail.gmail.com>
 <CAFZh4h9iaCGdnDhxik9Qtq82f0MGU2eL+8nBa8qoCCJrH-xsGQ@mail.gmail.com>
 <d30f1655-0efa-440a-ac17-fe82342f4556@efficios.com>
 <CAFZh4h_pOCzpJ6ssdZ7ts3vSdJNfEtS+d+2Foi4qAY6oH0+VKw@mail.gmail.com>
 <33527830-3bf3-4bc3-a53d-55eaefb74902@efficios.com>
 <CAFZh4h8k+eGuVJLJ_1vA1_P7+3Hi7h+UgUSmoN51Paxyypw-fA@mail.gmail.com>
 <09087915-9e15-4485-b3d3-f48b245690ec@efficios.com>
 <CAFZh4h-_ixamDD4hMMETXGx8oA6Dr_3R5eFBeQPusFnKHEXKGg@mail.gmail.com>
 <d52b867f-c35c-497a-af92-dfbe4452794c@efficios.com>
 <CAFZh4h-Sp0HrUZZzfze0zwVcJznD1NeiJTpBt3hAfk=j1JieQw@mail.gmail.com>
 <85e9d8f5-572e-4d3b-87f7-5ad7d21dfb3f@efficios.com>
 <CAFZh4h9kEvxH0nJw22=dGVA9xTDmshG_z_wv46qo+0cqgsbPRg@mail.gmail.com>
In-Reply-To: <CAFZh4h9kEvxH0nJw22=dGVA9xTDmshG_z_wv46qo+0cqgsbPRg@mail.gmail.com>
Date: Tue, 30 Jul 2024 11:54:23 -0400
Message-ID: <CAFZh4h8D71LguVq=QA3KU8thBUjJP8RzKh1DxDiy7V+3VLLAkQ@mail.gmail.com>
To: Kienan Stewart <kstewart@efficios.com>
Cc: lttng-dev@lists.lttng.org, yocto@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="00000000000088bf92061e78fe5e"
Subject: Re: [lttng-dev] Using lttng-ust 2.13.6 from Yocto Kirkstone and
 getting weird segfault saying strlen_asimd.S can't be found.
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Brian Hutchinson via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Brian Hutchinson <b.hutchman@gmail.com>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--00000000000088bf92061e78fe5e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kienan,

I noticed looking thru the 38k line LTTNG_UST_DEBUG session this line:

"       810:     /usr/lib/liblttng-ust.so.1: error: symbol lookup
error: undefined symbol: ltt_probe_register (fatal)"

... and it jogged my memory that I did see some abi conflict messages
in lttng-ust "make check" that I don't know if they are "good" or
"bad" but could be related???

Anyway, attaching a tar of lttng-ust and lttng-tools "make check" for
your enjoyment.

Regards,

Brian




On Tue, Jul 30, 2024 at 8:40=E2=80=AFAM Brian Hutchinson <b.hutchman@gmail.=
com> wrote:
>
> On Mon, Jul 29, 2024 at 3:03=E2=80=AFPM Kienan Stewart <kstewart@efficios=
.com> wrote:
> >
> > Hi Brian,
> >
> > On 7/25/24 3:54 PM, Brian Hutchinson wrote:
> > > Hi Kienan,
> > >
> > > I'll answer your questions below, but I've got questions on what I sa=
w
> > > building and installing lttng-tools (2.13.13) and lttng-ust (2.13.8).
> > >
> > > Based on the struggles I've had trying to get lttng to work with my
> > > app over various Yocto versions (Dunfell & Kirkstone) and lttng
> > > version, I think the problems I'm facing are mostly around C++ and
> > > weak and hidden symbols in Yocto toolchain.
> > >
> > > When I started my app with the options you mentioned previously a
> > > while back, Id see things like:
> > >
> > > # LTTNG_UST_DEBUG=3D1 LTTNG_UST_REGISTER_TIMEOUT=3D-1 /opt/tc/Traffic=
Controller
> > > liblttng_ust_tracepoint[4012/4012]: Your compiler treats weak symbols
> > > with hidden visibility for integer objects as SAME address between
> > > compile units part of the same module. (in check_weak_hidden() at
> > > tracepoint.c:1012)
> > > liblttng_ust_tracepoint[4012/4012]: Your compiler treats weak symbols
> > > with hidden visibility for pointer objects as SAME address between
> > > compile units part of the same module. (in check_weak_hidden() at
> > > tracepoint.c:1016)
> > > liblttng_ust_tracepoint[4012/4012]: Your compiler treats weak symbols
> > > with hidden visibility for 24-byte structure objects as SAME address
> > > between compile units part of the same module. (in check_weak_hidden(=
)
> > > at tracepoint.c:1020)
> > >
> >
> > These messages are extra information for debugging and not indicative o=
f
> > a problem in of itself. C.f.
> > https://github.com/lttng/lttng-ust/blob/24f7193c9b918bf714a40e9fc908eeb=
4978ada1c/src/lib/lttng-ust-tracepoint/tracepoint.c#L1010
> >
> > There is a unit test related to this:
> > https://github.com/lttng/lttng-ust/blob/24f7193c9b918bf714a40e9fc908eeb=
4978ada1c/tests/unit/gcc-weak-hidden/main.c#L76
> >
> >
> > > I further researched this whole 'weak symbol' and 'hidden visibility'
> > > topic in the lttng-dev archives and it smells a lot like what I've
> > > been seeing.  You should be able to mix both tracef and tracepoint
> > > calls in souce code ... but I could not.  I could get a tracef call t=
o
> > > work but if I put a tracepoint call in the same code then nothing
> > > would work.  This was with Dunfell 3.1.7 and earlier versions of
> > > lttng.
> > >
> > > At one point I could get a tracepoint call to work but I'd have to le=
t
> > > our cmake build system build and link the tpp.c file and then turn
> > > around and use gcc to recompile it and copy it to where all the
> > > objects were to create the huge .a library the app was built against.
> > > That's when I first learned there are issues with C++.  I think g++ i=
s
> > > used to build even .c files that aren't c++.
> > >
> > > Then if I tried to put a tracepoint in another sub project, none of
> > > the tracepoints would work and I'd get empty traces.  This is a
> > > symptom of the 'weak symbols with hidden visibility' issue ... and I
> > > finally found others that were having same issue in the archives.  I
> > > don't fully understand the issues here, although I do understand some
> > > of what's going on ... I just don't know what to do about it.
> > >
> >
> > You said initially said that you're using `lttng_ust_tracepoint` exactl=
y
> > as the hello world from the documentation; however, you have just
> > described several attempts at doing different things. Which case are we
> > trying to understand here?
>
> lttng_ust_tracepoint.  I only mentioned prior tests for context to
> similar struggles from a year or more ago.
>
>
> >
> > > At this point I was being encouraged to keep upgrading to newer
> > > versions of lttng.  Our app never changed, gcc & lttng etc., kept
> > > changing.  Now with newer versions nothing runs, all I get is an
> > > immediate segfault.  Again, I'm building just like I did before a yea=
r
> > > or so ago with older versions of Yocto and lttng.  I say all of that
> > > to give perspective and history of what I've seen and experienced.
> > > Now this TLS thing has entered the picture too and so far I've only
> > > changed lttng, I don't know if I should be applying patches to my gcc
> > > for that issue.  Like I said, I'm currently using Yocto Kirkstone
> > > 4.0.18 and 6.1.38 kernel.
> > >
> > > Now I'll move into the area of things I've seen building/installing
> > > lttng-tools and lttng-ust natively on the target environment I've
> > > setup where I can run 'make check' etc.  These are in the category of
> > > "hey, is this ok, should I be worried about this":
> > >
> > > While building lttng-tools I see things like:
> > >
> > > *** Warning: Linking the executable userspace-probe-elf-binary agains=
t
> > > the loadable module
> > > *** libfoo.so is not portable!
> > >
> >
> > The library is for a test program. My understanding is that the library
> > is compiled that way to force a stripped shared object to be produced i=
n
> > order to validate that symbol lookups in libraries with no symtab
> > function as expected by using the dynsym table.
> >
> > C.f.
> > https://github.com/lttng/lttng-tools/commit/ef3dfe5d31c88fb548189a6441a=
af8b2afc0bd4b
> >
> > > In file included from ../../../src/common/macros.h:15,
> > >                  from ../../../include/lttng/health-internal.h:19,
> > >                  from lttng-ctl-health.c:19:
> > > In function 'lttng_strnlen',
> > >     inlined from 'lttng_strncpy' at ../../../src/common/macros.h:128:=
6,
> > >     inlined from 'set_health_socket_path' at lttng-ctl-health.c:146:9=
,
> > >     inlined from 'lttng_health_query' at lttng-ctl-health.c:264:8:
> > > ../../../src/common/compat/string.h:19:16: warning: 'strnlen'
> > > specified bound 4096 may exceed source size 37 [-Wstringop-overread]
> > >    19 |         return strnlen(str, max);
> > >       |                ^~~~~~~~~~~~~~~~~
> > > lttng-ctl-health.c: At top level:
> > > cc1: note: unrecognized command-line option
> > > '-Wno-incomplete-setjmp-declaration' may have been intended to silenc=
e
> > > earlier diagnostics
> >
> > This warning is addressed in
> > https://github.com/lttng/lttng-tools/commit/b25a59916106e5055be516f61f1=
83a48f459b0b3
> >
> > > ** Warning: Linking the shared library libbar.la against the loadable=
 module
> > > *** libzzz.so is not portable!
> > >
> > > *** Warning: Linking the shared library libfoo.la against the loadabl=
e module
> > > *** libbar.so is not portable!
> > >
> > > While installing lttng-tools I see things like this:
> > >
> > > make[4]: Entering directory '/opt/lttng/lttng-tools-2.13.13/src/lib/l=
ttng-ctl'
> > >   CC       lttng-ctl.lo
> > >   CC       snapshot.lo
> > >   CC       lttng-ctl-health.lo
> > > In file included from ../../../src/common/macros.h:15,
> > >                  from ../../../include/lttng/health-internal.h:19,
> > >                  from lttng-ctl-health.c:19:
> > > In function 'lttng_strnlen',
> > >     inlined from 'lttng_strncpy' at ../../../src/common/macros.h:128:=
6,
> > >     inlined from 'set_health_socket_path' at lttng-ctl-health.c:146:9=
,
> > >     inlined from 'lttng_health_query' at lttng-ctl-health.c:264:8:
> > > ../../../src/common/compat/string.h:19:16: warning: 'strnlen'
> > > specified bound 4096 may exceed source size 37 [-Wstringop-overread]
> > >    19 |         return strnlen(str, max);
> > >       |                ^~~~~~~~~~~~~~~~~
> > > lttng-ctl-health.c: At top level:
> > > cc1: note: unrecognized command-line option
> > > '-Wno-incomplete-setjmp-declaration' may have been intended to silenc=
e
> > > earlier diagnostics
> > >
> > > Making install in trigger-condition-event-matches
> > > make[2]: Entering directory
> > > '/opt/lttng/lttng-tools-2.13.13/doc/examples/trigger-condition-event-=
matches'
> > >   CC       instrumented-app.o
> > >   CC       tracepoint-trigger-example.o
> > >   AR       libtracepoint-trigger-example.a
> > > ar: `u' modifier ignored since `D' is the default (see `U')
> > >
> > > While building lttng-ust I see things like:
> > >
> > > Making all in utils
> > > make[2]: Entering directory
> > > '/home/iadmin/lttng-ust/lttng-ust-2.13.8/tests/utils'
> > >   CC       tap.o
> > >   AR       libtap.a
> > > ar: `u' modifier ignored since `D' is the default (see `U')
> > >
> >
> > While libtool now uses `cr` by default, automake still defines the
> > default to `cru` which is what ends up getting used in the example.
> > Since many distros have changed the configuration of ar such that 'D' i=
s
> > the default rather than the previous behaviour 'U', 'u' is redundant.
> >
> > The behaviour in automake has been changed in automake 1.16.90+.
> >
> > C.f.
> > https://github.com/autotools-mirror/libtool/commit/418129bc63afc312701e=
84cb8afa5ca413df1ab5
> >
> > C.f.
> > http://git.savannah.gnu.org/cgit/automake.git/commit/?id=3D8cdbdda5aec6=
52c356fe6dbba96810202176ae75
> >
> > > *** Warning: Linking the shared library libzero.la against the
> > > loadable module
> > > *** libfakeust0.so is not portable!
> > >   CCLD     app_noust_indirect_abi0
> > >
> > > *** Warning: Linking the executable app_noust_indirect_abi0 against
> > > the loadable module
> > > *** libzero.so is not portable!
> > >   CC       app_noust_indirect_abi0_abi1-app_noust.o
> > >   CC       libone.lo
> > >   CCLD     libone.la
> > >   CCLD     app_noust_indirect_abi0_abi1
> > >
> > > *** Warning: Linking the executable app_noust_indirect_abi0_abi1
> > > against the loadable module
> > > *** libzero.so is not portable!
> > >
> > > *** Warning: Linking the executable app_noust_indirect_abi0_abi1
> > > against the loadable module
> > > *** libone.so is not portable!
> > >   CC       app_noust_indirect_abi1-app_noust.o
> > >   CCLD     app_noust_indirect_abi1
> > >
> > > *** Warning: Linking the executable app_noust_indirect_abi0_abi1
> > > against the loadable module
> > > *** libone.so is not portable!
> > >   CC       app_noust_indirect_abi1-app_noust.o
> > >   CCLD     app_noust_indirect_abi1
> > >
> > > *** Warning: Linking the executable app_noust_indirect_abi1 against
> > > the loadable module
> > > *** libone.so is not portable!
> > >   CC       app_ust.o
> > >   CC       tp.o
> > >   CCLD     app_ust
> > >   CC       app_ust_dlopen.o
> > >   CCLD     app_ust_dlopen
> > >   CC       app_ust_indirect_abi0-app_ust.o
> > >   CC       app_ust_indirect_abi0-tp.o
> > >   CCLD     app_ust_indirect_abi0
> > >
> > > *** Warning: Linking the executable app_ust_indirect_abi0 against the
> > > loadable module
> > > *** libzero.so is not portable!
> > >   CC       app_ust_indirect_abi0_abi1-app_ust.o
> > >   CC       app_ust_indirect_abi0_abi1-tp.o
> > >   CCLD     app_ust_indirect_abi0_abi1
> > >
> > > *** Warning: Linking the executable app_ust_indirect_abi0_abi1 agains=
t
> > > the loadable module
> > > *** libzero.so is not portable!
> > >
> > > I don't know if these are ok or if I should be worried about any of t=
hat.
> > >
> >
> > These are all for different tests.
> >
> > > ... now on to your questions below.
> > >
> > >
> > >
> > > On Wed, Jul 24, 2024 at 12:04=E2=80=AFPM Kienan Stewart <kstewart@eff=
icios.com> wrote:
> > >>
> > >> Hi Brian,
> > >>
> > >> On 7/22/24 6:00 PM, Brian Hutchinson wrote:
> > >>> Hi Kienan,
> > >>>
> > >>> Took a while to gather your grocery list but I think I have most of=
 it
> > >>> below ;)
> > >>
> > >> thanks for all the extra info. Replies inline below, but I'll cut a =
lot
> > >> of the long output for readability.
> > >>
> > >> tl;dr the environment continues to be weird, but my present suspicio=
n is
> > >> that something in either compilation, the linking of your app (eg. w=
ith
> > >> ld when producing the executable), or some post linking stripping mi=
ght
> > >> be causing issues.
> > >
> > > I'm not aware of any stripping that's going on.  In fact everything i=
s
> > > being built with debug symbols at the moment and I even turned off
> > > optimization ... even used the debug friendly -O flag to see if that
> > > made a difference.
> > >
> > >>
> > >> I will stop digging into further hypotheticals on my side as there i=
s no
> > >> reproducer for both the environment and the application. If you ever=
 end
> > >> up with a minimal reproducer that you can share, I'd be more than ha=
ppy
> > >> to examine it.
> > >
> > > I'm planning on trying to make a small reproducer I can share but not=
 there yet.
> > >
> >
> > Great! I appreciate that you're taking the time to do so.
> >
> > >>
> > >>>
> > >>> I may have not been clear.  Most of the application components are
> > >>> statically linked but I think there are some that are built as shar=
ed
> > >>> objects (.so's) so that's what I was referring to.  I know that
> > >>> lttng-ust is dynamically linked ... I think the lttng-ust docs say =
this
> > >>> is only option but also makes reference to the fact static linking =
was
> > >>> once possible (in some versions of the documentation) but not suppo=
rted
> > >>> anymore (I probably have the docs memorized by now ha, ha ... I've
> > >>> looked at many, many versions of them).
> > >>>
> > >>> Just for full disclosure my ldd looks like:
> > >>>
> > >>>          linux-vdso.so.1 (0x0000ffffab196000)
> > >>>          libfcgi.so.0 =3D> /usr/lib/libfcgi.so.0 (0x0000ffffa57f000=
0)
> > >>>          liblttng-ust.so.1 =3D> /usr/lib/liblttng-ust.so.1
> > >>> (0x0000ffffa5750000)
> > >>>          libxml2.so.2 =3D> /usr/lib/libxml2.so.2 (0x0000ffffa55d000=
0)
> > >>>          librt.so.1 =3D> /lib/librt.so.1 (0x0000ffffa55b0000)
> > >>>          libm.so.6 =3D> /lib/libm.so.6 (0x0000ffffa5510000)
> > >>>          libstdc++.so.6 =3D> /usr/lib/libstdc++.so.6 (0x0000ffffa52=
f0000)
> > >>>          libgcc_s.so.1 =3D> /lib/libgcc_s.so.1 (0x0000ffffa52c0000)
> > >>>          libc.so.6 =3D> /lib/libc.so.6 (0x0000ffffa5110000)
> > >>>          /lib/ld-linux-aarch64.so.1 (0x0000ffffab15d000)
> > >>>          liblttng-ust-common.so.1 =3D>
> > >>> /usr/local/lib/liblttng-ust-common.so.1 (0x0000ffffa50e0000)
> > >>>          liblttng-ust-tracepoint.so.1 =3D>
> > >>> /usr/local/lib/liblttng-ust-tracepoint.so.1 (0x0000ffffa50a0000)
> > >>>          libpthread.so.0 =3D> /lib/libpthread.so.0 (0x0000ffffa5080=
000)
> > >>>          libz.so.1 =3D> /lib/libz.so.1 (0x0000ffffa5050000)
> > >>>
> > >>>
> > >>
> > >> I find it very suspicious that `liblttng-ust.so.1` is in `/usr/lib`,
> > >> while the other lttng-ust libraries are being loaded from `/usr/loca=
l/lib`.
> > >
> > > So Yocto puts all of the lttng libs into /usr/lib.  When I sent the
> > > previous info I was using lttng-tools and modules built by Yocto/OE
> > > and I setup a native build environment on the target so I could run
> > > 'make check' etc., and that's why there were things in /usr/local/lib
> > > because that's where you guys want stuff to be.  So I actually left
> > > the lttng-ust installables in /usr/local/build but also copied them t=
o
> > > /usr/lib to overwrite old Yocto versions there.
> > >
> >
> > It's not so much that it's "where we want it to be". The documentation
> > uses `/usr/local/lib` because `/usr/local` is meant for software
> > installed by the sysadmin administrator, as is the case when building a
> > custom version. `/usr/lib` should be used by packages shipped with the
> > system.
> >
> > C.f. https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch04s09.html
> >
> > You're free to do as you see fit, but when you start mixing and matchin=
g
> > libraries and some are put in /usr/lib by your system packages and some
> > you move there manually I find it more difficult to follow what is goin=
g on.
> >
> > >>
> > >> This information also matches the statedump and the LD_DEBUG info fr=
om
> > >> later on.
> > >>
> > >> Could you verify some of the following information:
> > >>
> > >> 1. In your build root for lttng-ust, enumerate all the liblttng*so
> > >> files. For each shared object, run `file $libname` and record the va=
lue
> > >> of the BuildID hash.R5jow
> > >
> > > Sorry, I'm not following you here.  The only buildID hash I can think
> > > of is with 'eu-unstrip -n' but that's on core files, not individual
> > > libs.  And looking at the options I have for 'file' on my target, I
> > > don't see anything that looks like what you are asking.
> >
> > Perhaps I wasn't clear, the command to run is really just `file`. As a
> > fuller example:
> >
> > ```
> > $ file ./src/lib/lttng-ust-fork/.libs/liblttng-ust-fork.so.1.0.0
> > ./src/lib/lttng-ust-fork/.libs/liblttng-ust-fork.so.1.0.0: ELF 64-bit
> > LSB shared object, x86-64, version 1 (SYSV), dynamically linked,
> > BuildID[sha1]=3Db2b4a0fc449cf317e32c23e0bb57ea1ad702b702, with debug_in=
fo,
> > not stripped
>
> Ok, feel stupid now.  When I ran the command before, I used short name
> and didn't do it on the long name and just got back:
>
> # file /usr/lib/liblttng-ust.so
> /usr/lib/liblttng-ust.so: symbolic link to liblttng-ust.so.1.0.0
>
> ... and immediately looked at man page to try to figure out what
> switch showed BuildID etc., ha, ha.
>
> When I do it on long name here is what I see:
>
> # file /usr/lib/liblttng-ust-common.so.1.0.0
> /usr/lib/liblttng-ust-common.so.1.0.0: ELF 64-bit LSB shared object,
> ARM aarch64, version 1 (SYSV), dynamically linked,
> BuildID[sha1]=3Da50c9a77163b6b91e1f84e57d167c7b77ae707a3, with
> debug_info, not stripped
> # file /usr/lib/liblttng-ust-ctl.so.5.0.0
> /usr/lib/liblttng-ust-ctl.so.5.0.0: ELF 64-bit LSB shared object, ARM
> aarch64, version 1 (SYSV), dynamically linked,
> BuildID[sha1]=3D547cccac08721ed1c9a7f3c7ebf1de84ddba7fba, with
> debug_info, not stripped
> # file /usr/lib/liblttng-ust-cyg-profile-fast.so.1.0.0
> /usr/lib/liblttng-ust-cyg-profile-fast.so.1.0.0: ELF 64-bit LSB shared
> object, ARM aarch64, version 1 (SYSV), dynamically linked,
> BuildID[sha1]=3Dad5f71ef5e83ab9a972488976c47db265d3360b9, with
> debug_info, not stripped
> # file /usr/lib/liblttng-ust-cyg-profile.so.1.0.0
> /usr/lib/liblttng-ust-cyg-profile.so.1.0.0: ELF 64-bit LSB shared
> object, ARM aarch64, version 1 (SYSV), dynamically linked,
> BuildID[sha1]=3Dc2c246c1973bd3241aa4f7229fcbcb27ebe08e82, with
> debug_info, not stripped
> # file /usr/lib/liblttng-ust-dl.so.1.0.0
> /usr/lib/liblttng-ust-dl.so.1.0.0: ELF 64-bit LSB shared object, ARM
> aarch64, version 1 (SYSV), dynamically linked,
> BuildID[sha1]=3D6082ee88c9394319bc3adff16b0b3ea9f8d549ec, with
> debug_info, not stripped
> # file /usr/lib/liblttng-ust-fd.so.1.0.0
> /usr/lib/liblttng-ust-fd.so.1.0.0: ELF 64-bit LSB shared object, ARM
> aarch64, version 1 (SYSV), dynamically linked,
> BuildID[sha1]=3Da2813245af91abe98615771dfd7d5f19b033a410, with
> debug_info, not stripped
> # file /usr/lib/liblttng-ust-fork.so.1.0.0
> /usr/lib/liblttng-ust-fork.so.1.0.0: ELF 64-bit LSB shared object, ARM
> aarch64, version 1 (SYSV), dynamically linked,
> BuildID[sha1]=3D86afa53808502873830c02290f477d4ff8013afb, with
> debug_info, not stripped
> # file /usr/lib/liblttng-ust-libc-wrapper.so.1.0.0
> /usr/lib/liblttng-ust-libc-wrapper.so.1.0.0: ELF 64-bit LSB shared
> object, ARM aarch64, version 1 (SYSV), dynamically linked,
> BuildID[sha1]=3D52f391875a378b5f2c46747a58020b86cb7c9a83, with
> debug_info, not stripped
> # file /usr/lib/liblttng-ust-pthread-wrapper.so.1.0.0
> /usr/lib/liblttng-ust-pthread-wrapper.so.1.0.0: ELF 64-bit LSB shared
> object, ARM aarch64, version 1 (SYSV), dynamically linked,
> BuildID[sha1]=3D7127223a7e8ed67c6697b95ae1f8ac107df7e47e, with
> debug_info, not stripped
> # file /usr/lib/liblttng-ust-tracepoint.so.1.0.0
> /usr/lib/liblttng-ust-tracepoint.so.1.0.0: ELF 64-bit LSB shared
> object, ARM aarch64, version 1 (SYSV), dynamically linked,
> BuildID[sha1]=3D5971b4d84ec1efe61c6d47c38e92de20569f0f49, with
> debug_info, not stripped
> # file /usr/lib/liblttng-ust.so.1.0.0
> /usr/lib/liblttng-ust.so.1.0.0: ELF 64-bit LSB shared object, ARM
> aarch64, version 1 (SYSV), dynamically linked,
> BuildID[sha1]=3Dce7097ae9bbf42a02dccd386fdfbd37e3224858b, with
> debug_info, not stripped
>
>
> cutting some stuff out cause it's getting long again.
>
> >
> > Sounds like `make check` for lttng-tools passed then?
>
> At first no.  But I think this is because I built the new lttng-tools
> in my on target native environment and ran make check and forgot to do
> make install first, so it was using the older version of lttng-tools.
>
> So then I ran make install of lttng-tools and even did a make clean
> and rebuild of lttng-ust and re-installed it and ran make check on
> both (and things looked a lot better) ... that's where those warnings
> etc., I asked you about came from.
>
> >
> > My understanding at this point is the unit tests are passing for
> > LTTng-UST on your system, as are the unit and regression tests for
> > LTTng-tools. The example programs shipped with LTTng-UST work on your
> > system, as does the example from the documentation. The statedump
> > tracepoints loaded from LTTng-UST are also working fine, as evinced by
> > the program logs and the LTTng trace you shared.
> >
> > Despite my confusion about how exactly you're using the `hello world`
> > tracepoint in your application (as you've now described several
> > variations), the direction this points to for me are details related to
> > how you're using LTTng-UST and/or how are your building and linking you=
r
> > application. To be clear, I don't mean to say that there is or is not a=
n
> > issue in LTTng-UST, but to point at where to examine next in detail
> > including analysis of the produced object files.
>
> I compared the doc/examples/hello-static-lib to what I picked out of
> the LTTng documentation on the web site "Quick start" section and the
> traceprovider headder file is including stddef.h and mine isn't and
> the doc/examples/hello-static-lib/hello.c code is doing a sighandler
> and mine isn't doing any of that either.  I think I've probably posted
> it before but will do it again.  Here is what I'm calling my "hello".
> It's from the lttng documentation but I cut it down even further just
> to make sure I didn't fat finger something.  Like I said before, the
> full hello example from the documentation works.  But when I call
> pretty much the same code from my app it seg faults.
>
> I don't know if the differences I see between my "hello" and the
> "hello-static-lib" matter.
>
> hello-tp.h:
>
> #undef LTTNG_UST_TRACEPOINT_PROVIDER
> #define LTTNG_UST_TRACEPOINT_PROVIDER hello_world
>
> #undef LTTNG_UST_TRACEPOINT_INCLUDE
> #define LTTNG_UST_TRACEPOINT_INCLUDE "./hello-tp.h"
>
> #if !defined(_HELLO_TP_H) || defined(LTTNG_UST_TRACEPOINT_HEADER_MULTI_RE=
AD)
> #define _HELLO_TP_H
>
> #include <lttng/tracepoint.h>
>
> LTTNG_UST_TRACEPOINT_EVENT(
>    hello_world,
>    my_first_tracepoint,
>    LTTNG_UST_TP_ARGS(
>        int, my_integer_arg
>    ),
>    LTTNG_UST_TP_FIELDS(
>        lttng_ust_field_integer(int, my_integer_field, my_integer_arg)
>    )
> )
>
> #endif /* _HELLO_TP_H */
>
> #include <lttng/tracepoint-event.h>
>
> hello-tp.c:
>
> #define LTTNG_UST_TRACEPOINT_CREATE_PROBES
>
> #include "hello-tp.h"
>
> From my_app:
>
> #define LTTNG_UST_TRACEPOINT_DEFINE
> //#define LTTNG_UST_TRACEPOINT_PROBE_DYNAMIC_LINKAGE
> #include "hello-tp.h"
>
> .
> .
> .
> lttng_ust_tracepoint(hello_world, my_first_tracepoint, 23, "hi there!");
>
> In the above case the tpp is static but I've tried to make it a shared
> object too (thus the commented out DYNAMIC_LINKAGE above) but get the
> same result.
>
> Again, I think the issue is probably g++ and weak/hidden symbol
> related and or TLS but that's based on the totality of what I've
> experienced over the past year or so and seeing the
> experiences/problems of others in the lttng-dev archives.
>
> Regards,
>
> Brian

--00000000000088bf92061e78fe5e
Content-Type: application/x-xz; name="make-check.tar.xz"
Content-Disposition: attachment; filename="make-check.tar.xz"
Content-Transfer-Encoding: base64
Content-ID: <f_lz8llkq00>
X-Attachment-Id: f_lz8llkq00

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
Z/sCAAAAAARZWg==
--00000000000088bf92061e78fe5e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--00000000000088bf92061e78fe5e--
