From: Charles Lesire-Cabaniols <charles.lesire@gmail.com>
Subject: Tracing in python application with custom tracepoints
Date: Tue, 21 Jun 2016 10:25:19 +0200
Message-ID: <CAEc6OSxXETtoNK+3LDXhUMN3mrxDS-wBa20jsSZVDyfgJAJ0ew__39658.1954708838$1466497538$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7705350115575357299=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f49.google.com (mail-lf0-f49.google.com
 [209.85.215.49])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 25EEFA36C5
 for <lttng-dev@lists.lttng.org>; Tue, 21 Jun 2016 08:25:21 +0000 (UTC)
Received: by mail-lf0-f49.google.com with SMTP id h129so11929533lfh.1
 for <lttng-dev@lists.lttng.org>; Tue, 21 Jun 2016 01:25:21 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============7705350115575357299==
Content-Type: multipart/alternative; boundary=001a113ebb88c43cc20535c58f93

--001a113ebb88c43cc20535c58f93
Content-Type: text/plain; charset=UTF-8

Hi,

I have written a C++ code in which I use custom tracepoints (generated from
a .tp file).

My system now deploys a mix of my C++ app and a python script.
Is there a way to write traces in my python script using the same
tracepoints definition (from the .tp file), and then being recorded within
the same lttng session?

I found this link about using lttng traces within python apps but it is
very concise:
https://lttng.org/docs/#doc-python-application

Thanks in advance,

Charles

--001a113ebb88c43cc20535c58f93
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>Hi,<br><br></div>I have written a=
 C++ code in which I use custom tracepoints (generated from a .tp file).<br=
><br></div>My system now deploys a mix of my C++ app and a python script.<b=
r></div>Is there a way to write traces in my python script using the same t=
racepoints definition (from the .tp file), and then being recorded within t=
he same lttng session?<br><br>I found this link about using lttng traces wi=
thin python apps but it is very concise:<br><a href=3D"https://lttng.org/do=
cs/#doc-python-application">https://lttng.org/docs/#doc-python-application<=
/a><br><br></div>Thanks in advance,<br><br></div>Charles<br></div>

--001a113ebb88c43cc20535c58f93--

--===============7705350115575357299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7705350115575357299==--
