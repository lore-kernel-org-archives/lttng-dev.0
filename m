From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [liburcu] rculfhash autoresizing creates huge tables
Date: Tue, 27 Mar 2018 09:02:30 -0400 (EDT)
Message-ID: <689232617.1005.1522155750694.JavaMail.zimbra__48236.1234644943$1522155639$gmane$org@efficios.com>
References: <CA+prXCGNcY4n51hxQMCPDbs_5zUvG2SfURfFgd7eSDwjr4b_kQ@mail.gmail.com>
 <530644299.98.1522078357992.JavaMail.zimbra@efficios.com>
 <CA+prXCHWPUUrQW_doETZaBO4eMasjCJ9QgEGmODJ=NPf=H6CDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0699318070577898792=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 409WQ06m6rzx8V
 for <lttng-dev@lists.lttng.org>; Tue, 27 Mar 2018 09:02:32 -0400 (EDT)
In-Reply-To: <CA+prXCHWPUUrQW_doETZaBO4eMasjCJ9QgEGmODJ=NPf=H6CDQ@mail.gmail.com>
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
Cc: lttng-dev <lttng-dev@lists.lttng.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

--===============0699318070577898792==
Content-Type: multipart/alternative;
	boundary="=_1f6bbe6d-0e55-4448-9ac0-050405ba247c"

--=_1f6bbe6d-0e55-4448-9ac0-050405ba247c
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Mar 27, 2018, at 5:55 AM, Denis Yevgenyevich <denis.yevgenyevich@gmail.com> wrote: 

>> The "accounting" option is meant to be enabled, otherwise you're using the hash
> > table only with
> > the bucket-length resize threshold, which has the imperfections you noticed
> Well, given that my software has to maintain precise counts of items inserted
> into some of hashtables,
> I'd like to be able to avoid any performance overhead due to accounting.

>> only for small tables. Beyond a certain size, the numbers of elements in the
> > hash table are used
> > as a criterion for resize.
>> Why is it unexpected that the table stops growing beyond 4096 after 900
> > insertions ?
> Ah, thanks. Turns out that the table stopped growing because of the check
> if (count >= (1UL << (COUNT_COMMIT_ORDER + split_count_order)))

If both (CDS_LFHT_ACCOUNTING | CDS_LFHT_AUTO_RESIZE) flags are set, the table will 
still grow after it has gone beyond this condition. 

When both flags are set, check_resize() is only for the bucket-local chain length algorithm that deals 
with very small tables. Then, when the table size goes above that threshold, split-counters are used to 
adjust the required table size. We don't use the split-counters approximation of the number of elements 
in the table for small tables because they are not accurate enough for small tables. It's a tradeoff 
between accuracy and accounting overhead here. 

Notice that ht_count_add() and ht_count_del() both invoke cds_lfht_resize_lazy_count(). It's that 
function which is responsible for the split-counter based resize algorithm. 

> I am a bit disappointed about that. Why can't we have tables that resize
> 1. automatically
> 2. from 10s to 100,000s of buckets
> 3. without becoming too large too soon?

The only thing here is that the bucket-length algorithm used for small tables can grow the 
table more quickly than you would expect if you have hash collisions. But it should not 
matter that much because it only applies to small tables. Do you experience "too aggressive" 
hash table growth even beyond the threshold selecting the split-counters resize algorithm ? 

That threshold is calculated as: 

