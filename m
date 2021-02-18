Return-Path: <SRS0=Fgvg=HU=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D596C433E0
	for <lttng-dev@archiver.kernel.org>; Thu, 18 Feb 2021 14:49:58 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0890F64E85
	for <lttng-dev@archiver.kernel.org>; Thu, 18 Feb 2021 14:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0890F64E85
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4DhHg70HXWz2KS;
	Thu, 18 Feb 2021 09:49:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1613659795;
	bh=KcVMiF5c0SK9+JtsFOk7M+eM2Ua2QHo8T6qv9PTJdj4=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=akpJyfHuUmkJXHbuyehvgQIBotUPAOrAXbjg821rVRaCbDwwlOWfOPCx9Lp37kxCf
	 kYsE16F+CmIZGPdsdQaktDz4YMgF24ObToH0OZN/mKlNUwO78OXEyzfPQgNpFUlasE
	 dhBUteYhoXLHAuV4Tw+vIS7AH6PyX2eqKPhdfFf4e6UieDFWNEz9nnC2hKKL4Jrudy
	 AFkIig6mJ80ucgVbLPvSrBP2dmsXUfT/rFv6mnnI+V4sUre16YIcoZ1+/byGF7y6l4
	 c1J7Q1znHqGic8jAnuZP/tzJUpzcyg5/6fgoPiw+TlvrxvZjt54Q75Wo0nBCwvd6Ky
	 HJ+Pxl3tGiJLA==
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by lists.lttng.org (Postfix) with ESMTPS id 4Dgy4T5hvMz24K
 for <lttng-dev@lists.lttng.org>; Wed, 17 Feb 2021 20:37:13 -0500 (EST)
Received: by mail-pl1-x62d.google.com with SMTP id ba1so356017plb.1
 for <lttng-dev@lists.lttng.org>; Wed, 17 Feb 2021 17:37:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=6RFHhoz0BvL4FFo29fgR6GSnjk0Z0OxC/AQ2D1pkr80=;
 b=dc9IHXZlRSK5RMuUODSL/8HoMRPDItBYLdg290FTOmrgomQ6vC3qiRgBT5xHKe6cIr
 w2ozu9qE3kqLnNpTYuVlyy8V5E/uI9RmVioaqUjd6Gc6fo2L76MmGeMcmMc9J0LOIod8
 J9qjXpMvkkP5KVAt7YcQQ5ElRqqxz9drg3zHnZ2lxNg3hAMBLzljpsFesy+mJwZEvNQL
 NL9lKUBpNr/H6G4eJuUA5oSh407W8OosZRetuEZmVQkrjl5xBNH0zubHkUXk0stNqrZY
 Gl+nOywWIysNpPSxEQlM2IgM8oXX43Xs+QKyvlH21DHJeh3eCTlApD+ZpjcZ9iJMGZHa
 3cFA==
X-Gm-Message-State: AOAM531Vxw20EtS3pVCD+WO/fV+lOjhNK5QiDQjZtpyEF/xkHJli4fJw
 kk/gfw5yHJ9xyTthbOqF4SdH6dDWTKOSXi+6swh3/WSsSnM3oA==
X-Google-Smtp-Source: ABdhPJyKnGxfsKveNSnFfP4/LExQQRvxpoQwkdsbbqkqX/yZ07VZBA3zPDr4OEUPMaSoGUlepzyjcmEoikn2Z82cjyc=
X-Received: by 2002:a17:90b:250:: with SMTP id
 fz16mr1587158pjb.227.1613612230138; 
 Wed, 17 Feb 2021 17:37:10 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 18 Feb 2021 01:36:44 +0000
Message-ID: <CABB28Cy1yzw7DGMO2Hoi83pQbEPr521YTWszO7LbgkQ8OXFAOQ@mail.gmail.com>
To: lttng-dev@lists.lttng.org
X-Mailman-Approved-At: Thu, 18 Feb 2021 09:49:54 -0500
Subject: [lttng-dev] userspace-rcu 0.12.2: build fails
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: =?utf-8?q?Tomasz_K=C5=82oczko_via_lttng-dev?= <lttng-dev@lists.lttng.org>
Reply-To: =?UTF-8?Q?Tomasz_K=C5=82oczko?= <kloczko.tomasz@gmail.com>
Content-Type: multipart/mixed; boundary="===============3952886071466725574=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============3952886071466725574==
Content-Type: multipart/alternative; boundary="000000000000c85d1705bb925f81"

--000000000000c85d1705bb925f81
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Just tested 0.12.2 and lookd like build fails on compile test programs:

make[2]: Entering directory
'/home/tkloczko/rpmbuild/BUILD/userspace-rcu-0.12.2/tests/benchmark'
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common   -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu.o test_urcu.c
In file included from test_urcu.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../../tests/common/../common/debug-yield.h:34,
                 from test_urcu.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1321: test_urcu.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DDYNAMIC_LINK_TEST  -O2 -g -grecord-gcc-switches
-pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2
-Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1
-fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m=
64
-mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection
-fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto
-flto-partition=3Dnone -c -o test_urcu_dynamic_link-test_urcu.o `test -f
'test_urcu.c' || echo './'`test_urcu.c
In file included from test_urcu.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../../tests/common/../common/debug-yield.h:34,
                 from test_urcu.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1370: test_urcu_dynamic_link-test_urcu.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DRCU_SIGNAL  -O2 -g -grecord-gcc-switches -pipe
-Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2
-Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1
-fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m=
64
-mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection
-fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto
-flto-partition=3Dnone -c -o test_urcu_signal-test_urcu.o `test -f
'test_urcu.c' || echo './'`test_urcu.c
In file included from test_urcu.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../../tests/common/../common/debug-yield.h:34,
                 from test_urcu.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1552: test_urcu_signal-test_urcu.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DRCU_SIGNAL -DDYNAMIC_LINK_TEST  -O2 -g
-grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security
-Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_signal_dynamic_link-test_urcu.o `test -f 'test_urcu.c' || echo
'./'`test_urcu.c
In file included from test_urcu.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../../tests/common/../common/debug-yield.h:34,
                 from test_urcu.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1566: test_urcu_signal_dynamic_link-test_urcu.o]
Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common   -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_rwlock.o test_rwlock.c
In file included from test_rwlock.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_rwlock.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
make[2]: *** [Makefile:1321: test_rwlock.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common   -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_perthreadlock.o test_perthreadlock.c
In file included from test_perthreadlock.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_perthreadlock.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
make[2]: *** [Makefile:1321: test_perthreadlock.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DDEBUG_YIELD  -O2 -g -grecord-gcc-switches -pipe
-Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2
-Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1
-fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m=
64
-mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection
-fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto
-flto-partition=3Dnone -c -o test_urcu_yield-test_urcu.o `test -f
'test_urcu.c' || echo './'`test_urcu.c
In file included from test_urcu.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../../tests/common/../common/debug-yield.h:34,
                 from test_urcu.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1678: test_urcu_yield-test_urcu.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DRCU_SIGNAL -DDEBUG_YIELD  -O2 -g
-grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security
-Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_signal_yield-test_urcu.o `test -f 'test_urcu.c' || echo
'./'`test_urcu.c
In file included from test_urcu.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../../tests/common/../common/debug-yield.h:34,
                 from test_urcu.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1622: test_urcu_signal_yield-test_urcu.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DRCU_MB  -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_mb-test_urcu.o `test -f 'test_urcu.c' || echo './'`test_urcu.c
In file included from test_urcu.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../../tests/common/../common/debug-yield.h:34,
                 from test_urcu.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1482: test_urcu_mb-test_urcu.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common   -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_qsbr.o test_urcu_qsbr.c
In file included from test_urcu_qsbr.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_qsbr.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../common/debug-yield.h:34,
                 from test_urcu_qsbr.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu_qsbr.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1321: test_urcu_qsbr.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common   -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_mutex.o test_mutex.c
In file included from test_mutex.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_mutex.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
make[2]: *** [Makefile:1321: test_mutex.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common   -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_gc.o test_urcu_gc.c
In file included from test_urcu_gc.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_gc.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../common/debug-yield.h:34,
                 from test_urcu_gc.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu_gc.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1321: test_urcu_gc.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DRCU_SIGNAL  -O2 -g -grecord-gcc-switches -pipe
-Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2
-Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1
-fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m=
64
-mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection
-fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto
-flto-partition=3Dnone -c -o test_urcu_signal_gc-test_urcu_gc.o `test -f
'test_urcu_gc.c' || echo './'`test_urcu_gc.c
In file included from test_urcu_gc.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_gc.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../common/debug-yield.h:34,
                 from test_urcu_gc.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu_gc.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1580: test_urcu_signal_gc-test_urcu_gc.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DTEST_LOCAL_GC  -O2 -g -grecord-gcc-switches -pipe
-Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2
-Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1
-fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m=
64
-mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection
-fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto
-flto-partition=3Dnone -c -o test_urcu_lgc-test_urcu_gc.o `test -f
'test_urcu_gc.c' || echo './'`test_urcu_gc.c
In file included from test_urcu_gc.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_gc.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../common/debug-yield.h:34,
                 from test_urcu_gc.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu_gc.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1468: test_urcu_lgc-test_urcu_gc.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DRCU_MB  -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_mb_gc-test_urcu_gc.o `test -f 'test_urcu_gc.c' || echo
'./'`test_urcu_gc.c
In file included from test_urcu_gc.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_gc.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../common/debug-yield.h:34,
                 from test_urcu_gc.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu_gc.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1496: test_urcu_mb_gc-test_urcu_gc.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common   -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_qsbr_gc.o test_urcu_qsbr_gc.c
In file included from test_urcu_qsbr_gc.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_qsbr_gc.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../common/debug-yield.h:34,
                 from test_urcu_qsbr_gc.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu_qsbr_gc.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1321: test_urcu_qsbr_gc.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DTEST_LOCAL_GC  -O2 -g -grecord-gcc-switches -pipe
-Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2
-Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1
-fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m=
64
-mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection
-fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto
-flto-partition=3Dnone -c -o test_urcu_qsbr_lgc-test_urcu_qsbr_gc.o `test -=
f
'test_urcu_qsbr_gc.c' || echo './'`test_urcu_qsbr_gc.c
In file included from test_urcu_qsbr_gc.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_qsbr_gc.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../common/debug-yield.h:34,
                 from test_urcu_qsbr_gc.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu_qsbr_gc.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1538: test_urcu_qsbr_lgc-test_urcu_qsbr_gc.o] Error =
1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DRCU_SIGNAL -DTEST_LOCAL_GC  -O2 -g
-grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security
-Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_signal_lgc-test_urcu_gc.o `test -f 'test_urcu_gc.c' || echo
'./'`test_urcu_gc.c
In file included from test_urcu_gc.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_gc.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../common/debug-yield.h:34,
                 from test_urcu_gc.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu_gc.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1594: test_urcu_signal_lgc-test_urcu_gc.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DTEST_LOCAL_GC -DRCU_MB  -O2 -g
-grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security
-Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_mb_lgc-test_urcu_gc.o `test -f 'test_urcu_gc.c' || echo
'./'`test_urcu_gc.c
In file included from test_urcu_gc.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_gc.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../common/debug-yield.h:34,
                 from test_urcu_gc.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu_gc.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1510: test_urcu_mb_lgc-test_urcu_gc.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DDYNAMIC_LINK_TEST  -O2 -g -grecord-gcc-switches
-pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2
-Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1
-fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m=
64
-mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection
-fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto
-flto-partition=3Dnone -c -o test_urcu_qsbr_dynamic_link-test_urcu_qsbr.o
`test -f 'test_urcu_qsbr.c' || echo './'`test_urcu_qsbr.c
In file included from test_urcu_qsbr.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_qsbr.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../common/debug-yield.h:34,
                 from test_urcu_qsbr.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu_qsbr.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1524: test_urcu_qsbr_dynamic_link-test_urcu_qsbr.o]
Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common   -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_defer.o test_urcu_defer.c
In file included from test_urcu_defer.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_defer.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../common/debug-yield.h:34,
                 from test_urcu_defer.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu_defer.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1321: test_urcu_defer.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common   -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_assign.o test_urcu_assign.c
In file included from test_urcu_assign.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_assign.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../common/debug-yield.h:34,
                 from test_urcu_assign.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu_assign.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1321: test_urcu_assign.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DDYNAMIC_LINK_TEST  -O2 -g -grecord-gcc-switches
-pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2
-Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1
-fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m=
64
-mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection
-fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto
-flto-partition=3Dnone -c -o test_urcu_assign_dynamic_link-test_urcu_assign=
.o
`test -f 'test_urcu_assign.c' || echo './'`test_urcu_assign.c
In file included from test_urcu_assign.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_assign.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../common/debug-yield.h:34,
                 from test_urcu_assign.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu_assign.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1342:
test_urcu_assign_dynamic_link-test_urcu_assign.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common   -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_bp.o test_urcu_bp.c
In file included from test_urcu_bp.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_bp.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../common/debug-yield.h:34,
                 from test_urcu_bp.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu_bp.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1321: test_urcu_bp.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DDYNAMIC_LINK_TEST  -O2 -g -grecord-gcc-switches
-pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2
-Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1
-fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m=
64
-mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection
-fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto
-flto-partition=3Dnone -c -o test_urcu_bp_dynamic_link-test_urcu_bp.o `test
-f 'test_urcu_bp.c' || echo './'`test_urcu_bp.c
In file included from test_urcu_bp.c:36:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_bp.c:24:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../common/debug-yield.h:34,
                 from test_urcu_bp.c:38:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu_bp.c:25:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
make[2]: *** [Makefile:1356: test_urcu_bp_dynamic_link-test_urcu_bp.o]
Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common   -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_lfq.o test_urcu_lfq.c
In file included from test_urcu_lfq.c:39:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_lfq.c:25:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
make[2]: *** [Makefile:1321: test_urcu_lfq.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common   -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_wfq.o test_urcu_wfq.c
In file included from test_urcu_wfq.c:39:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_wfq.c:25:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
make[2]: *** [Makefile:1321: test_urcu_wfq.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common   -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_lfs.o test_urcu_lfs.c
In file included from test_urcu_lfs.c:39:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_lfs.c:25:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
make[2]: *** [Makefile:1321: test_urcu_lfs.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common   -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_wfs.o test_urcu_wfs.c
In file included from test_urcu_wfs.c:40:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_wfs.c:25:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
make[2]: *** [Makefile:1321: test_urcu_wfs.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common   -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_lfs_rcu.o test_urcu_lfs_rcu.c
In file included from test_urcu_lfs_rcu.c:39:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_lfs_rcu.c:25:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
make[2]: *** [Makefile:1321: test_urcu_lfs_rcu.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common   -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_wfcq.o test_urcu_wfcq.c
In file included from test_urcu_wfcq.c:40:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_wfcq.c:25:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
make[2]: *** [Makefile:1321: test_urcu_wfcq.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DDYNAMIC_LINK_TEST  -O2 -g -grecord-gcc-switches
-pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2
-Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1
-fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m=
64
-mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection
-fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto
-flto-partition=3Dnone -c -o test_urcu_wfq_dynlink-test_urcu_wfq.o `test -f
'test_urcu_wfq.c' || echo './'`test_urcu_wfq.c
In file included from test_urcu_wfq.c:39:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_wfq.c:25:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
make[2]: *** [Makefile:1650: test_urcu_wfq_dynlink-test_urcu_wfq.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DDYNAMIC_LINK_TEST  -O2 -g -grecord-gcc-switches
-pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2
-Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1
-fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m=
64
-mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection
-fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto
-flto-partition=3Dnone -c -o test_urcu_wfs_dynlink-test_urcu_wfs.o `test -f
'test_urcu_wfs.c' || echo './'`test_urcu_wfs.c
In file included from test_urcu_wfs.c:40:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_wfs.c:25:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
make[2]: *** [Makefile:1664: test_urcu_wfs_dynlink-test_urcu_wfs.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DDYNAMIC_LINK_TEST  -O2 -g -grecord-gcc-switches
-pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2
-Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1
-fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m=
64
-mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection
-fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto
-flto-partition=3Dnone -c -o test_urcu_wfcq_dynlink-test_urcu_wfcq.o `test =
-f
'test_urcu_wfcq.c' || echo './'`test_urcu_wfcq.c
In file included from test_urcu_wfcq.c:40:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_wfcq.c:25:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
make[2]: *** [Makefile:1636: test_urcu_wfcq_dynlink-test_urcu_wfcq.o] Error
1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DDYNAMIC_LINK_TEST  -O2 -g -grecord-gcc-switches
-pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2
-Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1
-fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m=
64
-mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection
-fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto
-flto-partition=3Dnone -c -o test_urcu_lfq_dynlink-test_urcu_lfq.o `test -f
'test_urcu_lfq.c' || echo './'`test_urcu_lfq.c
In file included from test_urcu_lfq.c:39:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_lfq.c:25:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
make[2]: *** [Makefile:1426: test_urcu_lfq_dynlink-test_urcu_lfq.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DDYNAMIC_LINK_TEST  -O2 -g -grecord-gcc-switches
-pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2
-Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1
-fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m=
64
-mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection
-fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto
-flto-partition=3Dnone -c -o test_urcu_lfs_dynlink-test_urcu_lfs.o `test -f
'test_urcu_lfs.c' || echo './'`test_urcu_lfs.c
In file included from test_urcu_lfs.c:39:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_lfs.c:25:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
make[2]: *** [Makefile:1440: test_urcu_lfs_dynlink-test_urcu_lfs.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DRCU_QSBR  -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_hash-test_urcu_hash.o `test -f 'test_urcu_hash.c' || echo
'./'`test_urcu_hash.c
In file included from test_urcu_hash.h:39,
                 from test_urcu_hash.c:23:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu_hash.h:28,
                 from test_urcu_hash.c:23:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
In file included from test_urcu_hash.h:40,
                 from test_urcu_hash.c:23:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_hash.h:27,
                 from test_urcu_hash.c:23:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
make[2]: *** [Makefile:1384: test_urcu_hash-test_urcu_hash.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DRCU_QSBR  -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_hash-test_urcu_hash_rw.o `test -f 'test_urcu_hash_rw.c' || echo
'./'`test_urcu_hash_rw.c
In file included from test_urcu_hash.h:39,
                 from test_urcu_hash_rw.c:23:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu_hash.h:28,
                 from test_urcu_hash_rw.c:23:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
In file included from test_urcu_hash.h:40,
                 from test_urcu_hash_rw.c:23:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_hash.h:27,
                 from test_urcu_hash_rw.c:23:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
make[2]: *** [Makefile:1398: test_urcu_hash-test_urcu_hash_rw.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DRCU_QSBR  -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
test_urcu_hash-test_urcu_hash_unique.o `test -f 'test_urcu_hash_unique.c'
|| echo './'`test_urcu_hash_unique.c
In file included from test_urcu_hash.h:39,
                 from test_urcu_hash_unique.c:23:
../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=
=E2=80=99
follows non-static declaration
   38 | static inline int rand_r(unsigned int *seed)
      |                   ^~~~~~
In file included from test_urcu_hash.h:28,
                 from test_urcu_hash_unique.c:23:
/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=
=E2=80=99 with
type =E2=80=98int(unsigned int *)=E2=80=99
  459 | extern int rand_r (unsigned int *__seed) __THROW;
      |            ^~~~~~
In file included from test_urcu_hash.h:40,
                 from test_urcu_hash_unique.c:23:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_hash.h:27,
                 from test_urcu_hash_unique.c:23:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
make[2]: *** [Makefile:1412: test_urcu_hash-test_urcu_hash_unique.o] Error =
1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/common  -DDYNAMIC_LINK_TEST  -O2 -g -grecord-gcc-switches
-pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2
-Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1
-fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m=
64
-mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection
-fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto
-flto-partition=3Dnone -c -o test_urcu_lfs_rcu_dynlink-test_urcu_lfs_rcu.o
`test -f 'test_urcu_lfs_rcu.c' || echo './'`test_urcu_lfs_rcu.c
In file included from test_urcu_lfs_rcu.c:39:
../../tests/common/cpuset.h:32:23: error: conflicting types for
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from test_urcu_lfs_rcu.c:25:
/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cp=
u_set_t=E2=80=99
with type =E2=80=98cpu_set_t=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
make[2]: *** [Makefile:1454: test_urcu_lfs_rcu_dynlink-test_urcu_lfs_rcu.o]
Error 1
make[2]: Target 'all' not remade because of errors.
make[2]: Leaving directory
'/home/tkloczko/rpmbuild/BUILD/userspace-rcu-0.12.2/tests/benchmark'
Making all in regression
make[2]: Entering directory
'/home/tkloczko/rpmbuild/BUILD/userspace-rcu-0.12.2/tests/regression'
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/utils -I../../tests/common  -DRCU_MEMBARRIER  -O2 -g
-grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security
-Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
rcutorture_urcu_membarrier-urcutorture.o `test -f 'urcutorture.c' || echo
'./'`urcutorture.c
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from ../../tests/common/api.h:65,
                 from urcutorture.c:8:
/usr/include/bits/cpu-set.h:42:3: error: conflicting types for =E2=80=98cpu=
_set_t=E2=80=99;
have =E2=80=98struct <anonymous>=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../../tests/common/api.h:29,
                 from urcutorture.c:8:
../../tests/common/cpuset.h:32:23: note: previous declaration of
=E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99 {aka =E2=
=80=98long unsigned int=E2=80=99}
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
make[2]: *** [Makefile:1048: rcutorture_urcu_membarrier-urcutorture.o]
Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/utils -I../../tests/common  -DRCU_SIGNAL  -O2 -g
-grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security
-Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
rcutorture_urcu_signal-urcutorture.o `test -f 'urcutorture.c' || echo
'./'`urcutorture.c
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from ../../tests/common/api.h:65,
                 from urcutorture.c:8:
/usr/include/bits/cpu-set.h:42:3: error: conflicting types for =E2=80=98cpu=
_set_t=E2=80=99;
have =E2=80=98struct <anonymous>=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../../tests/common/api.h:29,
                 from urcutorture.c:8:
../../tests/common/cpuset.h:32:23: note: previous declaration of
=E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99 {aka =E2=
=80=98long unsigned int=E2=80=99}
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
make[2]: *** [Makefile:1076: rcutorture_urcu_signal-urcutorture.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/utils -I../../tests/common  -DRCU_MB  -O2 -g
-grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security
-Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
rcutorture_urcu_mb-urcutorture.o `test -f 'urcutorture.c' || echo
'./'`urcutorture.c
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from ../../tests/common/api.h:65,
                 from urcutorture.c:8:
/usr/include/bits/cpu-set.h:42:3: error: conflicting types for =E2=80=98cpu=
_set_t=E2=80=99;
have =E2=80=98struct <anonymous>=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../../tests/common/api.h:29,
                 from urcutorture.c:8:
../../tests/common/cpuset.h:32:23: note: previous declaration of
=E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99 {aka =E2=
=80=98long unsigned int=E2=80=99}
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
make[2]: *** [Makefile:1034: rcutorture_urcu_mb-urcutorture.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/utils -I../../tests/common  -DRCU_BP  -O2 -g
-grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security
-Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
rcutorture_urcu_bp-urcutorture.o `test -f 'urcutorture.c' || echo
'./'`urcutorture.c
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from ../../tests/common/api.h:65,
                 from urcutorture.c:8:
/usr/include/bits/cpu-set.h:42:3: error: conflicting types for =E2=80=98cpu=
_set_t=E2=80=99;
have =E2=80=98struct <anonymous>=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../../tests/common/api.h:29,
                 from urcutorture.c:8:
../../tests/common/cpuset.h:32:23: note: previous declaration of
=E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99 {aka =E2=
=80=98long unsigned int=E2=80=99}
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~
make[2]: *** [Makefile:1020: rcutorture_urcu_bp-urcutorture.o] Error 1
/usr/bin/gcc -DHAVE_CONFIG_H   -I../../include -I../../include -I../../src
-I../../tests/utils -I../../tests/common  -DTORTURE_QSBR -DRCU_QSBR  -O2 -g
-grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security
-Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o
rcutorture_urcu_qsbr-urcutorture.o `test -f 'urcutorture.c' || echo
'./'`urcutorture.c
In file included from /usr/include/sched.h:44,
                 from /usr/include/pthread.h:22,
                 from ../../tests/common/api.h:65,
                 from urcutorture.c:8:
/usr/include/bits/cpu-set.h:42:3: error: conflicting types for =E2=80=98cpu=
_set_t=E2=80=99;
have =E2=80=98struct <anonymous>=E2=80=99
   42 | } cpu_set_t;
      |   ^~~~~~~~~
In file included from ../../tests/common/api.h:29,
                 from urcutorture.c:8:
../../tests/common/cpuset.h:32:23: note: previous declaration of
=E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99 {aka =E2=
=80=98long unsigned int=E2=80=99}
   32 | typedef unsigned long cpu_set_t;
      |                       ^~~~~~~~~

kloczek
--=20
Tomasz K=C5=82oczko | LinkedIn: *http://lnkd.in/FXPWxH <http://lnkd.in/FXPW=
xH>*

--000000000000c85d1705bb925f81
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Hi,</div><div class=3D"gmail_default" style=3D"font-family:mon=
ospace,monospace"><br></div><div class=3D"gmail_default" style=3D"font-fami=
ly:monospace,monospace">Just tested=C2=A00.12.2 and lookd like build fails =
on compile test programs:</div><div class=3D"gmail_default" style=3D"font-f=
amily:monospace,monospace"><br></div><div class=3D"gmail_default" style=3D"=
font-family:monospace,monospace">make[2]: Entering directory &#39;/home/tkl=
oczko/rpmbuild/BUILD/userspace-rcu-0.12.2/tests/benchmark&#39;<br>/usr/bin/=
gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -I../../include -I../../src -I..=
/../tests/common =C2=A0 -O2 -g -grecord-gcc-switches -pipe -Wall -Werror=3D=
format-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=
=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=
=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fasynchron=
ous-unwind-tables -fstack-clash-protection -fcf-protection -fdata-sections =
-ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c -o test_urcu.o t=
est_urcu.c<br>In file included from test_urcu.c:36:<br>../../tests/common/c=
puset.h:32:23: error: conflicting types for =E2=80=98cpu_set_t=E2=80=99; ha=
ve =E2=80=98long unsigned int=E2=80=99<br>=C2=A0 =C2=A032 | typedef unsigne=
d long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file included=
 from /usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu.c:24:<br>/usr/i=
nclude/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cpu_set_=
t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu=
_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>In file included from=
 ../../tests/common/../common/debug-yield.h:34,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu.c:38:<br>../../src/com=
pat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=E2=80=99 fol=
lows non-static declaration<br>=C2=A0 =C2=A038 | static inline int rand_r(u=
nsigned int *seed)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>In file included from test_urc=
u.c:25:<br>/usr/include/stdlib.h:459:12: note: previous declaration of =E2=
=80=98rand_r=E2=80=99 with type =E2=80=98int(unsigned int *)=E2=80=99<br>=
=C2=A0 459 | extern int rand_r (unsigned int *__seed) __THROW;<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~<br>make[2]:=
 *** [Makefile:1321: test_urcu.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =
=C2=A0 -I../../include -I../../include -I../../src -I../../tests/common =C2=
=A0-DDYNAMIC_LINK_TEST =C2=A0-O2 -g -grecord-gcc-switches -pipe -Wall -Werr=
or=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -s=
pecs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -sp=
ecs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fasynch=
ronous-unwind-tables -fstack-clash-protection -fcf-protection -fdata-sectio=
ns -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c -o test_urcu_=
dynamic_link-test_urcu.o `test -f &#39;test_urcu.c&#39; || echo &#39;./&#39=
;`test_urcu.c<br>In file included from test_urcu.c:36:<br>../../tests/commo=
n/cpuset.h:32:23: error: conflicting types for =E2=80=98cpu_set_t=E2=80=99;=
 have =E2=80=98long unsigned int=E2=80=99<br>=C2=A0 =C2=A032 | typedef unsi=
gned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file inclu=
ded from /usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu.c:24:<br>/us=
r/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cpu_s=
et_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | } =
cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>In file included f=
rom ../../tests/common/../common/debug-yield.h:34,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu.c:38:<br>../../src/=
compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=E2=80=99 =
follows non-static declaration<br>=C2=A0 =C2=A038 | static inline int rand_=
r(unsigned int *seed)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>In file included from test_ur=
cu.c:25:<br>/usr/include/stdlib.h:459:12: note: previous declaration of =E2=
=80=98rand_r=E2=80=99 with type =E2=80=98int(unsigned int *)=E2=80=99<br>=
=C2=A0 459 | extern int rand_r (unsigned int *__seed) __THROW;<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~<br>make[2]:=
 *** [Makefile:1370: test_urcu_dynamic_link-test_urcu.o] Error 1<br>/usr/bi=
n/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -I../../include -I../../src -I=
../../tests/common =C2=A0-DRCU_SIGNAL =C2=A0-O2 -g -grecord-gcc-switches -p=
ipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCX=
X_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-prote=
ctor-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dg=
eneric -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protectio=
n -fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -=
c -o test_urcu_signal-test_urcu.o `test -f &#39;test_urcu.c&#39; || echo &#=
39;./&#39;`test_urcu.c<br>In file included from test_urcu.c:36:<br>../../te=
sts/common/cpuset.h:32:23: error: conflicting types for =E2=80=98cpu_set_t=
=E2=80=99; have =E2=80=98long unsigned int=E2=80=99<br>=C2=A0 =C2=A032 | ty=
pedef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In=
 file included from /usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu.c=
:24:<br>/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=
=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =
=C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>In fi=
le included from ../../tests/common/../common/debug-yield.h:34,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu.c:38:=
<br>../../src/compat-rand.h:38:19: error: static declaration of =E2=80=98ra=
nd_r=E2=80=99 follows non-static declaration<br>=C2=A0 =C2=A038 | static in=
line int rand_r(unsigned int *seed)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>In file include=
d from test_urcu.c:25:<br>/usr/include/stdlib.h:459:12: note: previous decl=
aration of =E2=80=98rand_r=E2=80=99 with type =E2=80=98int(unsigned int *)=
=E2=80=99<br>=C2=A0 459 | extern int rand_r (unsigned int *__seed) __THROW;=
<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~<=
br>make[2]: *** [Makefile:1552: test_urcu_signal-test_urcu.o] Error 1<br>/u=
sr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -I../../include -I../../s=
rc -I../../tests/common =C2=A0-DRCU_SIGNAL -DDYNAMIC_LINK_TEST =C2=A0-O2 -g=
 -grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY=
_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-h=
ardened-cc1 -fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-an=
nobin-cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-=
protection -fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto=
 -flto-partition=3Dnone -c -o test_urcu_signal_dynamic_link-test_urcu.o `te=
st -f &#39;test_urcu.c&#39; || echo &#39;./&#39;`test_urcu.c<br>In file inc=
luded from test_urcu.c:36:<br>../../tests/common/cpuset.h:32:23: error: con=
flicting types for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned=
 int=E2=80=99<br>=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file included from /usr/include/sched=
.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fro=
m /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from test_urcu.c:24:<br>/usr/include/bits/cpu-set.h:42:=
3: note: previous declaration of =E2=80=98cpu_set_t=E2=80=99 with type =E2=
=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 ^~~~~~~~~<br>In file included from ../../tests/common/../c=
ommon/debug-yield.h:34,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0from test_urcu.c:38:<br>../../src/compat-rand.h:38:19: error:=
 static declaration of =E2=80=98rand_r=E2=80=99 follows non-static declarat=
ion<br>=C2=A0 =C2=A038 | static inline int rand_r(unsigned int *seed)<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^~~~~~<br>In file included from test_urcu.c:25:<br>/usr/include/=
stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=E2=80=99 wit=
h type =E2=80=98int(unsigned int *)=E2=80=99<br>=C2=A0 459 | extern int ran=
d_r (unsigned int *__seed) __THROW;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~<br>make[2]: *** [Makefile:1566: test_urc=
u_signal_dynamic_link-test_urcu.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =
=C2=A0 -I../../include -I../../include -I../../src -I../../tests/common =C2=
=A0 -O2 -g -grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security -Wp,=
-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redha=
t/redhat-hardened-cc1 -fstack-protector-strong -specs=3D/usr/lib/rpm/redhat=
/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwind-tables -fst=
ack-clash-protection -fcf-protection -fdata-sections -ffunction-sections -f=
lto=3Dauto -flto-partition=3Dnone -c -o test_rwlock.o test_rwlock.c<br>In f=
ile included from test_rwlock.c:36:<br>../../tests/common/cpuset.h:32:23: e=
rror: conflicting types for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long=
 unsigned int=E2=80=99<br>=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t=
;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file included from /usr/inc=
lude/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0from /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_rwlock.c:24:<br>/usr/include/bits/=
cpu-set.h:42:3: note: previous declaration of =E2=80=98cpu_set_t=E2=80=99 w=
ith type =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>make[2]: *** [Makefile:1321: tes=
t_rwlock.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include =
-I../../include -I../../src -I../../tests/common =C2=A0 -O2 -g -grecord-gcc=
-switches -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -=
Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -=
fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m6=
4 -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection -f=
cf-protection -fdata-sections -ffunction-sections -flto=3Dauto -flto-partit=
ion=3Dnone -c -o test_perthreadlock.o test_perthreadlock.c<br>In file inclu=
ded from test_perthreadlock.c:36:<br>../../tests/common/cpuset.h:32:23: err=
or: conflicting types for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long u=
nsigned int=E2=80=99<br>=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<=
br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file included from /usr/include=
/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from test_perthreadlock.c:24:<br>/usr/include/bi=
ts/cpu-set.h:42:3: note: previous declaration of =E2=80=98cpu_set_t=E2=80=
=99 with type =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;=
<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>make[2]: *** [Makefile:1321:=
 test_perthreadlock.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../=
../include -I../../include -I../../src -I../../tests/common =C2=A0-DDEBUG_Y=
IELD =C2=A0-O2 -g -grecord-gcc-switches -pipe -Wall -Werror=3Dformat-securi=
ty -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rp=
m/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=3D/usr/lib/rpm=
/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwind-tabl=
es -fstack-clash-protection -fcf-protection -fdata-sections -ffunction-sect=
ions -flto=3Dauto -flto-partition=3Dnone -c -o test_urcu_yield-test_urcu.o =
`test -f &#39;test_urcu.c&#39; || echo &#39;./&#39;`test_urcu.c<br>In file =
included from test_urcu.c:36:<br>../../tests/common/cpuset.h:32:23: error: =
conflicting types for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsig=
ned int=E2=80=99<br>=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file included from /usr/include/sc=
hed.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
from /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu.c:24:<br>/usr/include/bits/cpu-set.h=
:42:3: note: previous declaration of =E2=80=98cpu_set_t=E2=80=99 with type =
=E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>In file included from ../../tests/common/.=
./common/debug-yield.h:34,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from test_urcu.c:38:<br>../../src/compat-rand.h:38:19: err=
or: static declaration of =E2=80=98rand_r=E2=80=99 follows non-static decla=
ration<br>=C2=A0 =C2=A038 | static inline int rand_r(unsigned int *seed)<br=
>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ^~~~~~<br>In file included from test_urcu.c:25:<br>/usr/inclu=
de/stdlib.h:459:12: note: previous declaration of =E2=80=98rand_r=E2=80=99 =
with type =E2=80=98int(unsigned int *)=E2=80=99<br>=C2=A0 459 | extern int =
rand_r (unsigned int *__seed) __THROW;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~<br>make[2]: *** [Makefile:1678: test_=
urcu_yield-test_urcu.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I..=
/../include -I../../include -I../../src -I../../tests/common =C2=A0-DRCU_SI=
GNAL -DDEBUG_YIELD =C2=A0-O2 -g -grecord-gcc-switches -pipe -Wall -Werror=
=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -spe=
cs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -spec=
s=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fasynchro=
nous-unwind-tables -fstack-clash-protection -fcf-protection -fdata-sections=
 -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c -o test_urcu_si=
gnal_yield-test_urcu.o `test -f &#39;test_urcu.c&#39; || echo &#39;./&#39;`=
test_urcu.c<br>In file included from test_urcu.c:36:<br>../../tests/common/=
cpuset.h:32:23: error: conflicting types for =E2=80=98cpu_set_t=E2=80=99; h=
ave =E2=80=98long unsigned int=E2=80=99<br>=C2=A0 =C2=A032 | typedef unsign=
ed long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file inclu=
ded from /usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu.c:24:<br>/us=
r/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cpu_s=
et_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | } =
cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>In file included f=
rom ../../tests/common/../common/debug-yield.h:34,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu.c:38:<br>../../src/=
compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=E2=80=99 =
follows non-static declaration<br>=C2=A0 =C2=A038 | static inline int rand_=
r(unsigned int *seed)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>In file included from test_ur=
cu.c:25:<br>/usr/include/stdlib.h:459:12: note: previous declaration of =E2=
=80=98rand_r=E2=80=99 with type =E2=80=98int(unsigned int *)=E2=80=99<br>=
=C2=A0 459 | extern int rand_r (unsigned int *__seed) __THROW;<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~<br>make[2]:=
 *** [Makefile:1622: test_urcu_signal_yield-test_urcu.o] Error 1<br>/usr/bi=
n/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -I../../include -I../../src -I=
../../tests/common =C2=A0-DRCU_MB =C2=A0-O2 -g -grecord-gcc-switches -pipe =
-Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_AS=
SERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector=
-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgener=
ic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection -f=
data-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c -o=
 test_urcu_mb-test_urcu.o `test -f &#39;test_urcu.c&#39; || echo &#39;./&#3=
9;`test_urcu.c<br>In file included from test_urcu.c:36:<br>../../tests/comm=
on/cpuset.h:32:23: error: conflicting types for =E2=80=98cpu_set_t=E2=80=99=
; have =E2=80=98long unsigned int=E2=80=99<br>=C2=A0 =C2=A032 | typedef uns=
igned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file incl=
uded from /usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu.c:24:<br>/u=
sr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cpu_=
set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | }=
 cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>In file included =
from ../../tests/common/../common/debug-yield.h:34,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu.c:38:<br>../../src=
/compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=E2=80=99=
 follows non-static declaration<br>=C2=A0 =C2=A038 | static inline int rand=
_r(unsigned int *seed)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>In file included from test=
_urcu.c:25:<br>/usr/include/stdlib.h:459:12: note: previous declaration of =
=E2=80=98rand_r=E2=80=99 with type =E2=80=98int(unsigned int *)=E2=80=99<br=
>=C2=A0 459 | extern int rand_r (unsigned int *__seed) __THROW;<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~<br>make[2]:=
 *** [Makefile:1482: test_urcu_mb-test_urcu.o] Error 1<br>/usr/bin/gcc -DHA=
VE_CONFIG_H =C2=A0 -I../../include -I../../include -I../../src -I../../test=
s/common =C2=A0 -O2 -g -grecord-gcc-switches -pipe -Wall -Werror=3Dformat-s=
ecurity -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/l=
ib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=3D/usr/li=
b/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwind=
-tables -fstack-clash-protection -fcf-protection -fdata-sections -ffunction=
-sections -flto=3Dauto -flto-partition=3Dnone -c -o test_urcu_qsbr.o test_u=
rcu_qsbr.c<br>In file included from test_urcu_qsbr.c:36:<br>../../tests/com=
mon/cpuset.h:32:23: error: conflicting types for =E2=80=98cpu_set_t=E2=80=
=99; have =E2=80=98long unsigned int=E2=80=99<br>=C2=A0 =C2=A032 | typedef =
unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file i=
ncluded from /usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_qsbr.c:2=
4:<br>/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=
=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =
=C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>In fi=
le included from ../common/debug-yield.h:34,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_qsbr.c:38:<br>../../src/c=
ompat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=E2=80=99 f=
ollows non-static declaration<br>=C2=A0 =C2=A038 | static inline int rand_r=
(unsigned int *seed)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>In file included from test_urc=
u_qsbr.c:25:<br>/usr/include/stdlib.h:459:12: note: previous declaration of=
 =E2=80=98rand_r=E2=80=99 with type =E2=80=98int(unsigned int *)=E2=80=99<b=
r>=C2=A0 459 | extern int rand_r (unsigned int *__seed) __THROW;<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~<br>make[2]:=
 *** [Makefile:1321: test_urcu_qsbr.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFI=
G_H =C2=A0 -I../../include -I../../include -I../../src -I../../tests/common=
 =C2=A0 -O2 -g -grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security =
-Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/r=
edhat/redhat-hardened-cc1 -fstack-protector-strong -specs=3D/usr/lib/rpm/re=
dhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwind-tables =
-fstack-clash-protection -fcf-protection -fdata-sections -ffunction-section=
s -flto=3Dauto -flto-partition=3Dnone -c -o test_mutex.o test_mutex.c<br>In=
 file included from test_mutex.c:36:<br>../../tests/common/cpuset.h:32:23: =
error: conflicting types for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98lon=
g unsigned int=E2=80=99<br>=C2=A0 =C2=A032 | typedef unsigned long cpu_set_=
t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file included from /usr/inc=
lude/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0from /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_mutex.c:24:<br>/usr/include/bits/c=
pu-set.h:42:3: note: previous declaration of =E2=80=98cpu_set_t=E2=80=99 wi=
th type =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>make[2]: *** [Makefile:1321: tes=
t_mutex.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -=
I../../include -I../../src -I../../tests/common =C2=A0 -O2 -g -grecord-gcc-=
switches -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -W=
p,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -f=
stack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64=
 -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection -fc=
f-protection -fdata-sections -ffunction-sections -flto=3Dauto -flto-partiti=
on=3Dnone -c -o test_urcu_gc.o test_urcu_gc.c<br>In file included from test=
_urcu_gc.c:36:<br>../../tests/common/cpuset.h:32:23: error: conflicting typ=
es for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=
=99<br>=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^~~~~~~~~<br>In file included from /usr/include/sched.h:44,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/inc=
lude/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0from test_urcu_gc.c:24:<br>/usr/include/bits/cpu-set.h:42:3: note=
: previous declaration of =E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cp=
u_set_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 ^~~~~~~~~<br>In file included from ../common/debug-yield.h:34,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urc=
u_gc.c:38:<br>../../src/compat-rand.h:38:19: error: static declaration of =
=E2=80=98rand_r=E2=80=99 follows non-static declaration<br>=C2=A0 =C2=A038 =
| static inline int rand_r(unsigned int *seed)<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>In=
 file included from test_urcu_gc.c:25:<br>/usr/include/stdlib.h:459:12: not=
e: previous declaration of =E2=80=98rand_r=E2=80=99 with type =E2=80=98int(=
unsigned int *)=E2=80=99<br>=C2=A0 459 | extern int rand_r (unsigned int *_=
_seed) __THROW;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0^~~~~~<br>make[2]: *** [Makefile:1321: test_urcu_gc.o] Error 1<br=
>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -I../../include -I../.=
./src -I../../tests/common =C2=A0-DRCU_SIGNAL =C2=A0-O2 -g -grecord-gcc-swi=
tches -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-=
D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fsta=
ck-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -m=
tune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection -fcf-p=
rotection -fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=
=3Dnone -c -o test_urcu_signal_gc-test_urcu_gc.o `test -f &#39;test_urcu_gc=
.c&#39; || echo &#39;./&#39;`test_urcu_gc.c<br>In file included from test_u=
rcu_gc.c:36:<br>../../tests/common/cpuset.h:32:23: error: conflicting types=
 for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99<=
br>=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ^~~~~~~~~<br>In file included from /usr/include/sched.h:44,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/includ=
e/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from test_urcu_gc.c:24:<br>/usr/include/bits/cpu-set.h:42:3: note: pr=
evious declaration of =E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_se=
t_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 ^~~~~~~~~<br>In file included from ../common/debug-yield.h:34,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urc=
u_gc.c:38:<br>../../src/compat-rand.h:38:19: error: static declaration of =
=E2=80=98rand_r=E2=80=99 follows non-static declaration<br>=C2=A0 =C2=A038 =
| static inline int rand_r(unsigned int *seed)<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>In=
 file included from test_urcu_gc.c:25:<br>/usr/include/stdlib.h:459:12: not=
e: previous declaration of =E2=80=98rand_r=E2=80=99 with type =E2=80=98int(=
unsigned int *)=E2=80=99<br>=C2=A0 459 | extern int rand_r (unsigned int *_=
_seed) __THROW;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0^~~~~~<br>make[2]: *** [Makefile:1580: test_urcu_signal_gc-test_u=
rcu_gc.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -I=
../../include -I../../src -I../../tests/common =C2=A0-DTEST_LOCAL_GC =C2=A0=
-O2 -g -grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security -Wp,-D_F=
ORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/re=
dhat-hardened-cc1 -fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/red=
hat-annobin-cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-=
clash-protection -fcf-protection -fdata-sections -ffunction-sections -flto=
=3Dauto -flto-partition=3Dnone -c -o test_urcu_lgc-test_urcu_gc.o `test -f =
&#39;test_urcu_gc.c&#39; || echo &#39;./&#39;`test_urcu_gc.c<br>In file inc=
luded from test_urcu_gc.c:36:<br>../../tests/common/cpuset.h:32:23: error: =
conflicting types for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsig=
ned int=E2=80=99<br>=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file included from /usr/include/sc=
hed.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
from /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_gc.c:24:<br>/usr/include/bits/cpu-se=
t.h:42:3: note: previous declaration of =E2=80=98cpu_set_t=E2=80=99 with ty=
pe =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>In file included from ../common/debug-y=
ield.h:34,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from test_urcu_gc.c:38:<br>../../src/compat-rand.h:38:19: error: static =
declaration of =E2=80=98rand_r=E2=80=99 follows non-static declaration<br>=
=C2=A0 =C2=A038 | static inline int rand_r(unsigned int *seed)<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ^~~~~~<br>In file included from test_urcu_gc.c:25:<br>/usr/include/stdl=
ib.h:459:12: note: previous declaration of =E2=80=98rand_r=E2=80=99 with ty=
pe =E2=80=98int(unsigned int *)=E2=80=99<br>=C2=A0 459 | extern int rand_r =
(unsigned int *__seed) __THROW;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~<br>make[2]: *** [Makefile:1468: test_urcu_lg=
c-test_urcu_gc.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../in=
clude -I../../include -I../../src -I../../tests/common =C2=A0-DRCU_MB =C2=
=A0-O2 -g -grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security -Wp,-=
D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat=
/redhat-hardened-cc1 -fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/=
redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwind-tables -fsta=
ck-clash-protection -fcf-protection -fdata-sections -ffunction-sections -fl=
to=3Dauto -flto-partition=3Dnone -c -o test_urcu_mb_gc-test_urcu_gc.o `test=
 -f &#39;test_urcu_gc.c&#39; || echo &#39;./&#39;`test_urcu_gc.c<br>In file=
 included from test_urcu_gc.c:36:<br>../../tests/common/cpuset.h:32:23: err=
or: conflicting types for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long u=
nsigned int=E2=80=99<br>=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<=
br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file included from /usr/include=
/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_gc.c:24:<br>/usr/include/bits/cpu=
-set.h:42:3: note: previous declaration of =E2=80=98cpu_set_t=E2=80=99 with=
 type =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>In file included from ../common/deb=
ug-yield.h:34,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from test_urcu_gc.c:38:<br>../../src/compat-rand.h:38:19: error: stat=
ic declaration of =E2=80=98rand_r=E2=80=99 follows non-static declaration<b=
r>=C2=A0 =C2=A038 | static inline int rand_r(unsigned int *seed)<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ^~~~~~<br>In file included from test_urcu_gc.c:25:<br>/usr/include/stdl=
ib.h:459:12: note: previous declaration of =E2=80=98rand_r=E2=80=99 with ty=
pe =E2=80=98int(unsigned int *)=E2=80=99<br>=C2=A0 459 | extern int rand_r =
(unsigned int *__seed) __THROW;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~<br>make[2]: *** [Makefile:1496: test_urcu_mb=
_gc-test_urcu_gc.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../=
include -I../../include -I../../src -I../../tests/common =C2=A0 -O2 -g -gre=
cord-gcc-switches -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOUR=
CE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-harden=
ed-cc1 -fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin=
-cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-prote=
ction -fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto -flt=
o-partition=3Dnone -c -o test_urcu_qsbr_gc.o test_urcu_qsbr_gc.c<br>In file=
 included from test_urcu_qsbr_gc.c:36:<br>../../tests/common/cpuset.h:32:23=
: error: conflicting types for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98l=
ong unsigned int=E2=80=99<br>=C2=A0 =C2=A032 | typedef unsigned long cpu_se=
t_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file included from /usr/=
include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0from /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_qsbr_gc.c:24:<br>/usr/incl=
ude/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cpu_set_t=
=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_=
set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>In file included from =
../common/debug-yield.h:34,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from test_urcu_qsbr_gc.c:38:<br>../../src/compat-rand.h=
:38:19: error: static declaration of =E2=80=98rand_r=E2=80=99 follows non-s=
tatic declaration<br>=C2=A0 =C2=A038 | static inline int rand_r(unsigned in=
t *seed)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>In file included from test_urcu_qsbr_gc.=
c:25:<br>/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=
=98rand_r=E2=80=99 with type =E2=80=98int(unsigned int *)=E2=80=99<br>=C2=
=A0 459 | extern int rand_r (unsigned int *__seed) __THROW;<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~<br>make[2]: **=
* [Makefile:1321: test_urcu_qsbr_gc.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFI=
G_H =C2=A0 -I../../include -I../../include -I../../src -I../../tests/common=
 =C2=A0-DTEST_LOCAL_GC =C2=A0-O2 -g -grecord-gcc-switches -pipe -Wall -Werr=
or=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -s=
pecs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -sp=
ecs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fasynch=
ronous-unwind-tables -fstack-clash-protection -fcf-protection -fdata-sectio=
ns -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c -o test_urcu_=
qsbr_lgc-test_urcu_qsbr_gc.o `test -f &#39;test_urcu_qsbr_gc.c&#39; || echo=
 &#39;./&#39;`test_urcu_qsbr_gc.c<br>In file included from test_urcu_qsbr_g=
c.c:36:<br>../../tests/common/cpuset.h:32:23: error: conflicting types for =
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99<br>=
=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ^~~~~~~~~<br>In file included from /usr/include/sched.h:44,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pt=
hread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from test_urcu_qsbr_gc.c:24:<br>/usr/include/bits/cpu-set.h:42:3: note: =
previous declaration of =E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_=
set_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 ^~~~~~~~~<br>In file included from ../common/debug-yield.h:34,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urc=
u_qsbr_gc.c:38:<br>../../src/compat-rand.h:38:19: error: static declaration=
 of =E2=80=98rand_r=E2=80=99 follows non-static declaration<br>=C2=A0 =C2=
=A038 | static inline int rand_r(unsigned int *seed)<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~=
<br>In file included from test_urcu_qsbr_gc.c:25:<br>/usr/include/stdlib.h:=
459:12: note: previous declaration of =E2=80=98rand_r=E2=80=99 with type =
=E2=80=98int(unsigned int *)=E2=80=99<br>=C2=A0 459 | extern int rand_r (un=
signed int *__seed) __THROW;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0^~~~~~<br>make[2]: *** [Makefile:1538: test_urcu_qsbr_=
lgc-test_urcu_qsbr_gc.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I.=
./../include -I../../include -I../../src -I../../tests/common =C2=A0-DRCU_S=
IGNAL -DTEST_LOCAL_GC =C2=A0-O2 -g -grecord-gcc-switches -pipe -Wall -Werro=
r=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -sp=
ecs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -spe=
cs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fasynchr=
onous-unwind-tables -fstack-clash-protection -fcf-protection -fdata-section=
s -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c -o test_urcu_s=
ignal_lgc-test_urcu_gc.o `test -f &#39;test_urcu_gc.c&#39; || echo &#39;./&=
#39;`test_urcu_gc.c<br>In file included from test_urcu_gc.c:36:<br>../../te=
sts/common/cpuset.h:32:23: error: conflicting types for =E2=80=98cpu_set_t=
=E2=80=99; have =E2=80=98long unsigned int=E2=80=99<br>=C2=A0 =C2=A032 | ty=
pedef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In=
 file included from /usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_g=
c.c:24:<br>/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =
=E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0=
 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>In f=
ile included from ../common/debug-yield.h:34,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_gc.c:38:<br>../../src/=
compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=E2=80=99 =
follows non-static declaration<br>=C2=A0 =C2=A038 | static inline int rand_=
r(unsigned int *seed)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>In file included from test_ur=
cu_gc.c:25:<br>/usr/include/stdlib.h:459:12: note: previous declaration of =
=E2=80=98rand_r=E2=80=99 with type =E2=80=98int(unsigned int *)=E2=80=99<br=
>=C2=A0 459 | extern int rand_r (unsigned int *__seed) __THROW;<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~<br>make[2]:=
 *** [Makefile:1594: test_urcu_signal_lgc-test_urcu_gc.o] Error 1<br>/usr/b=
in/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -I../../include -I../../src -=
I../../tests/common =C2=A0-DTEST_LOCAL_GC -DRCU_MB =C2=A0-O2 -g -grecord-gc=
c-switches -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 =
-Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 =
-fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m=
64 -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection -=
fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto -flto-parti=
tion=3Dnone -c -o test_urcu_mb_lgc-test_urcu_gc.o `test -f &#39;test_urcu_g=
c.c&#39; || echo &#39;./&#39;`test_urcu_gc.c<br>In file included from test_=
urcu_gc.c:36:<br>../../tests/common/cpuset.h:32:23: error: conflicting type=
s for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99=
<br>=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ^~~~~~~~~<br>In file included from /usr/include/sched.h:44,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/includ=
e/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from test_urcu_gc.c:24:<br>/usr/include/bits/cpu-set.h:42:3: note: pr=
evious declaration of =E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_se=
t_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 ^~~~~~~~~<br>In file included from ../common/debug-yield.h:34,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urc=
u_gc.c:38:<br>../../src/compat-rand.h:38:19: error: static declaration of =
=E2=80=98rand_r=E2=80=99 follows non-static declaration<br>=C2=A0 =C2=A038 =
| static inline int rand_r(unsigned int *seed)<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>In=
 file included from test_urcu_gc.c:25:<br>/usr/include/stdlib.h:459:12: not=
e: previous declaration of =E2=80=98rand_r=E2=80=99 with type =E2=80=98int(=
unsigned int *)=E2=80=99<br>=C2=A0 459 | extern int rand_r (unsigned int *_=
_seed) __THROW;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0^~~~~~<br>make[2]: *** [Makefile:1510: test_urcu_mb_lgc-test_urcu=
_gc.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -I../=
../include -I../../src -I../../tests/common =C2=A0-DDYNAMIC_LINK_TEST =C2=
=A0-O2 -g -grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security -Wp,-=
D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat=
/redhat-hardened-cc1 -fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/=
redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwind-tables -fsta=
ck-clash-protection -fcf-protection -fdata-sections -ffunction-sections -fl=
to=3Dauto -flto-partition=3Dnone -c -o test_urcu_qsbr_dynamic_link-test_urc=
u_qsbr.o `test -f &#39;test_urcu_qsbr.c&#39; || echo &#39;./&#39;`test_urcu=
_qsbr.c<br>In file included from test_urcu_qsbr.c:36:<br>../../tests/common=
/cpuset.h:32:23: error: conflicting types for =E2=80=98cpu_set_t=E2=80=99; =
have =E2=80=98long unsigned int=E2=80=99<br>=C2=A0 =C2=A032 | typedef unsig=
ned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file inclu=
ded from /usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_qsbr.c:24:<b=
r>/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98=
cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042=
 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>In file inclu=
ded from ../common/debug-yield.h:34,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_qsbr.c:38:<br>../../src/compat-ra=
nd.h:38:19: error: static declaration of =E2=80=98rand_r=E2=80=99 follows n=
on-static declaration<br>=C2=A0 =C2=A038 | static inline int rand_r(unsigne=
d int *seed)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>In file included from test_urcu_qsbr.=
c:25:<br>/usr/include/stdlib.h:459:12: note: previous declaration of =E2=80=
=98rand_r=E2=80=99 with type =E2=80=98int(unsigned int *)=E2=80=99<br>=C2=
=A0 459 | extern int rand_r (unsigned int *__seed) __THROW;<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~<br>make[2]: **=
* [Makefile:1524: test_urcu_qsbr_dynamic_link-test_urcu_qsbr.o] Error 1<br>=
/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -I../../include -I../..=
/src -I../../tests/common =C2=A0 -O2 -g -grecord-gcc-switches -pipe -Wall -=
Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTION=
S -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong=
 -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fas=
ynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fdata-se=
ctions -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c -o test_u=
rcu_defer.o test_urcu_defer.c<br>In file included from test_urcu_defer.c:36=
:<br>../../tests/common/cpuset.h:32:23: error: conflicting types for =E2=80=
=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99<br>=C2=A0 =
=C2=A032 | typedef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^=
~~~~~~~~<br>In file included from /usr/include/sched.h:44,<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.=
h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from=
 test_urcu_defer.c:24:<br>/usr/include/bits/cpu-set.h:42:3: note: previous =
declaration of =E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=
=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^=
~~~~~~~~<br>In file included from ../common/debug-yield.h:34,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_defer.c:=
38:<br>../../src/compat-rand.h:38:19: error: static declaration of =E2=80=
=98rand_r=E2=80=99 follows non-static declaration<br>=C2=A0 =C2=A038 | stat=
ic inline int rand_r(unsigned int *seed)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>In file i=
ncluded from test_urcu_defer.c:25:<br>/usr/include/stdlib.h:459:12: note: p=
revious declaration of =E2=80=98rand_r=E2=80=99 with type =E2=80=98int(unsi=
gned int *)=E2=80=99<br>=C2=A0 459 | extern int rand_r (unsigned int *__see=
d) __THROW;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0^~~~~~<br>make[2]: *** [Makefile:1321: test_urcu_defer.o] Error 1<br>=
/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -I../../include -I../..=
/src -I../../tests/common =C2=A0 -O2 -g -grecord-gcc-switches -pipe -Wall -=
Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTION=
S -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong=
 -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fas=
ynchronous-unwind-tables -fstack-clash-protection -fcf-protection -fdata-se=
ctions -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c -o test_u=
rcu_assign.o test_urcu_assign.c<br>In file included from test_urcu_assign.c=
:36:<br>../../tests/common/cpuset.h:32:23: error: conflicting types for =E2=
=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99<br>=C2=
=A0 =C2=A032 | typedef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ^~~~~~~~~<br>In file included from /usr/include/sched.h:44,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pt=
hread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from test_urcu_assign.c:24:<br>/usr/include/bits/cpu-set.h:42:3: note: p=
revious declaration of =E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_s=
et_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 ^~~~~~~~~<br>In file included from ../common/debug-yield.h:34,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urc=
u_assign.c:38:<br>../../src/compat-rand.h:38:19: error: static declaration =
of =E2=80=98rand_r=E2=80=99 follows non-static declaration<br>=C2=A0 =C2=A0=
38 | static inline int rand_r(unsigned int *seed)<br>=C2=A0 =C2=A0 =C2=A0 |=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>I=
n file included from test_urcu_assign.c:25:<br>/usr/include/stdlib.h:459:12=
: note: previous declaration of =E2=80=98rand_r=E2=80=99 with type =E2=80=
=98int(unsigned int *)=E2=80=99<br>=C2=A0 459 | extern int rand_r (unsigned=
 int *__seed) __THROW;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0^~~~~~<br>make[2]: *** [Makefile:1321: test_urcu_assign.o]=
 Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -I../../inc=
lude -I../../src -I../../tests/common =C2=A0-DDYNAMIC_LINK_TEST =C2=A0-O2 -=
g -grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIF=
Y_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-=
hardened-cc1 -fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-a=
nnobin-cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash=
-protection -fcf-protection -fdata-sections -ffunction-sections -flto=3Daut=
o -flto-partition=3Dnone -c -o test_urcu_assign_dynamic_link-test_urcu_assi=
gn.o `test -f &#39;test_urcu_assign.c&#39; || echo &#39;./&#39;`test_urcu_a=
ssign.c<br>In file included from test_urcu_assign.c:36:<br>../../tests/comm=
on/cpuset.h:32:23: error: conflicting types for =E2=80=98cpu_set_t=E2=80=99=
; have =E2=80=98long unsigned int=E2=80=99<br>=C2=A0 =C2=A032 | typedef uns=
igned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file incl=
uded from /usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_assign.c:24=
:<br>/usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=
=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=
=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>In file =
included from ../common/debug-yield.h:34,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_assign.c:38:<br>../../src/=
compat-rand.h:38:19: error: static declaration of =E2=80=98rand_r=E2=80=99 =
follows non-static declaration<br>=C2=A0 =C2=A038 | static inline int rand_=
r(unsigned int *seed)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>In file included from test_ur=
cu_assign.c:25:<br>/usr/include/stdlib.h:459:12: note: previous declaration=
 of =E2=80=98rand_r=E2=80=99 with type =E2=80=98int(unsigned int *)=E2=80=
=99<br>=C2=A0 459 | extern int rand_r (unsigned int *__seed) __THROW;<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~<br>m=
ake[2]: *** [Makefile:1342: test_urcu_assign_dynamic_link-test_urcu_assign.=
o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -I../../i=
nclude -I../../src -I../../tests/common =C2=A0 -O2 -g -grecord-gcc-switches=
 -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLI=
BCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-pr=
otector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=
=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection -fcf-prote=
ction -fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dno=
ne -c -o test_urcu_bp.o test_urcu_bp.c<br>In file included from test_urcu_b=
p.c:36:<br>../../tests/common/cpuset.h:32:23: error: conflicting types for =
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99<br>=
=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ^~~~~~~~~<br>In file included from /usr/include/sched.h:44,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pt=
hread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from test_urcu_bp.c:24:<br>/usr/include/bits/cpu-set.h:42:3: note: previ=
ous declaration of =E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=
=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 ^~~~~~~~~<br>In file included from ../common/debug-yield.h:34,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_b=
p.c:38:<br>../../src/compat-rand.h:38:19: error: static declaration of =E2=
=80=98rand_r=E2=80=99 follows non-static declaration<br>=C2=A0 =C2=A038 | s=
tatic inline int rand_r(unsigned int *seed)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>In fi=
le included from test_urcu_bp.c:25:<br>/usr/include/stdlib.h:459:12: note: =
previous declaration of =E2=80=98rand_r=E2=80=99 with type =E2=80=98int(uns=
igned int *)=E2=80=99<br>=C2=A0 459 | extern int rand_r (unsigned int *__se=
ed) __THROW;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0^~~~~~<br>make[2]: *** [Makefile:1321: test_urcu_bp.o] Error 1<br>/us=
r/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -I../../include -I../../sr=
c -I../../tests/common =C2=A0-DDYNAMIC_LINK_TEST =C2=A0-O2 -g -grecord-gcc-=
switches -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -W=
p,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -f=
stack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64=
 -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection -fc=
f-protection -fdata-sections -ffunction-sections -flto=3Dauto -flto-partiti=
on=3Dnone -c -o test_urcu_bp_dynamic_link-test_urcu_bp.o `test -f &#39;test=
_urcu_bp.c&#39; || echo &#39;./&#39;`test_urcu_bp.c<br>In file included fro=
m test_urcu_bp.c:36:<br>../../tests/common/cpuset.h:32:23: error: conflicti=
ng types for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=
=E2=80=99<br>=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file included from /usr/include/sched.h:4=
4,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /u=
sr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from test_urcu_bp.c:24:<br>/usr/include/bits/cpu-set.h:42:=
3: note: previous declaration of =E2=80=98cpu_set_t=E2=80=99 with type =E2=
=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 ^~~~~~~~~<br>In file included from ../common/debug-yield.h=
:34,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from =
test_urcu_bp.c:38:<br>../../src/compat-rand.h:38:19: error: static declarat=
ion of =E2=80=98rand_r=E2=80=99 follows non-static declaration<br>=C2=A0 =
=C2=A038 | static inline int rand_r(unsigned int *seed)<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~=
~~~<br>In file included from test_urcu_bp.c:25:<br>/usr/include/stdlib.h:45=
9:12: note: previous declaration of =E2=80=98rand_r=E2=80=99 with type =E2=
=80=98int(unsigned int *)=E2=80=99<br>=C2=A0 459 | extern int rand_r (unsig=
ned int *__seed) __THROW;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0^~~~~~<br>make[2]: *** [Makefile:1356: test_urcu_bp_dyn=
amic_link-test_urcu_bp.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I=
../../include -I../../include -I../../src -I../../tests/common =C2=A0 -O2 -=
g -grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIF=
Y_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-=
hardened-cc1 -fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-a=
nnobin-cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash=
-protection -fcf-protection -fdata-sections -ffunction-sections -flto=3Daut=
o -flto-partition=3Dnone -c -o test_urcu_lfq.o test_urcu_lfq.c<br>In file i=
ncluded from test_urcu_lfq.c:39:<br>../../tests/common/cpuset.h:32:23: erro=
r: conflicting types for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long un=
signed int=E2=80=99<br>=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<b=
r>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file included from /usr/include=
/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_lfq.c:25:<br>/usr/include/bits/cp=
u-set.h:42:3: note: previous declaration of =E2=80=98cpu_set_t=E2=80=99 wit=
h type =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>make[2]: *** [Makefile:1321: test_u=
rcu_lfq.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -=
I../../include -I../../src -I../../tests/common =C2=A0 -O2 -g -grecord-gcc-=
switches -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -W=
p,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -f=
stack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64=
 -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection -fc=
f-protection -fdata-sections -ffunction-sections -flto=3Dauto -flto-partiti=
on=3Dnone -c -o test_urcu_wfq.o test_urcu_wfq.c<br>In file included from te=
st_urcu_wfq.c:39:<br>../../tests/common/cpuset.h:32:23: error: conflicting =
types for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=
=80=99<br>=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file included from /usr/include/sched.h:44,<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/=
include/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from test_urcu_wfq.c:25:<br>/usr/include/bits/cpu-set.h:42:3: =
note: previous declaration of =E2=80=98cpu_set_t=E2=80=99 with type =E2=80=
=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 ^~~~~~~~~<br>make[2]: *** [Makefile:1321: test_urcu_wfq.o] =
Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -I../../incl=
ude -I../../src -I../../tests/common =C2=A0 -O2 -g -grecord-gcc-switches -p=
ipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCX=
X_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-prote=
ctor-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dg=
eneric -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protectio=
n -fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -=
c -o test_urcu_lfs.o test_urcu_lfs.c<br>In file included from test_urcu_lfs=
.c:39:<br>../../tests/common/cpuset.h:32:23: error: conflicting types for =
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99<br>=
=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ^~~~~~~~~<br>In file included from /usr/include/sched.h:44,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pt=
hread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from test_urcu_lfs.c:25:<br>/usr/include/bits/cpu-set.h:42:3: note: prev=
ious declaration of =E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_=
t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 ^~~~~~~~~<br>make[2]: *** [Makefile:1321: test_urcu_lfs.o] Error 1<br>/=
usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -I../../include -I../../=
src -I../../tests/common =C2=A0 -O2 -g -grecord-gcc-switches -pipe -Wall -W=
error=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS=
 -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong =
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fasy=
nchronous-unwind-tables -fstack-clash-protection -fcf-protection -fdata-sec=
tions -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c -o test_ur=
cu_wfs.o test_urcu_wfs.c<br>In file included from test_urcu_wfs.c:40:<br>..=
/../tests/common/cpuset.h:32:23: error: conflicting types for =E2=80=98cpu_=
set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99<br>=C2=A0 =C2=A032=
 | typedef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<b=
r>In file included from /usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_ur=
cu_wfs.c:25:<br>/usr/include/bits/cpu-set.h:42:3: note: previous declaratio=
n of =E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99<br>=
=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<b=
r>make[2]: *** [Makefile:1321: test_urcu_wfs.o] Error 1<br>/usr/bin/gcc -DH=
AVE_CONFIG_H =C2=A0 -I../../include -I../../include -I../../src -I../../tes=
ts/common =C2=A0 -O2 -g -grecord-gcc-switches -pipe -Wall -Werror=3Dformat-=
security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/=
lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=3D/usr/l=
ib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwin=
d-tables -fstack-clash-protection -fcf-protection -fdata-sections -ffunctio=
n-sections -flto=3Dauto -flto-partition=3Dnone -c -o test_urcu_lfs_rcu.o te=
st_urcu_lfs_rcu.c<br>In file included from test_urcu_lfs_rcu.c:39:<br>../..=
/tests/common/cpuset.h:32:23: error: conflicting types for =E2=80=98cpu_set=
_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99<br>=C2=A0 =C2=A032 | =
typedef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br=
>In file included from /usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urc=
u_lfs_rcu.c:25:<br>/usr/include/bits/cpu-set.h:42:3: note: previous declara=
tion of =E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99<b=
r>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~=
<br>make[2]: *** [Makefile:1321: test_urcu_lfs_rcu.o] Error 1<br>/usr/bin/g=
cc -DHAVE_CONFIG_H =C2=A0 -I../../include -I../../include -I../../src -I../=
../tests/common =C2=A0 -O2 -g -grecord-gcc-switches -pipe -Wall -Werror=3Df=
ormat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=
=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=
=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fasynchron=
ous-unwind-tables -fstack-clash-protection -fcf-protection -fdata-sections =
-ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c -o test_urcu_wfc=
q.o test_urcu_wfcq.c<br>In file included from test_urcu_wfcq.c:40:<br>../..=
/tests/common/cpuset.h:32:23: error: conflicting types for =E2=80=98cpu_set=
_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99<br>=C2=A0 =C2=A032 | =
typedef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br=
>In file included from /usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urc=
u_wfcq.c:25:<br>/usr/include/bits/cpu-set.h:42:3: note: previous declaratio=
n of =E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99<br>=
=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<b=
r>make[2]: *** [Makefile:1321: test_urcu_wfcq.o] Error 1<br>/usr/bin/gcc -D=
HAVE_CONFIG_H =C2=A0 -I../../include -I../../include -I../../src -I../../te=
sts/common =C2=A0-DDYNAMIC_LINK_TEST =C2=A0-O2 -g -grecord-gcc-switches -pi=
pe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX=
_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protec=
tor-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dge=
neric -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection=
 -fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c=
 -o test_urcu_wfq_dynlink-test_urcu_wfq.o `test -f &#39;test_urcu_wfq.c&#39=
; || echo &#39;./&#39;`test_urcu_wfq.c<br>In file included from test_urcu_w=
fq.c:39:<br>../../tests/common/cpuset.h:32:23: error: conflicting types for=
 =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99<br>=
=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 =
| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ^~~~~~~~~<br>In file included from /usr/include/sched.h:44,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pt=
hread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from test_urcu_wfq.c:25:<br>/usr/include/bits/cpu-set.h:42:3: note: prev=
ious declaration of =E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_=
t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 ^~~~~~~~~<br>make[2]: *** [Makefile:1650: test_urcu_wfq_dynlink-test_ur=
cu_wfq.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -I=
../../include -I../../src -I../../tests/common =C2=A0-DDYNAMIC_LINK_TEST =
=C2=A0-O2 -g -grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security -W=
p,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/red=
hat/redhat-hardened-cc1 -fstack-protector-strong -specs=3D/usr/lib/rpm/redh=
at/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwind-tables -f=
stack-clash-protection -fcf-protection -fdata-sections -ffunction-sections =
-flto=3Dauto -flto-partition=3Dnone -c -o test_urcu_wfs_dynlink-test_urcu_w=
fs.o `test -f &#39;test_urcu_wfs.c&#39; || echo &#39;./&#39;`test_urcu_wfs.=
c<br>In file included from test_urcu_wfs.c:40:<br>../../tests/common/cpuset=
.h:32:23: error: conflicting types for =E2=80=98cpu_set_t=E2=80=99; have =
=E2=80=98long unsigned int=E2=80=99<br>=C2=A0 =C2=A032 | typedef unsigned l=
ong cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file included fr=
om /usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_wfs.c:25:<br>/usr/=
include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cpu_set=
_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | } cp=
u_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>make[2]: *** [Makefi=
le:1664: test_urcu_wfs_dynlink-test_urcu_wfs.o] Error 1<br>/usr/bin/gcc -DH=
AVE_CONFIG_H =C2=A0 -I../../include -I../../include -I../../src -I../../tes=
ts/common =C2=A0-DDYNAMIC_LINK_TEST =C2=A0-O2 -g -grecord-gcc-switches -pip=
e -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_=
ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protect=
or-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgen=
eric -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection =
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c =
-o test_urcu_wfcq_dynlink-test_urcu_wfcq.o `test -f &#39;test_urcu_wfcq.c&#=
39; || echo &#39;./&#39;`test_urcu_wfcq.c<br>In file included from test_urc=
u_wfcq.c:40:<br>../../tests/common/cpuset.h:32:23: error: conflicting types=
 for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99<=
br>=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ^~~~~~~~~<br>In file included from /usr/include/sched.h:44,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/includ=
e/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from test_urcu_wfcq.c:25:<br>/usr/include/bits/cpu-set.h:42:3: note: =
previous declaration of =E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_=
set_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 ^~~~~~~~~<br>make[2]: *** [Makefile:1636: test_urcu_wfcq_dynlink-tes=
t_urcu_wfcq.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../inclu=
de -I../../include -I../../src -I../../tests/common =C2=A0-DDYNAMIC_LINK_TE=
ST =C2=A0-O2 -g -grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security=
 -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/=
redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=3D/usr/lib/rpm/r=
edhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwind-tables=
 -fstack-clash-protection -fcf-protection -fdata-sections -ffunction-sectio=
ns -flto=3Dauto -flto-partition=3Dnone -c -o test_urcu_lfq_dynlink-test_urc=
u_lfq.o `test -f &#39;test_urcu_lfq.c&#39; || echo &#39;./&#39;`test_urcu_l=
fq.c<br>In file included from test_urcu_lfq.c:39:<br>../../tests/common/cpu=
set.h:32:23: error: conflicting types for =E2=80=98cpu_set_t=E2=80=99; have=
 =E2=80=98long unsigned int=E2=80=99<br>=C2=A0 =C2=A032 | typedef unsigned =
long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file included=
 from /usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_lfq.c:25:<br>/u=
sr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cpu_=
set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | }=
 cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>make[2]: *** [Mak=
efile:1426: test_urcu_lfq_dynlink-test_urcu_lfq.o] Error 1<br>/usr/bin/gcc =
-DHAVE_CONFIG_H =C2=A0 -I../../include -I../../include -I../../src -I../../=
tests/common =C2=A0-DDYNAMIC_LINK_TEST =C2=A0-O2 -g -grecord-gcc-switches -=
pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBC=
XX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-prot=
ector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3D=
generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protecti=
on -fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone =
-c -o test_urcu_lfs_dynlink-test_urcu_lfs.o `test -f &#39;test_urcu_lfs.c&#=
39; || echo &#39;./&#39;`test_urcu_lfs.c<br>In file included from test_urcu=
_lfs.c:39:<br>../../tests/common/cpuset.h:32:23: error: conflicting types f=
or =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99<br=
>=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ^~~~~~~~~<br>In file included from /usr/include/sched.h:44,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/includ=
e/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from test_urcu_lfs.c:25:<br>/usr/include/bits/cpu-set.h:42:3: note: p=
revious declaration of =E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_s=
et_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 ^~~~~~~~~<br>make[2]: *** [Makefile:1440: test_urcu_lfs_dynlink-test=
_urcu_lfs.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include=
 -I../../include -I../../src -I../../tests/common =C2=A0-DRCU_QSBR =C2=A0-O=
2 -g -grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security -Wp,-D_FOR=
TIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redh=
at-hardened-cc1 -fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redha=
t-annobin-cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-cl=
ash-protection -fcf-protection -fdata-sections -ffunction-sections -flto=3D=
auto -flto-partition=3Dnone -c -o test_urcu_hash-test_urcu_hash.o `test -f =
&#39;test_urcu_hash.c&#39; || echo &#39;./&#39;`test_urcu_hash.c<br>In file=
 included from test_urcu_hash.h:39,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_hash.c:23:<br>../../src/compat-ra=
nd.h:38:19: error: static declaration of =E2=80=98rand_r=E2=80=99 follows n=
on-static declaration<br>=C2=A0 =C2=A038 | static inline int rand_r(unsigne=
d int *seed)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>In file included from test_urcu_hash.=
h:28,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from=
 test_urcu_hash.c:23:<br>/usr/include/stdlib.h:459:12: note: previous decla=
ration of =E2=80=98rand_r=E2=80=99 with type =E2=80=98int(unsigned int *)=
=E2=80=99<br>=C2=A0 459 | extern int rand_r (unsigned int *__seed) __THROW;=
<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~<=
br>In file included from test_urcu_hash.h:40,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_hash.c:23:<br>../../te=
sts/common/cpuset.h:32:23: error: conflicting types for =E2=80=98cpu_set_t=
=E2=80=99; have =E2=80=98long unsigned int=E2=80=99<br>=C2=A0 =C2=A032 | ty=
pedef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In=
 file included from /usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_h=
ash.h:27,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
from test_urcu_hash.c:23:<br>/usr/include/bits/cpu-set.h:42:3: note: previo=
us declaration of =E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=
=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 ^~~~~~~~~<br>make[2]: *** [Makefile:1384: test_urcu_hash-test_urcu_hash=
.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -I../../=
include -I../../src -I../../tests/common =C2=A0-DRCU_QSBR =C2=A0-O2 -g -gre=
cord-gcc-switches -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOUR=
CE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-harden=
ed-cc1 -fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin=
-cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-prote=
ction -fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto -flt=
o-partition=3Dnone -c -o test_urcu_hash-test_urcu_hash_rw.o `test -f &#39;t=
est_urcu_hash_rw.c&#39; || echo &#39;./&#39;`test_urcu_hash_rw.c<br>In file=
 included from test_urcu_hash.h:39,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_hash_rw.c:23:<br>../../src/compat=
-rand.h:38:19: error: static declaration of =E2=80=98rand_r=E2=80=99 follow=
s non-static declaration<br>=C2=A0 =C2=A038 | static inline int rand_r(unsi=
gned int *seed)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>In file included from test_urcu_h=
ash.h:28,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
from test_urcu_hash_rw.c:23:<br>/usr/include/stdlib.h:459:12: note: previou=
s declaration of =E2=80=98rand_r=E2=80=99 with type =E2=80=98int(unsigned i=
nt *)=E2=80=99<br>=C2=A0 459 | extern int rand_r (unsigned int *__seed) __T=
HROW;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~=
~~~~<br>In file included from test_urcu_hash.h:40,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_hash_rw.c:23:<br>..=
/../tests/common/cpuset.h:32:23: error: conflicting types for =E2=80=98cpu_=
set_t=E2=80=99; have =E2=80=98long unsigned int=E2=80=99<br>=C2=A0 =C2=A032=
 | typedef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<b=
r>In file included from /usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_ur=
cu_hash.h:27,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from test_urcu_hash_rw.c:23:<br>/usr/include/bits/cpu-set.h:42:3: not=
e: previous declaration of =E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98c=
pu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 ^~~~~~~~~<br>make[2]: *** [Makefile:1398: test_urcu_hash-test_urc=
u_hash_rw.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include=
 -I../../include -I../../src -I../../tests/common =C2=A0-DRCU_QSBR =C2=A0-O=
2 -g -grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security -Wp,-D_FOR=
TIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redh=
at-hardened-cc1 -fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redha=
t-annobin-cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-cl=
ash-protection -fcf-protection -fdata-sections -ffunction-sections -flto=3D=
auto -flto-partition=3Dnone -c -o test_urcu_hash-test_urcu_hash_unique.o `t=
est -f &#39;test_urcu_hash_unique.c&#39; || echo &#39;./&#39;`test_urcu_has=
h_unique.c<br>In file included from test_urcu_hash.h:39,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_hash_unique.=
c:23:<br>../../src/compat-rand.h:38:19: error: static declaration of =E2=80=
=98rand_r=E2=80=99 follows non-static declaration<br>=C2=A0 =C2=A038 | stat=
ic inline int rand_r(unsigned int *seed)<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>In file i=
ncluded from test_urcu_hash.h:28,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_hash_unique.c:23:<br>/usr/include/st=
dlib.h:459:12: note: previous declaration of =E2=80=98rand_r=E2=80=99 with =
type =E2=80=98int(unsigned int *)=E2=80=99<br>=C2=A0 459 | extern int rand_=
r (unsigned int *__seed) __THROW;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~<br>In file included from test_urcu_hash.h=
:40,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from =
test_urcu_hash_unique.c:23:<br>../../tests/common/cpuset.h:32:23: error: co=
nflicting types for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long unsigne=
d int=E2=80=99<br>=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file included from /usr/include/sched=
.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fro=
m /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0from test_urcu_hash.h:27,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_hash_unique.c:23:<br>/=
usr/include/bits/cpu-set.h:42:3: note: previous declaration of =E2=80=98cpu=
_set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | =
} cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>make[2]: *** [Ma=
kefile:1412: test_urcu_hash-test_urcu_hash_unique.o] Error 1<br>/usr/bin/gc=
c -DHAVE_CONFIG_H =C2=A0 -I../../include -I../../include -I../../src -I../.=
./tests/common =C2=A0-DDYNAMIC_LINK_TEST =C2=A0-O2 -g -grecord-gcc-switches=
 -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLI=
BCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-pr=
otector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=
=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection -fcf-prote=
ction -fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dno=
ne -c -o test_urcu_lfs_rcu_dynlink-test_urcu_lfs_rcu.o `test -f &#39;test_u=
rcu_lfs_rcu.c&#39; || echo &#39;./&#39;`test_urcu_lfs_rcu.c<br>In file incl=
uded from test_urcu_lfs_rcu.c:39:<br>../../tests/common/cpuset.h:32:23: err=
or: conflicting types for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98long u=
nsigned int=E2=80=99<br>=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<=
br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>In file included from /usr/include=
/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0from /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from test_urcu_lfs_rcu.c:25:<br>/usr/include/bit=
s/cpu-set.h:42:3: note: previous declaration of =E2=80=98cpu_set_t=E2=80=99=
 with type =E2=80=98cpu_set_t=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br=
>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>make[2]: *** [Makefile:1454: te=
st_urcu_lfs_rcu_dynlink-test_urcu_lfs_rcu.o] Error 1<br>make[2]: Target &#3=
9;all&#39; not remade because of errors.<br>make[2]: Leaving directory &#39=
;/home/tkloczko/rpmbuild/BUILD/userspace-rcu-0.12.2/tests/benchmark&#39;<br=
>Making all in regression<br>make[2]: Entering directory &#39;/home/tkloczk=
o/rpmbuild/BUILD/userspace-rcu-0.12.2/tests/regression&#39;<br>/usr/bin/gcc=
 -DHAVE_CONFIG_H =C2=A0 -I../../include -I../../include -I../../src -I../..=
/tests/utils -I../../tests/common =C2=A0-DRCU_MEMBARRIER =C2=A0-O2 -g -grec=
ord-gcc-switches -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURC=
E=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardene=
d-cc1 -fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-=
cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protec=
tion -fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto -flto=
-partition=3Dnone -c -o rcutorture_urcu_membarrier-urcutorture.o `test -f &=
#39;urcutorture.c&#39; || echo &#39;./&#39;`urcutorture.c<br>In file includ=
ed from /usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../../tests/common/api=
.h:65,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fro=
m urcutorture.c:8:<br>/usr/include/bits/cpu-set.h:42:3: error: conflicting =
types for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98struct &lt;anonymous&g=
t;=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 ^~~~~~~~~<br>In file included from ../../tests/common/api.h:29,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from urcutorture=
.c:8:<br>../../tests/common/cpuset.h:32:23: note: previous declaration of =
=E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99 {aka =E2=
=80=98long unsigned int=E2=80=99}<br>=C2=A0 =C2=A032 | typedef unsigned lon=
g cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>make[2]: *** [Makefi=
le:1048: rcutorture_urcu_membarrier-urcutorture.o] Error 1<br>/usr/bin/gcc =
-DHAVE_CONFIG_H =C2=A0 -I../../include -I../../include -I../../src -I../../=
tests/utils -I../../tests/common =C2=A0-DRCU_SIGNAL =C2=A0-O2 -g -grecord-g=
cc-switches -pipe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2=
 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1=
 -fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -=
m64 -mtune=3Dgeneric -fasynchronous-unwind-tables -fstack-clash-protection =
-fcf-protection -fdata-sections -ffunction-sections -flto=3Dauto -flto-part=
ition=3Dnone -c -o rcutorture_urcu_signal-urcutorture.o `test -f &#39;urcut=
orture.c&#39; || echo &#39;./&#39;`urcutorture.c<br>In file included from /=
usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../../tests/common/api.h:65,<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from urcutort=
ure.c:8:<br>/usr/include/bits/cpu-set.h:42:3: error: conflicting types for =
=E2=80=98cpu_set_t=E2=80=99; have =E2=80=98struct &lt;anonymous&gt;=E2=80=
=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~=
~~~~~<br>In file included from ../../tests/common/api.h:29,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from urcutorture.c:8:<b=
r>../../tests/common/cpuset.h:32:23: note: previous declaration of =E2=80=
=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99 {aka =E2=80=98l=
ong unsigned int=E2=80=99}<br>=C2=A0 =C2=A032 | typedef unsigned long cpu_s=
et_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>make[2]: *** [Makefile:1076=
: rcutorture_urcu_signal-urcutorture.o] Error 1<br>/usr/bin/gcc -DHAVE_CONF=
IG_H =C2=A0 -I../../include -I../../include -I../../src -I../../tests/utils=
 -I../../tests/common =C2=A0-DRCU_MB =C2=A0-O2 -g -grecord-gcc-switches -pi=
pe -Wall -Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX=
_ASSERTIONS -specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protec=
tor-strong -specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dge=
neric -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection=
 -fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -c=
 -o rcutorture_urcu_mb-urcutorture.o `test -f &#39;urcutorture.c&#39; || ec=
ho &#39;./&#39;`urcutorture.c<br>In file included from /usr/include/sched.h=
:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from =
/usr/include/pthread.h:22,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from ../../tests/common/api.h:65,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from urcutorture.c:8:<br>/usr/incl=
ude/bits/cpu-set.h:42:3: error: conflicting types for =E2=80=98cpu_set_t=E2=
=80=99; have =E2=80=98struct &lt;anonymous&gt;=E2=80=99<br>=C2=A0 =C2=A042 =
| } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>In file includ=
ed from ../../tests/common/api.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0from urcutorture.c:8:<br>../../tests/common/cpus=
et.h:32:23: note: previous declaration of =E2=80=98cpu_set_t=E2=80=99 with =
type =E2=80=98cpu_set_t=E2=80=99 {aka =E2=80=98long unsigned int=E2=80=99}<=
br>=C2=A0 =C2=A032 | typedef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 ^~~~~~~~~<br>make[2]: *** [Makefile:1034: rcutorture_urcu_mb-urcuto=
rture.o] Error 1<br>/usr/bin/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -I.=
./../include -I../../src -I../../tests/utils -I../../tests/common =C2=A0-DR=
CU_BP =C2=A0-O2 -g -grecord-gcc-switches -pipe -Wall -Werror=3Dformat-secur=
ity -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/r=
pm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=3D/usr/lib/rp=
m/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwind-tab=
les -fstack-clash-protection -fcf-protection -fdata-sections -ffunction-sec=
tions -flto=3Dauto -flto-partition=3Dnone -c -o rcutorture_urcu_bp-urcutort=
ure.o `test -f &#39;urcutorture.c&#39; || echo &#39;./&#39;`urcutorture.c<b=
r>In file included from /usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../../t=
ests/common/api.h:65,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0from urcutorture.c:8:<br>/usr/include/bits/cpu-set.h:42:3: err=
or: conflicting types for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98struct=
 &lt;anonymous&gt;=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 ^~~~~~~~~<br>In file included from ../../tests/common/a=
pi.h:29,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f=
rom urcutorture.c:8:<br>../../tests/common/cpuset.h:32:23: note: previous d=
eclaration of =E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=
=80=99 {aka =E2=80=98long unsigned int=E2=80=99}<br>=C2=A0 =C2=A032 | typed=
ef unsigned long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br>make[2=
]: *** [Makefile:1020: rcutorture_urcu_bp-urcutorture.o] Error 1<br>/usr/bi=
n/gcc -DHAVE_CONFIG_H =C2=A0 -I../../include -I../../include -I../../src -I=
../../tests/utils -I../../tests/common =C2=A0-DTORTURE_QSBR -DRCU_QSBR =C2=
=A0-O2 -g -grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security -Wp,-=
D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS -specs=3D/usr/lib/rpm/redhat=
/redhat-hardened-cc1 -fstack-protector-strong -specs=3D/usr/lib/rpm/redhat/=
redhat-annobin-cc1 -m64 -mtune=3Dgeneric -fasynchronous-unwind-tables -fsta=
ck-clash-protection -fcf-protection -fdata-sections -ffunction-sections -fl=
to=3Dauto -flto-partition=3Dnone -c -o rcutorture_urcu_qsbr-urcutorture.o `=
test -f &#39;urcutorture.c&#39; || echo &#39;./&#39;`urcutorture.c<br>In fi=
le included from /usr/include/sched.h:44,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from /usr/include/pthread.h:22,<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../../tests/co=
mmon/api.h:65,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0from urcutorture.c:8:<br>/usr/include/bits/cpu-set.h:42:3: error: con=
flicting types for =E2=80=98cpu_set_t=E2=80=99; have =E2=80=98struct &lt;an=
onymous&gt;=E2=80=99<br>=C2=A0 =C2=A042 | } cpu_set_t;<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 ^~~~~~~~~<br>In file included from ../../tests/common/api.h:29=
,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from urc=
utorture.c:8:<br>../../tests/common/cpuset.h:32:23: note: previous declarat=
ion of =E2=80=98cpu_set_t=E2=80=99 with type =E2=80=98cpu_set_t=E2=80=99 {a=
ka =E2=80=98long unsigned int=E2=80=99}<br>=C2=A0 =C2=A032 | typedef unsign=
ed long cpu_set_t;<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~<br></div><div cl=
ass=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></div><=
div class=3D"gmail_default" style=3D"font-family:monospace,monospace">klocz=
ek</div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"g=
mail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><font face=3D"monosp=
ace, monospace">--=C2=A0</font></div><div dir=3D"ltr"><font face=3D"monospa=
ce, monospace">Tomasz K=C5=82oczko | LinkedIn:=C2=A0<b style=3D"font-weight=
:normal"><a href=3D"http://lnkd.in/FXPWxH" style=3D"text-decoration:none" t=
arget=3D"_blank"><span style=3D"font-size:13px;color:rgb(17,85,204);backgro=
und-color:transparent;text-decoration:underline;vertical-align:baseline;whi=
te-space:pre-wrap">http://lnkd.in/FXPWxH</span></a></b></font></div></div><=
/div></div></div></div>

--000000000000c85d1705bb925f81--

--===============3952886071466725574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============3952886071466725574==--
