From: Rocky Dunlap <rsdunlapiv@gmail.com>
Subject: YACC error building Babeltrace 1.5.2
Date: Tue, 4 Apr 2017 10:59:00 -0600
Message-ID: <CAK-w0DdwPy625mds=3nda-UotgS2afCXg0J8m6GSHLoO3a6hig__49323.9594194621$1491326145$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3242423178958258235=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vk0-x22b.google.com (mail-vk0-x22b.google.com
 [IPv6:2607:f8b0:400c:c05::22b])
 by lists.lttng.org (Postfix) with ESMTPS id 3vyFZS44GgzpV
 for <lttng-dev@lists.lttng.org>; Tue,  4 Apr 2017 16:59:44 +0000 (UTC)
Received: by mail-vk0-x22b.google.com with SMTP id d188so180797516vka.0
 for <lttng-dev@lists.lttng.org>; Tue, 04 Apr 2017 09:59:21 -0700 (PDT)
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

--===============3242423178958258235==
Content-Type: multipart/alternative; boundary=f403045f286a704774054c5a3241

--f403045f286a704774054c5a3241
Content-Type: text/plain; charset=UTF-8

I am trying to build Babeltrace 1.5.2 and I received the following error.
Any help would be appreciated.  Let me know what other info to send.

make[4]: Entering directory
`/gpfsm/dhome/rsdunlap/bt/babeltrace-1.5.2/formats/ctf/types'
  CC       array.lo
  CC       enum.lo
  CC       float.lo
  CC       integer.lo
  CC       sequence.lo
  CC       string.lo
  CC       struct.lo
  CC       variant.lo
  CCLD     libctf-types.la
make[4]: Leaving directory
`/gpfsm/dhome/rsdunlap/bt/babeltrace-1.5.2/formats/ctf/types'
Making all in metadata
make[4]: Entering directory
`/gpfsm/dhome/rsdunlap/bt/babeltrace-1.5.2/formats/ctf/metadata'
  YACC     ctf-parser.c
/home/rsdunlap/bt/babeltrace-1.5.2/formats/ctf/metadata/ctf-parser.y:1040.9-16:
syntax error, unexpected identifier, expecting string
make[4]: *** [ctf-parser.c] Error 1
make[4]: Leaving directory
`/gpfsm/dhome/rsdunlap/bt/babeltrace-1.5.2/formats/ctf/metadata'
make[3]: *** [all-recursive] Error 1
make[3]: Leaving directory
`/gpfsm/dhome/rsdunlap/bt/babeltrace-1.5.2/formats/ctf'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory
`/gpfsm/dhome/rsdunlap/bt/babeltrace-1.5.2/formats'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/gpfsm/dhome/rsdunlap/bt/babeltrace-1.5.2'
make: *** [all] Error 2


If it helps, YACC is:

rsdunlap@discover18:~/bt/babeltrace-1.5.2> yacc --version
bison (GNU Bison) 2.3
Written by Robert Corbett and Richard Stallman.


Thanks,
Rocky

--f403045f286a704774054c5a3241
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I am trying to build Babeltrace 1.5.2 and I received =
the following error.=C2=A0 Any help would be appreciated.=C2=A0 Let me know=
 what other info to send.</div><div><br></div><div>make[4]: Entering direct=
ory `/gpfsm/dhome/rsdunlap/bt/babeltrace-1.5.2/formats/ctf/types&#39;<br></=
div><div>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0 array.lo</div><div>=C2=A0 CC =C2=A0=
 =C2=A0 =C2=A0 enum.lo</div><div>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0 float.lo</d=
iv><div>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0 integer.lo</div><div>=C2=A0 CC =C2=
=A0 =C2=A0 =C2=A0 sequence.lo</div><div>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0 stri=
ng.lo</div><div>=C2=A0 CC =C2=A0 =C2=A0 =C2=A0 struct.lo</div><div>=C2=A0 C=
C =C2=A0 =C2=A0 =C2=A0 variant.lo</div><div>=C2=A0 CCLD =C2=A0 =C2=A0 <a hr=
ef=3D"http://libctf-types.la">libctf-types.la</a></div><div>make[4]: Leavin=
g directory `/gpfsm/dhome/rsdunlap/bt/babeltrace-1.5.2/formats/ctf/types&#3=
9;</div><div>Making all in metadata</div><div>make[4]: Entering directory `=
/gpfsm/dhome/rsdunlap/bt/babeltrace-1.5.2/formats/ctf/metadata&#39;</div><d=
iv>=C2=A0 YACC =C2=A0 =C2=A0 ctf-parser.c</div><div>/home/rsdunlap/bt/babel=
trace-1.5.2/formats/ctf/metadata/ctf-parser.y:1040.9-16: syntax error, unex=
pected identifier, expecting string</div><div>make[4]: *** [ctf-parser.c] E=
rror 1</div><div>make[4]: Leaving directory `/gpfsm/dhome/rsdunlap/bt/babel=
trace-1.5.2/formats/ctf/metadata&#39;</div><div>make[3]: *** [all-recursive=
] Error 1</div><div>make[3]: Leaving directory `/gpfsm/dhome/rsdunlap/bt/ba=
beltrace-1.5.2/formats/ctf&#39;</div><div>make[2]: *** [all-recursive] Erro=
r 1</div><div>make[2]: Leaving directory `/gpfsm/dhome/rsdunlap/bt/babeltra=
ce-1.5.2/formats&#39;</div><div>make[1]: *** [all-recursive] Error 1</div><=
div>make[1]: Leaving directory `/gpfsm/dhome/rsdunlap/bt/babeltrace-1.5.2&#=
39;</div><div>make: *** [all] Error 2</div><div><br></div><div><br></div><d=
iv>If it helps, YACC is:</div><div><br></div><div><div>rsdunlap@discover18:=
~/bt/babeltrace-1.5.2&gt; yacc --version</div><div>bison (GNU Bison) 2.3</d=
iv><div>Written by Robert Corbett and Richard Stallman.</div></div><div><br=
></div><div><br></div><div>Thanks,</div><div>Rocky</div></div>

--f403045f286a704774054c5a3241--

--===============3242423178958258235==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3242423178958258235==--
