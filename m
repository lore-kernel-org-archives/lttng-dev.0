From: Aravind HT <aravind.ht@gmail.com>
Subject: core seen in relayd_cleanup()
Date: Wed, 30 Nov 2016 00:49:08 +0530
Message-ID: <CACd+_b7asL_HVFvZzxq9ungTLqshxTsyxK7-WXJJb-qVop81Ug__49138.6860063814$1480447168$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8065419632500145293=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-io0-x232.google.com (mail-io0-x232.google.com
 [IPv6:2607:f8b0:4001:c06::232])
 by lists.lttng.org (Postfix) with ESMTPS id 3tStgL5FSRznns
 for <lttng-dev@lists.lttng.org>; Tue, 29 Nov 2016 19:20:46 +0000 (UTC)
Received: by mail-io0-x232.google.com with SMTP id m5so169713664ioe.3
 for <lttng-dev@lists.lttng.org>; Tue, 29 Nov 2016 11:19:09 -0800 (PST)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============8065419632500145293==
Content-Type: multipart/alternative; boundary=001a1143db986b93d105427576bb

--001a1143db986b93d105427576bb
Content-Type: text/plain; charset=UTF-8

Hi,


I was in the processes of upgrading to 2.8.1 and see the below relayd core.
I am trying to get the logs for this but is proving hard to reproduce this
scenario with full logs enabled and also as this is happening in a complex
environment, not sure why relayd is exiting.

For the meantime, from https://lwn.net/Articles/573432/  , I see that
cds_lfht_destroy() may fail in case the ht is not empty. Should the
assert() be there in relayd_cleanup() or do you know what can
cause/simulate this crash ?
Ive tried killing relayd with SIGINT, SIGTERM when sesions are being active
and that doesnt reproduce this.

55      ../sysdeps/unix/sysv/linux/raise.c: No such file or directory.
[Current thread is 1 (Thread 0x7fd7e7c0e980 (LWP 29366))]
(gdb) info threads
  Id   Target Id         Frame
  2    Thread 0x7fd7e1b1c700 (LWP 29375) 0x00007fd7e6701996 in _int_free
(av=<optimized out>, p=<optimized out>, have_lock=0) at malloc.c:4059
* 1    Thread 0x7fd7e7c0e980 (LWP 29366) 0x00007fd7e66bd367 in __GI_raise
(sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:55
(gdb) bt full
#0  0x00007fd7e66bd367 in __GI_raise (sig=sig@entry=6) at
../sysdeps/unix/sysv/linux/raise.c:55
        resultvar = 0
        pid = 29366
        selftid = 29366
#1  0x00007fd7e66c033a in __GI_abort () at abort.c:89
        save_stage = 2
        act = {__sigaction_handler = {sa_handler = 0x4, sa_sigaction =
0x4}, sa_mask = {__val = {5, 48, 140732823353744, 3924933264, 0, 0, 0,
21474836480, 140732823353896, 140565261773123,
              140732823353696, 140565261807824, 140565261789000,
140732823354144, 140565282869248, 140565261789000}}, sa_flags = 4462201,
sa_restorer = 0x4416c0 <__PRETTY_FUNCTION__.5555>}
        sigs = {__val = {32, 0 <repeats 15 times>}}
#2  0x00007fd7e66b644d in __assert_fail_base (fmt=0x7fd7e67f2748
"%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=assertion@entry=0x441679
"!ret", file=file@entry=0x4415da "hashtable.c",
    line=line@entry=162, function=function@entry=0x4416c0
<__PRETTY_FUNCTION__.5555> "lttng_ht_destroy") at assert.c:92
        str = 0x65b310 ""
        total = 4096
#3  0x00007fd7e66b6502 in __GI___assert_fail (assertion=0x441679 "!ret",
file=0x4415da "hashtable.c", line=162, function=0x4416c0
<__PRETTY_FUNCTION__.5555> "lttng_ht_destroy") at assert.c:101
No locals.
#4  0x0000000000422f17 in lttng_ht_destroy (ht=0x65a0e0) at hashtable.c:162
        ret = -1
        __PRETTY_FUNCTION__ = "lttng_ht_destroy"
#5  0x000000000040803b in relayd_cleanup () at main.c:497
        __func__ = "relayd_cleanup"
#6  0x000000000040ec4c in main (argc=5, argv=0x7ffee9f1bd68) at main.c:2939
        ret = 0
        retval = 0
        status = 0x0
        __func__ = "main"

