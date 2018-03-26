From: Denis Yevgenyevich <denis.yevgenyevich@gmail.com>
Subject: [liburcu] rculfhash autoresizing creates huge tables
Date: Mon, 26 Mar 2018 18:01:53 +0300
Message-ID: <CA+prXCGNcY4n51hxQMCPDbs_5zUvG2SfURfFgd7eSDwjr4b_kQ__22225.4709261053$1522077523$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6918674820199301289=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yb0-x243.google.com (mail-yb0-x243.google.com
 [IPv6:2607:f8b0:4002:c09::243])
 by lists.lttng.org (Postfix) with ESMTPS id 408y6C3x5ZzyKX
 for <lttng-dev@lists.lttng.org>; Mon, 26 Mar 2018 11:01:55 -0400 (EDT)
Received: by mail-yb0-x243.google.com with SMTP id a12-v6so442765ybn.13
 for <lttng-dev@lists.lttng.org>; Mon, 26 Mar 2018 08:01:55 -0700 (PDT)
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

--===============6918674820199301289==
Content-Type: multipart/alternative; boundary="000000000000ea7d4f0568520df1"

--000000000000ea7d4f0568520df1
Content-Type: text/plain; charset="UTF-8"

Hello,

I think rculfhash autoresizing (as enabled by CDS_LFHT_AUTO_RESIZE) does
not behave well. Each time _cds_lfht_add finds a hash bucket with more than
2 items, it basically tries to quadruple the hash table size. But even with
a perfect hash function hash collisions are not that rare, given a large
enough table. That is, every now and then the algorithm will come across a
3-long chain and will grow the table unnecessarily.

I created a table with cds_lfht_new(16, 16, 1<<16, CDS_LFHT_AUTO_RESIZE,
NULL) and began adding an item each 10ms. Each item had a unique key and
the hash function was very good (full 64-bit values of Siphash). Judging by
messages I added to rculfhash.c, this was happening:
after about 100 insertions, the table was resized to 512
after about 500 insertions, the table was resized to 4096
after about 1300 insertions, the table was resized to 16384 and immediately
to 32768

With CDS_LFHT_AUTO_RESIZE|CDS_LFHT_ACCOUNTING the behaviour was different
but still unacceptable: the table got resized to 4096 after 900 insertions
and then stopped growing!

Could someone please implement saner resize conditions, or better yet, add
a customisable hook for decisions as to when and how much should a table
grow?

Cheers, Denis.

--000000000000ea7d4f0568520df1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hello,<br><br>I think rculfhash autore=
sizing (as enabled by CDS_LFHT_AUTO_RESIZE) does not behave well. Each time=
 _cds_lfht_add finds a hash bucket with more than 2 items, it basically tri=
es to quadruple the hash table size. But even with a perfect hash function =
hash collisions are not that rare, given a large enough table. That is, eve=
ry now and then the algorithm will come across a 3-long chain and will grow=
 the table unnecessarily.<br><br>I created a table with cds_lfht_new(16, 16=
, 1&lt;&lt;16, CDS_LFHT_AUTO_RESIZE, NULL) and began adding an item each 10=
ms. Each item had a unique key and the hash function was very good (full 64=
-bit values of Siphash). Judging by messages I added to rculfhash.c, this w=
as happening:<br></div>after about 100 insertions, the table was resized to=
 512<br>after about 500 insertions, the table was resized to 4096<br></div>=
after about 1300 insertions, the table was resized to 16384 and immediately=
 to 32768<br><br></div><div>With CDS_LFHT_AUTO_RESIZE|CDS_LFHT_ACCOUNTING t=
he behaviour was different but still unacceptable: the table got resized to=
 4096 after 900 insertions and then stopped growing!<br><br></div>Could som=
eone please implement saner resize conditions, or better yet, add a customi=
sable hook for decisions as to when and how much should a table grow?<br><b=
r></div>Cheers, Denis.<br></div>

--000000000000ea7d4f0568520df1--

--===============6918674820199301289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============6918674820199301289==--