(1UL << (COUNT_COMMIT_ORDER + split_count_order) 

Where COUNT_COMMIT_ORDER = 10 
and split_count_order = log2(nr_cpus ceiled to next power of 2) 

Assuming a 64-core machine: 

log2(64) = 6 
2 ^ (10 + 6) = 65536 

Considering that you created your hash table with an initial size of 16 buckets, specified a minimum 
number of buckets of 16, and a maximum number of buckets of 1 << 16 (65536), you'll always be 
using the "hash-chain length" algorithm for resize on a 64-core machine. The split-counter algorithm 
would never kick in. 

You should therefore try tweaking the @max_nr_buckets parameter to a larger value when 
calling cds_lfht_new(). 

How many cores do you have ? 

Let me know how is goes, 

Thanks, 

Mathieu 

> On 26 March 2018 at 18:32, Mathieu Desnoyers < [
> mailto:mathieu.desnoyers@efficios.com | mathieu.desnoyers@efficios.com ] >
> wrote:

>> ----- On Mar 26, 2018, at 11:01 AM, Denis Yevgenyevich < [
>> mailto:denis.yevgenyevich@gmail.com | denis.yevgenyevich@gmail.com ] > wrote:

>>> Hello,

>>> I think rculfhash autoresizing (as enabled by CDS_LFHT_AUTO_RESIZE) does not
>>> behave well. Each time _cds_lfht_add finds a hash bucket with more than 2
>>> items, it basically tries to quadruple the hash table size. But even with a
>>> perfect hash function hash collisions are not that rare, given a large enough
>>> table. That is, every now and then the algorithm will come across a 3-long
>>> chain and will grow the table unnecessarily.

>>> I created a table with cds_lfht_new(16, 16, 1<<16, CDS_LFHT_AUTO_RESIZE, NULL)
>>> and began adding an item each 10ms. Each item had a unique key and the hash
>>> function was very good (full 64-bit values of Siphash). Judging by messages I
>>> added to rculfhash.c, this was happening:
>>> after about 100 insertions, the table was resized to 512
>>> after about 500 insertions, the table was resized to 4096
>>> after about 1300 insertions, the table was resized to 16384 and immediately to
>>> 32768

>>> With CDS_LFHT_AUTO_RESIZE|CDS_LFHT_ACCOUNTING the behaviour was different but
>>> still unacceptable: the table got resized to 4096 after 900 insertions and then
>>> stopped growing!

>> The "accounting" option is meant to be enabled, otherwise you're using the hash
>> table only with
>> the bucket-length resize threshold, which has the imperfections you noticed.

>> With accounting enabled, the bucket length is used as an approximation for when
>> resize is needed
>> only for small tables. Beyond a certain size, the numbers of elements in the
>> hash table are used
>> as a criterion for resize.

>> Why is it unexpected that the table stops growing beyond 4096 after 900
>> insertions ? How many
>> more insertions did you do beyond 900 ?

>> Thanks,

>> Mathieu

>>> Could someone please implement saner resize conditions, or better yet, add a
>>> customisable hook for decisions as to when and how much should a table grow?

>>> Cheers, Denis.

>>> _______________________________________________
>>> lttng-dev mailing list
>>> [ mailto:lttng-dev@lists.lttng.org | lttng-dev@lists.lttng.org ]
>>> [ https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev |
>>> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev ]

>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> [ http://www.efficios.com/ | http://www.efficios.com ]

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

--=_1f6bbe6d-0e55-4448-9ac0-050405ba247c
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><span id=3D"zwchr"=
 data-marker=3D"__DIVIDER__">----- On Mar 27, 2018, at 5:55 AM, Denis Yevge=
nyevich &lt;denis.yevgenyevich@gmail.com&gt; wrote:<br></span><div data-mar=
ker=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;=
margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:n=
ormal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size=
:12pt;"><div dir=3D"ltr"><div><div><div>&gt; The "accounting" option is mea=
nt to be enabled, otherwise you're using the hash table only with</div>&gt;=
 the bucket-length resize threshold, which has the imperfections you notice=
d<br></div>Well, given that my software has to maintain precise counts of i=
tems inserted into some of hashtables,<br>I'd like to be able to avoid any =
performance overhead due to accounting.<br></div><div><br><div><div>&gt; on=
ly for small tables. Beyond a certain size, the numbers of elements in the =
hash table are used<br><div>&gt; as a criterion for resize.<br></div><div>&=
gt; Why is it unexpected that the table stops growing beyond 4096 after 900=
 insertions ?<br></div><div>Ah, thanks. Turns out that the table stopped gr=
owing because of the check<br>&nbsp;&nbsp;&nbsp; if (count &gt;=3D (1UL &lt=
;&lt; (COUNT_COMMIT_ORDER + split_count_order)))</div></div></div></div></d=
iv></blockquote><div><br></div><div>If both (CDS_LFHT_ACCOUNTING | CDS_LFHT=
_AUTO_RESIZE) flags are set, the table will<br data-mce-bogus=3D"1"></div><=
div>still grow after it has gone beyond this condition.<br></div><div><br d=
ata-mce-bogus=3D"1"></div><div>When both flags are set, check_resize() is o=
nly for the bucket-local chain length algorithm that deals</div><div>with v=
ery small tables. Then, when the table size goes above that threshold, spli=
t-counters are used to</div><div>adjust the required table size. We don't u=
se the split-counters approximation of the number of elements</div><div>in =
the table for small tables because they are not accurate enough for small t=
ables. It's a tradeoff</div><div>between accuracy and accounting overhead h=
ere.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div=
>Notice that ht_count_add() and ht_count_del() both invoke cds_lfht_resize_=
lazy_count(). It's that<br data-mce-bogus=3D"1"></div><div>function which i=
s responsible for the split-counter based resize algorithm.<br data-mce-bog=
us=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;margin-le=
ft:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;tex=
t-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><=
div dir=3D"ltr"><div><div><div><div><br></div><div><br>I am a bit disappoin=
ted about that. Why can't we have tables that resize<br>1. automatically<br=
></div><div>2. from 10s to 100,000s of buckets<br></div><div>3. without bec=
oming too large too soon?</div></div></div></div></div></blockquote><div>Th=
e only thing here is that the bucket-length algorithm used for small tables=
 can grow the</div><div>table more quickly than you would expect if you hav=
e hash collisions. But it should not<br></div><div>matter that much because=
 it only applies to small tables. Do you experience "too aggressive"</div><=
div>hash table growth even beyond the threshold selecting the split-counter=
s resize algorithm ?<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div>That threshold is calculated as:<br data-mce-bogus=3D"1">=
</div><div><br data-mce-bogus=3D"1"></div><div>(1UL &lt;&lt; (COUNT_COMMIT_=
ORDER + split_count_order)<br data-mce-bogus=3D"1"></div><div><br data-mce-=
bogus=3D"1"></div><div>Where COUNT_COMMIT_ORDER =3D 10<br data-mce-bogus=3D=
"1"></div><div>and split_count_order =3D log2(nr_cpus ceiled to next power =
of 2)<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><di=
v>Assuming a 64-core machine:</div><div><br data-mce-bogus=3D"1"></div><div=
>log2(64) =3D 6<br data-mce-bogus=3D"1"></div><div>2 ^ (10 + 6) =3D 65536<b=
r data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Consi=
dering that you created your hash table with an initial size of 16 buckets,=
 specified a minimum<br data-mce-bogus=3D"1"></div><div>number of buckets o=
f 16, and a maximum number of buckets of 1 &lt;&lt; 16 (65536), you'll alwa=
ys be</div><div>using the "hash-chain length" algorithm for resize on a 64-=
core machine. The split-counter algorithm<br></div><div>would never kick in=
.<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Yo=
u should therefore try tweaking the @max_nr_buckets parameter to a larger v=
alue when</div><div>calling cds_lfht_new().<br data-mce-bogus=3D"1"></div><=
div><br data-mce-bogus=3D"1"></div><div>How many cores do you have ?<br dat=
a-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>Let me kno=
w how is goes,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1">=
</div><div>Thanks,<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D=
"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><div><br data-mce-bogu=
s=3D"1"></div><blockquote style=3D"border-left:2px solid #1010FF;margin-lef=
t:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text=
-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><d=
iv dir=3D"ltr"><div><div><div><div><br></div><br></div></div></div></div><d=
iv class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 26 March 2018 at=
 18:32, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"mailto:mathieu.d=
esnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@efficios.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div style=3D"fon=
t-family:arial,helvetica,sans-serif;font-size:12pt;color:#000000"><div><spa=
n id=3D"m_-6782962235010934370zwchr">----- On Mar 26, 2018, at 11:01 AM, De=
nis Yevgenyevich &lt;<a href=3D"mailto:denis.yevgenyevich@gmail.com" target=
=3D"_blank">denis.yevgenyevich@gmail.com</a>&gt; wrote:<br></span></div><di=
v><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;paddin=
g-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:=
none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr=
"><div><div><div><div>Hello,<br><br>I think rculfhash autoresizing (as enab=
led by CDS_LFHT_AUTO_RESIZE) does not behave well. Each time _cds_lfht_add =
finds a hash bucket with more than 2 items, it basically tries to quadruple=
 the hash table size. But even with a perfect hash function hash collisions=
 are not that rare, given a large enough table. That is, every now and then=
 the algorithm will come across a 3-long chain and will grow the table unne=
cessarily.<br><br>I created a table with cds_lfht_new(16, 16, 1&lt;&lt;16, =
CDS_LFHT_AUTO_RESIZE, NULL) and began adding an item each 10ms. Each item h=
ad a unique key and the hash function was very good (full 64-bit values of =
Siphash). Judging by messages I added to rculfhash.c, this was happening:<b=
r></div>after about 100 insertions, the table was resized to 512<br>after a=
bout 500 insertions, the table was resized to 4096<br></div>after about 130=
0 insertions, the table was resized to 16384 and immediately to 32768<br><b=
r></div><div>With CDS_LFHT_AUTO_RESIZE|CDS_LFHT_ACCOUNTING the behaviour wa=
s different but still unacceptable: the table got resized to 4096 after 900=
 insertions and then stopped growing!</div></div></div></blockquote><br><di=
v>The "accounting" option is meant to be enabled, otherwise you're using th=
e hash table only with</div><div>the bucket-length resize threshold, which =
has the imperfections you noticed.<br></div><br><div>With accounting enable=
d, the bucket length is used as an approximation for when resize is needed<=
br></div><div>only for small tables. Beyond a certain size, the numbers of =
elements in the hash table are used<br></div><div>as a criterion for resize=
.<br></div><br><div>Why is it unexpected that the table stops growing beyon=
d 4096 after 900 insertions ? How many<br></div><div>more insertions did yo=
u do beyond 900 ?<br></div><br><div>Thanks,<br></div><br><div>Mathieu</div>=
<blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;padding-=
left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:no=
ne;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr">=
<div><div><br><br></div>Could someone please implement saner resize conditi=
ons, or better yet, add a customisable hook for decisions as to when and ho=
w much should a table grow?<br><br></div>Cheers, Denis.<br></div><br>______=
_________________________________________<br>lttng-dev mailing list<br><a h=
ref=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@lists.=
lttng.org</a><br><a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinf=
o/lttng-dev" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/list=
info/lttng-dev</a><span class=3D"HOEnZb"><span data-mce-style=3D"color: #88=
8888;" style=3D"color: #888888;" color=3D"#888888"><br></span></span></bloc=
kquote></div><span class=3D"HOEnZb"><span data-mce-style=3D"color: #888888;=
" style=3D"color: #888888;" color=3D"#888888"><br><div>-- <br></div><div>Ma=
thieu Desnoyers<br>EfficiOS Inc.<br><a href=3D"http://www.efficios.com" tar=
get=3D"_blank">http://www.efficios.com</a><br data-mce-bogus=3D"1"></div></=
span></span></div></div></blockquote></div></div><br></blockquote></div><br=
><div data-marker=3D"__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>E=
fficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
--=_1f6bbe6d-0e55-4448-9ac0-050405ba247c--

--===============0699318070577898792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0699318070577898792==--
