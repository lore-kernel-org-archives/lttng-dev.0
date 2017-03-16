From: Anders Wallin <wallinux@gmail.com>
Subject: lttng-consumerd crash when lttng-relayd is killed
Date: Thu, 16 Mar 2017 11:32:57 +0100
Message-ID: <CAF2baFde4LrR1N7O_tfs-6tXrVOFf1fR3mi-H3gJHtynJ+eZJw__21754.7788437971$1489660398$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7161777809545186757=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vk0-x243.google.com (mail-vk0-x243.google.com
 [IPv6:2607:f8b0:400c:c05::243])
 by lists.lttng.org (Postfix) with ESMTPS id 3vkPv64GrNzwbv
 for <lttng-dev@lists.lttng.org>; Thu, 16 Mar 2017 10:33:06 +0000 (UTC)
Received: by mail-vk0-x243.google.com with SMTP id d188so2856710vka.3
 for <lttng-dev@lists.lttng.org>; Thu, 16 Mar 2017 03:32:59 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============7161777809545186757==
Content-Type: multipart/alternative; boundary=001a11425878aa2f3c054ad695fe

--001a11425878aa2f3c054ad695fe
Content-Type: text/plain; charset=UTF-8

Hi,

We have found a a crash in lttng-consumerd when a live session is running
and the lttng-relayd is killed. The crash is from lttng-tools version
2.8.6, but the same problem/code is in newer versions.
This crash is from slightly modified version of 2.8.6, so the lines may not
be correct, but the issue has been reproduced on 2.8.6 w/o patches on an
arm target. The problem was introduced with
8dbd7d838dc2276e5a25057c76c2e219e1d2661b

(gdb)  bt
#0  lttng_index_file_write (index_file=0x0, element=element@entry=0xb3dfea40)
at index.c:132
#1  0x00024798 in consumer_stream_write_index (stream=stream@entry=0xb3f090b0,
element=element@entry=0xb3dfea40) at consumer-stream.c:375
#2  0x00021fb0 in send_empty_index (stream_id=<optimized out>,
ts=<optimized out>, stream=0xb3f090b0) at consumer-timer.c:125
#3  consumer_flush_ust_index (stream=0xb3f090b0) at consumer-timer.c:246
#4  0x0002323c in check_ust_stream (stream=0xb3f090b0) at
consumer-timer.c:297
#5  live_timer (ctx=<optimized out>, sig=<optimized out>, si=0xb3dfebd0,
uc=0x0) at consumer-timer.c:333
#6  consumer_timer_thread (data=0x0) at consumer-timer.c:591
#7  0xb6f000dc in start_thread (arg=0xb3dff340) at pthread_create.c:339
#8  0xb6e89130 in ?? () at ../sysdeps/unix/sysv/linux/arm/clone.S:89 from
/proj/cpptemp/plf_tools/licop-rcs/CXP9031275_4-R9C22/sysroot/lib/libc.so.6
#9  0xb6e89130 in ?? () at ../sysdeps/unix/sysv/linux/arm/clone.S:89 from
/proj/cpptemp/plf_tools/licop-rcs/CXP9031275_4-R9C22/sysroot/lib/libc.so.6
Backtrace stopped: previous frame identical to this frame (corrupt stack?)


The problem happens when;

