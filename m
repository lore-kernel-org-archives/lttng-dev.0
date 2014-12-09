From: Yan Grange <ygrange@gmail.com>
Subject: Errors compiling converted tp file
Date: Tue, 9 Dec 2014 14:48:48 +0100
Message-ID: <23F748C6-C9DB-43D4-9355-F5817976B70F__5203.16635161198$1418148941$gmane$org@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ygrange@gmail.com>) id 1XyL9r-0003aR-Eu
 for lttng-dev@lists.lttng.org; Tue, 09 Dec 2014 08:48:57 -0500
Received: by mail-wg0-f43.google.com with SMTP id l18so854957wgh.30
 for <lttng-dev@lists.lttng.org>; Tue, 09 Dec 2014 05:48:49 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

I try to reproduce the examle of tracing an application in user space as pr=
esent in the documentation. The conversion of the .tp file, which is a copy=
 paste of the example in the docs provides me with many errors=85

I am using gcc 4.6.3 on Ubuntu 12.04 (LTS). I have the following lttng-pack=
ages installed:
liblttng-ctl-dev			=

liblttng-ctl0				=

liblttng-ust-dev			=

liblttng-ust0				=

lttng-modules-dkms			=

lttng-tools

Am I doing something wrong or is there some issue with my environment?


The following errors occur:

~/lttng$ lttng-gen-tp hello-tp.tp

In file included from hello-tp.c:7:0:
hello-tp.h:13:20: error: missing ')' after "defined"
hello-tp.h:13:21: error: missing binary operator before token "TP_H"
In file included from /usr/include/lttng/tracepoint-event.h:39:0,
                 from hello-tp.h:33,
                 from hello-tp.c:7:
././hello-tp.h:13:20: error: missing ')' after "defined"
././hello-tp.h:13:21: error: missing binary operator before token "TP_H"
In file included from /usr/include/lttng/tracepoint-event.h:41:0,
                 from hello-tp.h:33,
                 from hello-tp.c:7:
/usr/include/lttng/ust-tracepoint-event.h:103:6: error: =91_TP_COMBINE_TOKE=
NS=92 declared as function returning a function
/usr/include/lttng/ust-tracepoint-event.h:116:6: error: =91_TP_COMBINE_TOKE=
NS=92 declared as function returning a function
/usr/include/lttng/ust-tracepoint-event.h:116:6: error: redefinition of =91=
_TP_COMBINE_TOKENS=92
/usr/include/lttng/ust-tracepoint-event.h:103:6: note: previous definition =
of =91_TP_COMBINE_TOKENS=92 was here
In file included from /usr/include/lttng/ust-tracepoint-event.h:118:0,
                 from /usr/include/lttng/tracepoint-event.h:41,
                 from hello-tp.h:33,
                 from hello-tp.c:7:
././hello-tp.h: In function =91_TP_COMBINE_TOKENS=92:
././hello-tp.h:13:20: error: missing ')' after "defined"
././hello-tp.h:13:21: error: missing binary operator before token "TP_H"
In file included from /usr/include/lttng/ust-tracepoint-event.h:138:0,
                 from /usr/include/lttng/tracepoint-event.h:41,
                 from hello-tp.h:33,
                 from hello-tp.c:7:
././hello-tp.h: At top level:
././hello-tp.h:13:20: error: missing ')' after "defined"
././hello-tp.h:13:21: error: missing binary operator before token "TP_H"
In file included from /usr/include/lttng/ust-tracepoint-event.h:215:0,
                 from /usr/include/lttng/tracepoint-event.h:41,
                 from hello-tp.h:33,
                 from hello-tp.c:7:
././hello-tp.h:13:20: error: missing ')' after "defined"
././hello-tp.h:13:21: error: missing binary operator before token "TP_H"
In file included from /usr/include/lttng/ust-tracepoint-event.h:233:0,
                 from /usr/include/lttng/tracepoint-event.h:41,
                 from hello-tp.h:33,
                 from hello-tp.c:7:
././hello-tp.h:13:20: error: missing ')' after "defined"
././hello-tp.h:13:21: error: missing binary operator before token "TP_H"
In file included from /usr/include/lttng/ust-tracepoint-event.h:292:0,
                 from /usr/include/lttng/tracepoint-event.h:41,
                 from hello-tp.h:33,
                 from hello-tp.c:7:
././hello-tp.h:13:20: error: missing ')' after "defined"
././hello-tp.h:13:21: error: missing binary operator before token "TP_H"
In file included from /usr/include/lttng/ust-tracepoint-event.h:340:0,
                 from /usr/include/lttng/tracepoint-event.h:41,
                 from hello-tp.h:33,
                 from hello-tp.c:7:
././hello-tp.h:13:20: error: missing ')' after "defined"
././hello-tp.h:13:21: error: missing binary operator before token "TP_H"
In file included from /usr/include/lttng/ust-tracepoint-event.h:433:0,
                 from /usr/include/lttng/tracepoint-event.h:41,
                 from hello-tp.h:33,
                 from hello-tp.c:7:
././hello-tp.h:13:20: error: missing ')' after "defined"
././hello-tp.h:13:21: error: missing binary operator before token "TP_H"
In file included from /usr/include/lttng/ust-tracepoint-event.h:454:0,
                 from /usr/include/lttng/tracepoint-event.h:41,
                 from hello-tp.h:33,
                 from hello-tp.c:7:
././hello-tp.h:13:20: error: missing ')' after "defined"
././hello-tp.h:13:21: error: missing binary operator before token "TP_H"
In file included from /usr/include/lttng/ust-tracepoint-event.h:474:0,
                 from /usr/include/lttng/tracepoint-event.h:41,
                 from hello-tp.h:33,
                 from hello-tp.c:7:
././hello-tp.h:13:20: error: missing ')' after "defined"
././hello-tp.h:13:21: error: missing binary operator before token "TP_H"
In file included from /usr/include/lttng/ust-tracepoint-event.h:501:0,
                 from /usr/include/lttng/tracepoint-event.h:41,
                 from hello-tp.h:33,
                 from hello-tp.c:7:
././hello-tp.h:13:20: error: missing ')' after "defined"
././hello-tp.h:13:21: error: missing binary operator before token "TP_H"
In file included from /usr/include/lttng/tracepoint-event.h:41:0,
                 from hello-tp.h:33,
                 from hello-tp.c:7:
/usr/include/lttng/ust-tracepoint-event.h:516:39: error: =91_TP_COMBINE_TOK=
ENS=92 declared as function returning an array
/usr/include/lttng/ust-tracepoint-event.h:516:21: error: function =91_TP_CO=
MBINE_TOKENS=92 is initialized like a variable
In file included from /usr/include/lttng/ust-tracepoint-event.h:517:0,
                 from /usr/include/lttng/tracepoint-event.h:41,
                 from hello-tp.h:33,
                 from hello-tp.c:7:
././hello-tp.h:13:20: error: missing ')' after "defined"
././hello-tp.h:13:21: error: missing binary operator before token "TP_H"
In file included from /usr/include/lttng/tracepoint-event.h:41:0,
                 from hello-tp.h:33,
                 from hello-tp.c:7:
/usr/include/lttng/ust-tracepoint-event.h:518:1: error: empty scalar initia=
lizer
/usr/include/lttng/ust-tracepoint-event.h:518:1: error: (near initializatio=
n for =91_TP_COMBINE_TOKENS=92)
/usr/include/lttng/ust-tracepoint-event.h:528:15: error: function =91_TP_CO=
MBINE_TOKENS=92 is initialized like a variable
/usr/include/lttng/ust-tracepoint-event.h:528:32: error: conflicting types =
for =91_TP_COMBINE_TOKENS=92
/usr/include/lttng/ust-tracepoint-event.h:116:6: note: previous definition =
of =91_TP_COMBINE_TOKENS=92 was here
/usr/include/lttng/ust-tracepoint-event.h:529:2: error: field name not in r=
ecord or union initializer
/usr/include/lttng/ust-tracepoint-event.h:529:2: error: (near initializatio=
n for =91_TP_COMBINE_TOKENS=92)
/usr/include/lttng/ust-tracepoint-event.h:529:2: error: invalid initializer
/usr/include/lttng/ust-tracepoint-event.h:529:2: error: (near initializatio=
n for =91_TP_COMBINE_TOKENS=92)
/usr/include/lttng/ust-tracepoint-event.h:530:2: error: field name not in r=
ecord or union initializer
/usr/include/lttng/ust-tracepoint-event.h:530:2: error: (near initializatio=
n for =91_TP_COMBINE_TOKENS=92)
/usr/include/lttng/ust-tracepoint-event.h:530:35: error: =91__event_desc___=
=92 undeclared here (not in a function)
/usr/include/lttng/ust-tracepoint-event.h:530:52: error: =91hello_world=92 =
undeclared here (not in a function)
/usr/include/lttng/ust-tracepoint-event.h:531:2: error: field name not in r=
ecord or union initializer
/usr/include/lttng/ust-tracepoint-event.h:531:2: error: (near initializatio=
n for =91_TP_COMBINE_TOKENS=92)
In file included from /usr/include/lttng/tracepoint-event.h:41:0,
                 from hello-tp.h:33,
                 from hello-tp.c:7:
/usr/include/lttng/ust-tracepoint-event.h:546:1: error: =91_TP_COMBINE_TOKE=
NS=92 declared as function returning a function
/usr/include/lttng/ust-tracepoint-event.h:546:1: error: conflicting types f=
or =91_TP_COMBINE_TOKENS=92
/usr/include/lttng/ust-tracepoint-event.h:528:32: note: previous declaratio=
n of =91_TP_COMBINE_TOKENS=92 was here
/usr/include/lttng/ust-tracepoint-event.h: In function =91_TP_COMBINE_TOKEN=
S=92:
/usr/include/lttng/ust-tracepoint-event.h:550:47: error: =91__probe_desc___=
=92 undeclared (first use in this function)
/usr/include/lttng/ust-tracepoint-event.h:550:47: note: each undeclared ide=
ntifier is reported only once for each function it appears in
/usr/include/lttng/ust-tracepoint-event.h: At top level:
/usr/include/lttng/ust-tracepoint-event.h:555:1: error: =91_TP_COMBINE_TOKE=
NS=92 declared as function returning a function
/usr/include/lttng/ust-tracepoint-event.h:555:1: error: redefinition of =91=
_TP_COMBINE_TOKENS=92
/usr/include/lttng/ust-tracepoint-event.h:546:1: note: previous definition =
of =91_TP_COMBINE_TOKENS=92 was here
/usr/include/lttng/ust-tracepoint-event.h: In function =91_TP_COMBINE_TOKEN=
S=92:
/usr/include/lttng/ust-tracepoint-event.h:557:43: error: =91__probe_desc___=
=92 undeclared (first use in this function)


Cheers and thanks

Yan Grange