(gdb) f 4
#4  0x0000000000422f17 in lttng_ht_destroy (ht=0x65a0e0) at hashtable.c:162
162     hashtable.c: No such file or directory.
(gdb) p *ht->ht
$1 = {max_nr_buckets = 9223372036854775808, mm = 0x7fd7e6e50920
<cds_lfht_mm_order>,
flavor = 0x7fd7e77b6340 <rcu_flavor_memb>, count = -1024, resize_mutex =
{__data = {
__lock = 0, __count = 0, __owner = 0, __nusers = 0, __kind = 0, __spins = 0,
      __elision = 0, __list = {__prev = 0x0, __next = 0x0}},
    __size = '\000' <repeats 39 times>, __align = 0}, resize_attr = 0x0,
  in_progress_resize = 0, in_progress_destroy = 1, resize_target = 2048,
  resize_initiated = 0, flags = 3, min_alloc_buckets_order = 0,
min_nr_alloc_buckets = 1,
  split_count = 0x65b170, .., bucket_at = 0x7fd7e6c4e080 <bucket_at>, {
    tbl_order = {0x65b280, 0x65b2a0, 0x65b2c0, 0x7fd7c40008c0,
0x7fd7c4000910,
      0x7fd7c40009a0, 0x7fd7c4000ab0, 0x7fd7c4001070, 0x7fd7c4001480,
0x7fd7c4001c90,
      0x7fd7c4003350, 0x7fd7c4005360, 0x0 <repeats 52 times>}, tbl_chunk =
0x65af60,
    tbl_mmap = 0x65b280}}


Regards,
Aravind.

--001a1143db986b93d105427576bb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div><br></div><div>I was in the process=
es of upgrading to 2.8.1 and see the below relayd core.</div><div>I am tryi=
ng to get the logs for this but is proving hard to reproduce this scenario =
with full logs enabled and also as this is happening in a complex environme=
nt, not sure why relayd is exiting.</div><div><br></div><div>For the meanti=
me, from=C2=A0<a href=3D"https://lwn.net/Articles/573432/">https://lwn.net/=
Articles/573432/</a> =C2=A0, I see that=C2=A0<span style=3D"color:rgb(0,0,0=
)">cds_lfht_destroy()=C2=A0</span>may fail in case the ht is not empty. Sho=
uld the assert() be there in relayd_cleanup() or do you know what can cause=
/simulate this crash ?</div><div>Ive tried killing relayd with SIGINT, SIGT=
ERM when sesions are being active and that doesnt reproduce this.</div><div=
><br></div><div><div>55 =C2=A0 =C2=A0 =C2=A0../sysdeps/unix/sysv/linux/rais=
e.c: No such file or directory.</div><div>[Current thread is 1 (Thread 0x7f=
d7e7c0e980 (LWP 29366))]</div><div>(gdb) info threads</div><div>=C2=A0 Id =
=C2=A0 Target Id =C2=A0 =C2=A0 =C2=A0 =C2=A0 Frame</div><div>=C2=A0 2 =C2=
=A0 =C2=A0Thread 0x7fd7e1b1c700 (LWP 29375) 0x00007fd7e6701996 in _int_free=
 (av=3D&lt;optimized out&gt;, p=3D&lt;optimized out&gt;, have_lock=3D0) at =