./src/common/index/index.c
-------------------------------------
int consumer_stream_write_index(struct lttng_consumer_stream *stream,
struct ctf_packet_index *element)
{
int ret;
struct consumer_relayd_sock_pair *relayd;

assert(stream);
assert(element);

rcu_read_lock();
relayd = consumer_find_relayd(stream->net_seq_idx);
>> relayd is shutdown
if (relayd) {
pthread_mutex_lock(&relayd->ctrl_sock_mutex);
ret = relayd_send_index(&relayd->control_sock, element,
stream->relayd_stream_id, stream->next_net_seq_num - 1);
pthread_mutex_unlock(&relayd->ctrl_sock_mutex);
} else {
if (lttng_index_file_write(stream->index_file, element)) {
>> We get in here, but stream->index_file is set to NULL in
consumer_stream_close()
ret = -1;
} else {
ret = 0;
}
}
if (ret < 0) {
goto error;
}

src/common/consumer/consumer-stream.c
---------------------------------------------------------
void consumer_stream_close(struct lttng_consumer_stream *stream)
{
int ret;
struct consumer_relayd_sock_pair *relayd;

assert(stream);

switch (consumer_data.type) {
case LTTNG_CONSUMER_KERNEL:
.....
case LTTNG_CONSUMER32_UST:
case LTTNG_CONSUMER64_UST:
{
...
if (stream->index_file) {
lttng_index_file_put(stream->index_file);
stream->index_file = NULL;
>> Here is stream->index_file set to NULL
}
.....

The following patch fixes the crash, but it's a "band aid" patch since the
flow is
broken and it only fixes the crash. I was not able to find the correct flow
to fix the issue, but maybe the band aid patch should be included anyway!

From fc896fe08e30435b9d3c78fa4551b2dc5042fb03 Mon Sep 17 00:00:00 2001
From: Anders Wallin <wallinux@gmail.com>
Date: Thu, 16 Mar 2017 11:15:23 +0100
Subject: [PATCH lttng-tools] Fix: crash in lttng-consumerd when lttng-relayd
 is killed

Fixes this crash:
0  lttng_index_file_write (index_file=0x0, element=element@entry=0xb3dfea40)
at index.c:132
1  0x00024798 in consumer_stream_write_index (stream=stream@entry=0xb3f090b0,
element=element@entry=0xb3dfea40) at consumer-stream.c:375
2  0x00021fb0 in send_empty_index (stream_id=<optimized out>, ts=<optimized
out>, stream=0xb3f090b0) at consumer-timer.c:125
3  consumer_flush_ust_index (stream=0xb3f090b0) at consumer-timer.c:246
4  0x0002323c in check_ust_stream (stream=0xb3f090b0) at
consumer-timer.c:297
5  live_timer (ctx=<optimized out>, sig=<optimized out>, si=0xb3dfebd0,
uc=0x0) at consumer-timer.c:333
6  consumer_timer_thread (data=0x0) at consumer-timer.c:591

Signed-off-by: Anders Wallin <wallinux@gmail.com>
---
 src/common/index/index.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/common/index/index.c b/src/common/index/index.c
index b481badb..008d877b 100644
--- a/src/common/index/index.c
+++ b/src/common/index/index.c
@@ -129,11 +129,19 @@ int lttng_index_file_write(const struct
lttng_index_file *index_file,
  const struct ctf_packet_index *element)
 {
  ssize_t ret;
- int fd = index_file->fd;
- size_t len = index_file->element_len;
+ int fd;
+ size_t len;

  assert(element);

+ if (index_file == NULL) {
+ PERROR("index file is NULL");
+ goto error;
+ }
+
+ fd = index_file->fd;
+ len = index_file->element_len;
+
  if (fd < 0) {
  goto error;
  }

-- 
2.11.0

Anders Wallin

--001a11425878aa2f3c054ad695fe
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>We have found a a crash =
in lttng-consumerd when a live session is running and the lttng-relayd is k=
illed. The crash is from lttng-tools version 2.8.6, but the same problem/co=
de is in newer versions.</div><div>This crash is from slightly modified ver=
sion of 2.8.6, so the lines may not be correct, but the issue has been repr=
oduced on 2.8.6 w/o patches on an arm target. The problem was introduced wi=
th</div><div>8dbd7d838dc2276e5a25057c76c2e219e1d2661b</div><div><br></div><=
div>(gdb) =C2=A0bt</div><div>#0 =C2=A0lttng_index_file_write (index_file=3D=
0x0, element=3Delement@entry=3D0xb3dfea40) at index.c:132</div><div>#1 =C2=
=A00x00024798 in consumer_stream_write_index (stream=3Dstream@entry=3D0xb3f=
090b0, element=3Delement@entry=3D0xb3dfea40) at consumer-stream.c:375</div>=
<div>#2 =C2=A00x00021fb0 in send_empty_index (stream_id=3D&lt;optimized out=
&gt;, ts=3D&lt;optimized out&gt;, stream=3D0xb3f090b0) at consumer-timer.c:=
125</div><div>#3 =C2=A0consumer_flush_ust_index (stream=3D0xb3f090b0) at co=
nsumer-timer.c:246</div><div>#4 =C2=A00x0002323c in check_ust_stream (strea=
m=3D0xb3f090b0) at consumer-timer.c:297</div><div>#5 =C2=A0live_timer (ctx=
=3D&lt;optimized out&gt;, sig=3D&lt;optimized out&gt;, si=3D0xb3dfebd0, uc=
=3D0x0) at consumer-timer.c:333</div><div>#6 =C2=A0consumer_timer_thread (d=
ata=3D0x0) at consumer-timer.c:591</div><div>#7 =C2=A00xb6f000dc in start_t=
hread (arg=3D0xb3dff340) at pthread_create.c:339</div><div>#8 =C2=A00xb6e89=
130 in ?? () at ../sysdeps/unix/sysv/linux/arm/clone.S:89 from /proj/cpptem=
p/plf_tools/licop-rcs/CXP9031275_4-R9C22/sysroot/lib/libc.so.6</div><div>#9=
 =C2=A00xb6e89130 in ?? () at ../sysdeps/unix/sysv/linux/arm/clone.S:89 fro=
