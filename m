From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Subject: =?utf-8?b?562U5aSNOiDnrZTlpI06IGx0dG5nIGxpc3QgLXUg?=
	=?utf-8?q?coredump?=
Date: Tue, 22 Oct 2013 11:49:19 +0800
Message-ID: <436ff36d-c5ec-464f-9f32-32137898f61d__18224.8557488949$1382413827$gmane$org@aliyun.com>
References: <7f26c4b5-6de0-46b8-8752-7c40d01e9655@aliyun.com> <",
	20130913140919.GA20034"@Krystal,
	ac1f03bd-cb96-43b1-8567-98684ab82191@aliyun.com>
	<00f8295a-e65f-4d53-8722-3f7c42f4ddd8@aliyun.com> <",
	1307757412.43408.1382023623436.JavaMail.zimbra"@efficios.com>
	<f5e3b3cb-118a-48b8-8fd6-29d63ee36e85@aliyun.com>,
	1005237918.46514.1382347246419.JavaMail.zimbra@efficios.com
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0346552220=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpcm9-312.freemail.mail.aliyun.com ([110.75.46.12])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <zhenyu.ren@aliyun.com>) id 1VYSyI-0001N2-B1
	for lttng-dev@lists.lttng.org; Mon, 21 Oct 2013 23:49:32 -0400
In-Reply-To: 1005237918.46514.1382347246419.JavaMail.zimbra@efficios.com
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, David Goulet <dgoulet@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0346552220==
Content-Type: multipart/alternative;
  boundary="----=ALIBOUNDARY_12666_53aa8940_5265f5bf_247b1"

------=ALIBOUNDARY_12666_53aa8940_5265f5bf_247b1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=0A>Therefore, the &(pos)->member !=3D NULL check will break out of the loop i=
mmediately,=0A=0AAs you pointed out,pos is a very large pointer value(i.e =C2=A0=
0xffffffffffffff88,say=C2=A0an invalid pointer) . Before check itself,=C2=A0&(=
pos)->member has been deferenced anyway.=0A>Please provide details about the l=
ttng-tools, lttng-ust, lttng-modules, userspace RCU versions you are usinglttn=
g-tools,lttng-ust and lttng-modules are 2.3.0,userspace RCU is 0.8.0thankszhen=
yu.ren=0A
------=ALIBOUNDARY_12666_53aa8940_5265f5bf_247b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div class=3D"__aliyun_email_body_block"><div style=3D""><br></div><div class=3D=
"__aliyun_signature_wrap">&gt;<span style=3D"font-family: 'times new roman', '=
new york', times, serif; font-size: 16px; line-height: 24px; ">Therefore, the =
&amp;(pos)-&gt;member !=3D NULL check will break out of the loop immediately,<=
/span><br><br></div><div class=3D"__aliyun_signature_wrap">As you pointed out,=
pos is a very large pointer value(i.e <span style=3D"color: rgb(51, 51, 51); f=
ont-size: 13px; line-height: 19px; ">&nbsp;0xffffffffffffff88,say</span>&nbsp;=
an invalid pointer) . Before check itself,&nbsp;<span style=3D"font-family: 't=
imes new roman', 'new york', times, serif; font-size: 16px; line-height: 24px;=
 ">&amp;(pos)-&gt;member has been deferenced anyway.</span><span style=3D"colo=
r: rgb(51, 51, 51); font-size: 13px; line-height: 19px; "><br></span></div><di=
v class=3D"__aliyun_signature_wrap"><span style=3D"font-family: 'times new rom=
an', 'new york', times, serif; font-size: 16px; line-height: 24px; "><br data-=
mce-bogus=3D"1"></span></div><div class=3D"__aliyun_signature_wrap"><span styl=
e=3D"font-family: 'times new roman', 'new york', times, serif; font-size: 16px=
; line-height: 24px; ">&gt;<span style=3D"font-family: 'times new roman', 'new=
 york', times, serif; font-size: 16px; line-height: 24px; ">Please provide det=
ails about the lttng-tools, lttng-ust, lttng-modules, userspace RCU versions y=
ou are using</span></span></div><div class=3D"__aliyun_signature_wrap"><span s=
tyle=3D"font-family: 'times new roman', 'new york', times, serif; font-size: 1=
6px; line-height: 24px; "><br data-mce-bogus=3D"1"></span></div><div class=3D"=
__aliyun_signature_wrap"><span style=3D"font-family: 'times new roman', 'new y=
ork', times, serif; font-size: 16px; line-height: 24px; ">lttng-tools,lttng-us=
t and lttng-modules are 2.3.0,userspace RCU is 0.8.0</span></div><div class=3D=
"__aliyun_signature_wrap"><span style=3D"font-family: 'times new roman', 'new =
york', times, serif; font-size: 16px; line-height: 24px; "><br data-mce-bogus=3D=
"1"></span></div><div class=3D"__aliyun_signature_wrap"><span style=3D"font-fa=
mily: 'times new roman', 'new york', times, serif; font-size: 16px; line-heigh=
t: 24px; ">thanks</span></div><div class=3D"__aliyun_signature_wrap"><span sty=
le=3D"font-family: 'times new roman', 'new york', times, serif; font-size: 16p=
x; line-height: 24px; ">zhenyu.ren</span></div><div class=3D"__aliyun_previous=
_quote"><div style=3D"font-family: times new roman , new york , times , serif;=
font-size: 12.0pt;color: #000000;"><div><br></div></div></div></div>
------=ALIBOUNDARY_12666_53aa8940_5265f5bf_247b1--



--===============0346552220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0346552220==--
