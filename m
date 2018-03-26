From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: ***UNCHECKED*** [liburcu] rculfhash autoresizing
 creates	huge tables
Date: Mon, 26 Mar 2018 11:32:38 -0400 (EDT)
Message-ID: <530644299.98.1522078357992.JavaMail.zimbra__39189.7968053401$1522078252$gmane$org@efficios.com>
References: <CA+prXCGNcY4n51hxQMCPDbs_5zUvG2SfURfFgd7eSDwjr4b_kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0337265064766309407=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 408ynn54zyzx0y
 for <lttng-dev@lists.lttng.org>; Mon, 26 Mar 2018 11:32:45 -0400 (EDT)
In-Reply-To: <CA+prXCGNcY4n51hxQMCPDbs_5zUvG2SfURfFgd7eSDwjr4b_kQ@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Denis Yevgenyevich <denis.yevgenyevich@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0337265064766309407==
Content-Type: multipart/alternative;
	boundary="=_f64d8bc5-854e-485d-980b-ef8a04c3c1f9"

--=_f64d8bc5-854e-485d-980b-ef8a04c3c1f9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Mar 26, 2018, at 11:01 AM, Denis Yevgenyevich <denis.yevgenyevich@gmail.com> wrote: 

> Hello,

> I think rculfhash autoresizing (as enabled by CDS_LFHT_AUTO_RESIZE) does not
> behave well. Each time _cds_lfht_add finds a hash bucket with more than 2
> items, it basically tries to quadruple the hash table size. But even with a
> perfect hash function hash collisions are not that rare, given a large enough
> table. That is, every now and then the algorithm will come across a 3-long
> chain and will grow the table unnecessarily.

> I created a table with cds_lfht_new(16, 16, 1<<16, CDS_LFHT_AUTO_RESIZE, NULL)
> and began adding an item each 10ms. Each item had a unique key and the hash
> function was very good (full 64-bit values of Siphash). Judging by messages I
> added to rculfhash.c, this was happening:
> after about 100 insertions, the table was resized to 512
> after about 500 insertions, the table was resized to 4096
> after about 1300 insertions, the table was resized to 16384 and immediately to
> 32768

> With CDS_LFHT_AUTO_RESIZE|CDS_LFHT_ACCOUNTING the behaviour was different but
> still unacceptable: the table got resized to 4096 after 900 insertions and then
> stopped growing!

The "accounting" option is meant to be enabled, otherwise you're using the hash table only with 
the bucket-length resize threshold, which has the imperfections you noticed. 

With accounting enabled, the bucket length is used as an approximation for when resize is needed 
only for small tables. Beyond a certain size, the numbers of elements in the hash table are used 
as a criterion for resize. 

Why is it unexpected that the table stops growing beyond 4096 after 900 insertions ? How many 
more insertions did you do beyond 900 ? 

Thanks, 

Mathieu 

> Could someone please implement saner resize conditions, or better yet, add a
> customisable hook for decisions as to when and how much should a table grow?

> Cheers, Denis.

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_f64d8bc5-854e-485d-980b-ef8a04c3c1f9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><span id=3D"zwchr" data-marker=3D"__DIVIDER=
__">----- On Mar 26, 2018, at 11:01 AM, Denis Yevgenyevich &lt;denis.yevgen=
yevich@gmail.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TE=
XT__"><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;pa=
dding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorat=
ion:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div dir=
=3D"ltr"><div><div><div><div>Hello,<br><br>I think rculfhash autoresizing (=
as enabled by CDS_LFHT_AUTO_RESIZE) does not behave well. Each time _cds_lf=
ht_add finds a hash bucket with more than 2 items, it basically tries to qu=
adruple the hash table size. But even with a perfect hash function hash col=
lisions are not that rare, given a large enough table. That is, every now a=
nd then the algorithm will come across a 3-long chain and will grow the tab=
le unnecessarily.<br><br>I created a table with cds_lfht_new(16, 16, 1&lt;&=
lt;16, CDS_LFHT_AUTO_RESIZE, NULL) and began adding an item each 10ms. Each=
 item had a unique key and the hash function was very good (full 64-bit val=
ues of Siphash). Judging by messages I added to rculfhash.c, this was happe=
ning:<br></div>after about 100 insertions, the table was resized to 512<br>=
after about 500 insertions, the table was resized to 4096<br></div>after ab=
out 1300 insertions, the table was resized to 16384 and immediately to 3276=
8<br><br></div><div>With CDS_LFHT_AUTO_RESIZE|CDS_LFHT_ACCOUNTING the behav=
iour was different but still unacceptable: the table got resized to 4096 af=
ter 900 insertions and then stopped growing!</div></div></div></blockquote>=
<div><br></div><div>The "accounting" option is meant to be enabled, otherwi=
se you're using the hash table only with</div><div>the bucket-length resize=
 threshold, which has the imperfections you noticed.<br></div><div><br data=
-mce-bogus=3D"1"></div><div>With accounting enabled, the bucket length is u=
sed as an approximation for when resize is needed<br data-mce-bogus=3D"1"><=
/div><div>only for small tables. Beyond a certain size, the numbers of elem=
ents in the hash table are used<br data-mce-bogus=3D"1"></div><div>as a cri=
terion for resize.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D=
"1"></div><div>Why is it unexpected that the table stops growing beyond 409=
6 after 900 insertions ? How many<br data-mce-bogus=3D"1"></div><div>more i=
nsertions did you do beyond 900 ?<br data-mce-bogus=3D"1"></div><div><br da=
ta-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><b=
r data-mce-bogus=3D"1"></div><div>Mathieu</div><blockquote style=3D"border-=
left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-wei=
ght:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Ari=
al,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div><div><br><br></div>Cou=
ld someone please implement saner resize conditions, or better yet, add a c=
ustomisable hook for decisions as to when and how much should a table grow?=
<br><br></div>Cheers, Denis.<br></div><br>_________________________________=
______________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>ht=
tps://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></=
div><div><br></div><div data-marker=3D"__SIG_POST__">-- <br></div><div>Math=
ieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body=
></html>
--=_f64d8bc5-854e-485d-980b-ef8a04c3c1f9--

--===============0337265064766309407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0337265064766309407==--
