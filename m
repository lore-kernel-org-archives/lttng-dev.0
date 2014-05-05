From: Ruslan Uvashev <ruslan.uvashev@gmail.com>
Subject: =?utf-8?q?_=5BPATCH_lttng-tools=5D_lttng_list_shows_t?=
	=?utf-8?q?racefile-size_and_tracefile=E2=80=93count?=
Date: Sun, 4 May 2014 23:00:06 -0700
Message-ID: <CACQ=--R4ux6ywUNswAw_QBrKwuhgH-0hR8jipALgGQHy0sucfw__6237.09262949905$1399398552$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0487185829=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ruslan.uvashev@gmail.com>) id 1WhBwi-00074q-Kb
 for lttng-dev@lists.lttng.org; Mon, 05 May 2014 02:00:13 -0400
Received: by mail-ig0-f173.google.com with SMTP id hn18so4316449igb.6
 for <lttng-dev@lists.lttng.org>; Sun, 04 May 2014 23:00:07 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0487185829==
Content-Type: multipart/alternative; boundary=047d7b3a9c0adf0f2e04f8a0d7f8

--047d7b3a9c0adf0f2e04f8a0d7f8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The lttng list <session> command gives the subbuf-size and num-subbuf
values of each channel
along with all their other attributes, except for their tracefile-size and
tracefile=E2=80=93count values.

Fixes: #642

Signed-off-by: Ruslan Uvashev <Ruslan.Uvashev@gmail.com>
---
 src/bin/lttng/commands/list.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c
index f69b3ba..8f47cc9 100644
--- a/src/bin/lttng/commands/list.c
+++ b/src/bin/lttng/commands/list.c
@@ -645,6 +645,8 @@ static void print_channel(struct lttng_channel *channel=
)
  MSG("%snumber of subbufers: %" PRIu64, indent6, channel->attr.num_subbuf)=
;
  MSG("%sswitch timer interval: %u", indent6,
channel->attr.switch_timer_interval);
  MSG("%sread timer interval: %u", indent6,
channel->attr.read_timer_interval);
+ MSG("%stracefile count: %" PRIu64, indent6,
channel->attr.tracefile_count);
+ MSG("%stracefile size: %" PRIu64, indent6, channel->attr.tracefile_size);
  switch (channel->attr.output) {
  case LTTNG_EVENT_SPLICE:
  MSG("%soutput: splice()", indent6);
--=20
1.8.3.2



-------------------------------------
Best regards,
Ruslan Uvashev

--047d7b3a9c0adf0f2e04f8a0d7f8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>The lttng list &lt;session&gt; command gives the=
 subbuf-size and num-subbuf values of each channel</div><div>along with all=
 their other attributes, except for their tracefile-size and tracefile=E2=
=80=93count values.</div>
<div><br></div><div>Fixes: #642</div><div><br></div><div>Signed-off-by: Rus=
lan Uvashev &lt;<a href=3D"mailto:Ruslan.Uvashev@gmail.com">Ruslan.Uvashev@=
gmail.com</a>&gt;</div><div>---</div><div>=C2=A0src/bin/lttng/commands/list=
.c | 2 ++</div>
<div>=C2=A01 file changed, 2 insertions(+)</div><div><br></div><div>diff --=
git a/src/bin/lttng/commands/list.c b/src/bin/lttng/commands/list.c</div><d=
iv>index f69b3ba..8f47cc9 100644</div><div>--- a/src/bin/lttng/commands/lis=
t.c</div>
<div>+++ b/src/bin/lttng/commands/list.c</div><div>@@ -645,6 +645,8 @@ stat=
ic void print_channel(struct lttng_channel *channel)</div><div>=C2=A0<span =
class=3D"" style=3D"white-space:pre">	</span>MSG(&quot;%snumber of subbufer=
s: %&quot; PRIu64, indent6, channel-&gt;attr.num_subbuf);</div>
<div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>MSG(&quot;%ss=
witch timer interval: %u&quot;, indent6, channel-&gt;attr.switch_timer_inte=
rval);</div><div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>M=
SG(&quot;%sread timer interval: %u&quot;, indent6, channel-&gt;attr.read_ti=
mer_interval);</div>
<div>+<span class=3D"" style=3D"white-space:pre">	</span>MSG(&quot;%stracef=
ile count: %&quot; PRIu64, indent6, channel-&gt;attr.tracefile_count);</div=
><div>+<span class=3D"" style=3D"white-space:pre">	</span>MSG(&quot;%strace=
file size: %&quot; PRIu64, indent6, channel-&gt;attr.tracefile_size);</div>
<div>=C2=A0<span class=3D"" style=3D"white-space:pre">	</span>switch (chann=
el-&gt;attr.output) {</div><div>=C2=A0<span class=3D"" style=3D"white-space=
:pre">		</span>case LTTNG_EVENT_SPLICE:</div><div>=C2=A0<span class=3D"" st=
yle=3D"white-space:pre">			</span>MSG(&quot;%soutput: splice()&quot;, inden=
t6);</div>
<div>--=C2=A0</div><div>1.8.3.2</div></div><div><br></div><div><br></div><b=
r clear=3D"all"><div><div dir=3D"ltr">-------------------------------------=
<br>Best regards,<br>Ruslan Uvashev<div><br></div><div><br></div></div></di=
v>
</div>

--047d7b3a9c0adf0f2e04f8a0d7f8--


--===============0487185829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0487185829==--