m /proj/cpptemp/plf_tools/licop-rcs/CXP9031275_4-R9C22/sysroot/lib/libc.so.=
6</div><div>Backtrace stopped: previous frame identical to this frame (corr=
upt stack?)</div><div><br></div><div><br></div><div>The problem happens whe=
n;</div><div><br></div><div>./src/common/index/index.c</div><div>----------=
---------------------------</div><div>int consumer_stream_write_index(struc=
t lttng_consumer_stream *stream,</div><div><span class=3D"gmail-Apple-tab-s=
pan" style=3D"white-space:pre">		</span>struct ctf_packet_index *element)</=
div><div>{</div><div><span class=3D"gmail-Apple-tab-span" style=3D"white-sp=
ace:pre">	</span>int ret;</div><div><span class=3D"gmail-Apple-tab-span" st=
yle=3D"white-space:pre">	</span>struct consumer_relayd_sock_pair *relayd;</=
div><div><br></div><div><span class=3D"gmail-Apple-tab-span" style=3D"white=
-space:pre">	</span>assert(stream);</div><div><span class=3D"gmail-Apple-ta=
b-span" style=3D"white-space:pre">	</span>assert(element);</div><div><br></=
div><div><span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">	</=
span>rcu_read_lock();</div><div><span class=3D"gmail-Apple-tab-span" style=
=3D"white-space:pre">	</span>relayd =3D consumer_find_relayd(stream-&gt;net=
_seq_idx);</div><div>&gt;&gt; relayd is shutdown</div><div><span class=3D"g=
mail-Apple-tab-span" style=3D"white-space:pre">	</span>if (relayd) {</div><=
div><span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">		</span=
>pthread_mutex_lock(&amp;relayd-&gt;ctrl_sock_mutex);</div><div><span class=
=3D"gmail-Apple-tab-span" style=3D"white-space:pre">		</span>ret =3D relayd=
_send_index(&amp;relayd-&gt;control_sock, element,</div><div><span class=3D=
"gmail-Apple-tab-span" style=3D"white-space:pre">				</span>stream-&gt;rela=
yd_stream_id, stream-&gt;next_net_seq_num - 1);</div><div><span class=3D"gm=
ail-Apple-tab-span" style=3D"white-space:pre">		</span>pthread_mutex_unlock=
(&amp;relayd-&gt;ctrl_sock_mutex);</div><div><span class=3D"gmail-Apple-tab=
-span" style=3D"white-space:pre">	</span>} else {</div><div><span class=3D"=
gmail-Apple-tab-span" style=3D"white-space:pre">		</span>if (lttng_index_fi=
le_write(stream-&gt;index_file, element)) {</div><div>&gt;&gt; We get in he=
re, but stream-&gt;index_file is set to NULL in consumer_stream_close()</di=
v><div><span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">			</=
span>ret =3D -1;</div><div><span class=3D"gmail-Apple-tab-span" style=3D"wh=
ite-space:pre">		</span>} else {</div><div><span class=3D"gmail-Apple-tab-s=
pan" style=3D"white-space:pre">			</span>ret =3D 0;</div><div><span class=
=3D"gmail-Apple-tab-span" style=3D"white-space:pre">		</span>}</div><div><s=
pan class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">	</span>}</div=
><div><span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">	</spa=
n>if (ret &lt; 0) {</div><div><span class=3D"gmail-Apple-tab-span" style=3D=
"white-space:pre">		</span>goto error;</div><div><span class=3D"gmail-Apple=
-tab-span" style=3D"white-space:pre">	</span>}</div><div><br></div><div>src=
/common/consumer/consumer-stream.c</div><div>------------------------------=
---------------------------</div><div>void consumer_stream_close(struct ltt=
ng_consumer_stream *stream)</div><div>{</div><div><span class=3D"gmail-Appl=
e-tab-span" style=3D"white-space:pre">	</span>int ret;</div><div><span clas=
s=3D"gmail-Apple-tab-span" style=3D"white-space:pre">	</span>struct consume=
r_relayd_sock_pair *relayd;</div><div><br></div><div><span class=3D"gmail-A=
pple-tab-span" style=3D"white-space:pre">	</span>assert(stream);</div><div>=
<br></div><div><span class=3D"gmail-Apple-tab-span" style=3D"white-space:pr=
e">	</span>switch (consumer_data.type) {</div><div><span class=3D"gmail-App=
le-tab-span" style=3D"white-space:pre">	</span>case LTTNG_CONSUMER_KERNEL:<=
/div><div>.....</div><div><span class=3D"gmail-Apple-tab-span" style=3D"whi=
te-space:pre">	</span>case LTTNG_CONSUMER32_UST:</div><div><span class=3D"g=
mail-Apple-tab-span" style=3D"white-space:pre">	</span>case LTTNG_CONSUMER6=
4_UST:</div><div><span class=3D"gmail-Apple-tab-span" style=3D"white-space:=
pre">	</span>{</div><div>...</div><div><span class=3D"gmail-Apple-tab-span"=
 style=3D"white-space:pre">	</span>if (stream-&gt;index_file) {</div><div><=
span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">		</span>lttn=
g_index_file_put(stream-&gt;index_file);</div><div><span class=3D"gmail-App=
le-tab-span" style=3D"white-space:pre">		</span>stream-&gt;index_file =3D N=
ULL;</div><div>&gt;&gt; Here is stream-&gt;index_file set to NULL</div><div=
><span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">	</span>}</=
div><div>.....</div><div><br></div><div>The following patch fixes the crash=
, but it&#39;s a &quot;band aid&quot; patch since the flow is=C2=A0</div><d=
iv>broken and it only fixes the crash. I was not able to find the correct f=
low to fix the issue, but maybe the band aid patch should be included anywa=
y!</div><div><br></div><div>From fc896fe08e30435b9d3c78fa4551b2dc5042fb03 M=
on Sep 17 00:00:00 2001</div><div>From: Anders Wallin &lt;<a href=3D"mailto=
:wallinux@gmail.com">wallinux@gmail.com</a>&gt;</div><div>Date: Thu, 16 Mar=
 2017 11:15:23 +0100</div><div>Subject: [PATCH lttng-tools] Fix: crash in l=
ttng-consumerd when lttng-relayd</div><div>=C2=A0is killed</div><div><br></=
div><div>Fixes this crash:</div><div>0 =C2=A0lttng_index_file_write (index_=
file=3D0x0, element=3Delement@entry=3D0xb3dfea40) at index.c:132</div><div>=
1 =C2=A00x00024798 in consumer_stream_write_index (stream=3Dstream@entry=3D=
0xb3f090b0, element=3Delement@entry=3D0xb3dfea40) at consumer-stream.c:375<=
/div><div>2 =C2=A00x00021fb0 in send_empty_index (stream_id=3D&lt;optimized=
 out&gt;, ts=3D&lt;optimized out&gt;, stream=3D0xb3f090b0) at consumer-time=
r.c:125</div><div>3 =C2=A0consumer_flush_ust_index (stream=3D0xb3f090b0) at=
 consumer-timer.c:246</div><div>4 =C2=A00x0002323c in check_ust_stream (str=
eam=3D0xb3f090b0) at consumer-timer.c:297</div><div>5 =C2=A0live_timer (ctx=
=3D&lt;optimized out&gt;, sig=3D&lt;optimized out&gt;, si=3D0xb3dfebd0, uc=
=3D0x0) at consumer-timer.c:333</div><div>6 =C2=A0consumer_timer_thread (da=
ta=3D0x0) at consumer-timer.c:591</div><div><br></div><div>Signed-off-by: A=
nders Wallin &lt;<a href=3D"mailto:wallinux@gmail.com">wallinux@gmail.com</=
a>&gt;</div><div>---</div><div>=C2=A0src/common/index/index.c | 12 ++++++++=
++--</div><div>=C2=A01 file changed, 10 insertions(+), 2 deletions(-)</div>=
<div><br></div><div>diff --git a/src/common/index/index.c b/src/common/inde=
x/index.c</div><div>index b481badb..008d877b 100644</div><div>--- a/src/com=
mon/index/index.c</div><div>+++ b/src/common/index/index.c</div><div>@@ -12=
9,11 +129,19 @@ int lttng_index_file_write(const struct lttng_index_file *i=
ndex_file,</div><div>=C2=A0<span class=3D"gmail-Apple-tab-span" style=3D"wh=
ite-space:pre">		</span>const struct ctf_packet_index *element)</div><div>=
=C2=A0{</div><div>=C2=A0<span class=3D"gmail-Apple-tab-span" style=3D"white=
-space:pre">	</span>ssize_t ret;</div><div>-<span class=3D"gmail-Apple-tab-=
span" style=3D"white-space:pre">	</span>int fd =3D index_file-&gt;fd;</div>=
<div>-<span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">	</spa=
n>size_t len =3D index_file-&gt;element_len;</div><div>+<span class=3D"gmai=
l-Apple-tab-span" style=3D"white-space:pre">	</span>int fd;</div><div>+<spa=
n class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">	</span>size_t l=
en;</div><div>=C2=A0</div><div>=C2=A0<span class=3D"gmail-Apple-tab-span" s=
tyle=3D"white-space:pre">	</span>assert(element);</div><div>=C2=A0</div><di=
v>+<span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">	</span>i=
f (index_file =3D=3D NULL) {</div><div>+<span class=3D"gmail-Apple-tab-span=
" style=3D"white-space:pre">		</span>PERROR(&quot;index file is NULL&quot;)=
;</div><div>+<span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre"=
>		</span>goto error;</div><div>+<span class=3D"gmail-Apple-tab-span" style=
=3D"white-space:pre">	</span>}</div><div>+</div><div>+<span class=3D"gmail-=
Apple-tab-span" style=3D"white-space:pre">	</span>fd =3D index_file-&gt;fd;=
</div><div>+<span class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">=
	</span>len =3D index_file-&gt;element_len;</div><div>+</div><div>=C2=A0<sp=
an class=3D"gmail-Apple-tab-span" style=3D"white-space:pre">	</span>if (fd =
&lt; 0) {</div><div>=C2=A0<span class=3D"gmail-Apple-tab-span" style=3D"whi=
te-space:pre">		</span>goto error;</div><div>=C2=A0<span class=3D"gmail-App=
le-tab-span" style=3D"white-space:pre">	</span>}</div><div><br></div><div>-=
-=C2=A0</div><div>2.11.0</div><div><br></div><div><div class=3D"gmail_signa=
ture">Anders Wallin</div></div>
</div>

--001a11425878aa2f3c054ad695fe--

--===============7161777809545186757==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============7161777809545186757==--