malloc.c:4059</div><div>* 1 =C2=A0 =C2=A0Thread 0x7fd7e7c0e980 (LWP 29366) =
0x00007fd7e66bd367 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/s=
ysv/linux/raise.c:55</div><div>(gdb) bt full</div><div>#0 =C2=A00x00007fd7e=
66bd367 in __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/r=
aise.c:55</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 resultvar =3D 0</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pid =3D 29366</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 selftid =3D 29366</div><div>#1 =C2=A00x00007fd7e66c033a in __GI_abor=
t () at abort.c:89</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 save_stage =3D 2</=
div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 act =3D {__sigaction_handler =3D {sa_h=
andler =3D 0x4, sa_sigaction =3D 0x4}, sa_mask =3D {__val =3D {5, 48, 14073=
2823353744, 3924933264, 0, 0, 0, 21474836480, 140732823353896, 140565261773=
123,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 14073282335=
3696, 140565261807824, 140565261789000, 140732823354144, 140565282869248, 1=
40565261789000}}, sa_flags =3D 4462201, sa_restorer =3D 0x4416c0 &lt;__PRET=
TY_FUNCTION__.5555&gt;}</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 sigs =3D {__v=
al =3D {32, 0 &lt;repeats 15 times&gt;}}</div><div>#2 =C2=A00x00007fd7e66b6=
44d in __assert_fail_base (fmt=3D0x7fd7e67f2748 &quot;%s%s%s:%u: %s%sAssert=
ion `%s&#39; failed.\n%n&quot;, assertion=3Dassertion@entry=3D0x441679 &quo=
t;!ret&quot;, file=3Dfile@entry=3D0x4415da &quot;hashtable.c&quot;,</div><d=
iv>=C2=A0 =C2=A0 line=3Dline@entry=3D162, function=3Dfunction@entry=3D0x441=
6c0 &lt;__PRETTY_FUNCTION__.5555&gt; &quot;lttng_ht_destroy&quot;) at asser=
t.c:92</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 str =3D 0x65b310 &quot;&quot;<=
/div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 total =3D 4096</div><div>#3 =C2=A00x0=
0007fd7e66b6502 in __GI___assert_fail (assertion=3D0x441679 &quot;!ret&quot=
;, file=3D0x4415da &quot;hashtable.c&quot;, line=3D162, function=3D0x4416c0=
 &lt;__PRETTY_FUNCTION__.5555&gt; &quot;lttng_ht_destroy&quot;) at assert.c=
:101</div><div>No locals.</div><div>#4 =C2=A00x0000000000422f17 in lttng_ht=
_destroy (ht=3D0x65a0e0) at hashtable.c:162</div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ret =3D -1</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 __PRETTY_FUNCTION__=
 =3D &quot;lttng_ht_destroy&quot;</div><div>#5 =C2=A00x000000000040803b in =
relayd_cleanup () at main.c:497</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 __fun=
c__ =3D &quot;relayd_cleanup&quot;</div><div>#6 =C2=A00x000000000040ec4c in=
 main (argc=3D5, argv=3D0x7ffee9f1bd68) at main.c:2939</div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 ret =3D 0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =
=3D 0</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D 0x0</div><div>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 __func__ =3D &quot;main&quot;</div><div><br></div><di=
v><span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">		</span><=
/div><div>(gdb) f 4</div><div>#4 =C2=A00x0000000000422f17 in lttng_ht_destr=
oy (ht=3D0x65a0e0) at hashtable.c:162</div><div>162 =C2=A0 =C2=A0 hashtable=
.c: No such file or directory.</div><div>(gdb) p *ht-&gt;ht</div><div>$1 =
=3D {max_nr_buckets =3D 9223372036854775808, mm =3D 0x7fd7e6e50920 &lt;cds_=
lfht_mm_order&gt;,</div><div>flavor =3D 0x7fd7e77b6340 &lt;rcu_flavor_memb&=
gt;, count =3D -1024, resize_mutex =3D {__data =3D {</div><div>__lock =3D 0=
, __count =3D 0, __owner =3D 0, __nusers =3D 0, __kind =3D 0, __spins =3D 0=
,</div><div>=C2=A0 =C2=A0 =C2=A0 __elision =3D 0, __list =3D {__prev =3D 0x=
0, __next =3D 0x0}},</div><div>=C2=A0 =C2=A0 __size =3D &#39;\000&#39; &lt;=
repeats 39 times&gt;, __align =3D 0}, resize_attr =3D 0x0,</div><div>=C2=A0=
 in_progress_resize =3D 0, in_progress_destroy =3D 1, resize_target =3D 204=
8,</div><div>=C2=A0 resize_initiated =3D 0, flags =3D 3, min_alloc_buckets_=
order =3D 0, min_nr_alloc_buckets =3D 1,</div><div>=C2=A0 split_count =3D 0=
x65b170, .., bucket_at =3D 0x7fd7e6c4e080 &lt;bucket_at&gt;, {</div><div>=
=C2=A0 =C2=A0 tbl_order =3D {0x65b280, 0x65b2a0, 0x65b2c0, 0x7fd7c40008c0, =
0x7fd7c4000910,</div><div>=C2=A0 =C2=A0 =C2=A0 0x7fd7c40009a0, 0x7fd7c4000a=
b0, 0x7fd7c4001070, 0x7fd7c4001480, 0x7fd7c4001c90,</div><div>=C2=A0 =C2=A0=
 =C2=A0 0x7fd7c4003350, 0x7fd7c4005360, 0x0 &lt;repeats 52 times&gt;}, tbl_=
chunk =3D 0x65af60,</div><div>=C2=A0 =C2=A0 tbl_mmap =3D 0x65b280}}</div></=
div><div><br></div><div><br></div><div>Regards,</div><div>Aravind.</div></d=
iv>

--001a1143db986b93d105427576bb--

--===============8065419632500145293==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============8065419632500145293==--
