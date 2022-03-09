Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD1BC433F5
	for <lttng-dev@archiver.kernel.org>; Wed,  9 Mar 2022 17:07:21 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KDJXS3GnDzBSZ;
	Wed,  9 Mar 2022 12:07:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1646845641;
	bh=LHrvEBSo/R7sn+JfJ5fkaFyp+A+G1D0uytzq6lgF5hw=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=cx8l6BgzuVMxIyAEHQzibaivAgpbGPz2JqJx25Pphu90chXxr8NeqzBAQfe1Lj1SZ
	 f+mP/EnFZq/MBBjfaEPbUUjZYT9k08dPtaRpK1Kab9t3EIlwxNVIX6Su0qb0JISkf6
	 XL8X58R65QhP94CVMKAqmhacj4gc09irHKKOqpvedcuI63LAFLUcn4ortdxgPcPjt4
	 6EaRg5VII880KQBPCmEYOZUL56payLmYdpQYF75Qk7s+Kom2FPhcimvGWmx1hlOJjt
	 /VbT5ovlYW557Gk1aRWygOUVY0nLmK6Wn4Ck4WCrmOpFr1mRow0PPWjysynnSOVxkI
	 dGYwcVV1h6Ajw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KDJXR0HvqzBN3
 for <lttng-dev@lists.lttng.org>; Wed,  9 Mar 2022 12:07:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 988E3394650;
 Wed,  9 Mar 2022 12:07:12 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id p6__luPsqRhO; Wed,  9 Mar 2022 12:07:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 9CE1F394771;
 Wed,  9 Mar 2022 12:07:11 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9CE1F394771
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 6IHSwPdnh5Ge; Wed,  9 Mar 2022 12:07:11 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 8594B394A17;
 Wed,  9 Mar 2022 12:07:11 -0500 (EST)
Date: Wed, 9 Mar 2022 12:07:11 -0500 (EST)
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Message-ID: <1773574115.134463.1646845631405.JavaMail.zimbra@efficios.com>
In-Reply-To: <816104861.134170.1646843822208.JavaMail.zimbra@efficios.com>
References: <e706d6c8-edea-4f26-a9e2-4a66f067204e.zhenyu.ren@aliyun.com>
 <cbf6b471-85d1-46f5-b10b-2a643b79433c.zhenyu.ren@aliyun.com>
 <c0e023fd-bd52-4125-9e50-c096167386ff.zhenyu.ren@aliyun.com>
 <20220225142111.GC1861057@x>
 <26341add-b962-4027-8c5e-28d940e8f4dc.zhenyu.ren@aliyun.com>
 <2119663162.129405.1646752637020.JavaMail.zimbra@efficios.com>
 <1a87b3ee-9983-4db6-b569-e6e6c1ab8411.zhenyu.ren@aliyun.com>
 <816104861.134170.1646843822208.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF97 (Linux)/8.8.15_GA_4232)
Thread-Topic: =?utf-8?B?5Zue5aSN77yaW2x0dG5nLWRldl0g5Zue5aSN77yaIOWbnuWkje+8miDlm57lpI3vvJo=?=
 shm leak in traced application?
Thread-Index: jw7LRmFAcVsMJPBj4cp2PGx88gfkXAQVU1V6
Subject: Re: [lttng-dev] 
 =?utf-8?b?5Zue5aSN77yaIOWbnuWkje+8miDlm57lpI3vvJog?=
 =?utf-8?b?5Zue5aSN77yaIHNobSBsZWFrIGluIHRyYWNlZCBhcHBsaWNhdGlvbj8=?=
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Mathieu Desnoyers via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Content-Type: multipart/mixed; boundary="===============5146134758815724167=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============5146134758815724167==
Content-Type: multipart/alternative; 
	boundary="=_33316504-2f92-49a7-a1f5-21db56df6daf"

--=_33316504-2f92-49a7-a1f5-21db56df6daf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Zhenyu,=20

Can you try this fix please ?=20

https://review.lttng.org/c/lttng-ust/+/7530=20

And let me know how it goes.=20

Thanks,=20

Mathieu=20

----- On Mar 9, 2022, at 11:37 AM, Mathieu Desnoyers <mathieu.desnoyers@eff=
icios.com> wrote:=20

> When this happpens, is the process holding a single (or very few) shm fil=
e
> references, or references to many
> shm files ?

> I wonder if you end up in a scenario where an application very frequently
> performs exec(), and therefore
> sometimes the exec() will happen in the window between the unix socket fi=
le
> descriptor reception and
> call to fcntl FD_CLOEXEC.

> Thanks,

> Mathieu

> ----- On Mar 8, 2022, at 8:29 PM, zhenyu.ren <zhenyu.ren@aliyun.com> wrot=
e:

>> Thanks a lot for reply. I do not reply it in bug tracker since I have no=
t gotten
>> a reliable way to reproduce the leak case.

>>> ------------------------------------------------------------------
>>> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AMathieu Desnoyers <mathieu.desnoyer=
s@efficios.com>
>>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B43=E6=9C=888=
=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=8C) 23:26
>>> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren <zhenyu.ren@aliyun.com>
>>> =E6=8A=84 =E9=80=81=EF=BC=9AJonathan Rajotte <jonathan.rajotte-julien@e=
fficios.com>; lttng-dev
>>> <lttng-dev@lists.lttng.org>
>>> =E4=B8=BB =E9=A2=98=EF=BC=9ARe: [lttng-dev] =E5=9B=9E=E5=A4=8D=EF=BC=9A=
 =E5=9B=9E=E5=A4=8D=EF=BC=9A =E5=9B=9E=E5=A4=8D=EF=BC=9A shm leak in traced=
 application?

>>> ----- On Mar 8, 2022, at 12:18 AM, lttng-dev lttng-dev@lists.lttng.org =
wrote:

>>> > Hi,
>>> > In shm_object_table_append_shm()/alloc_shm()=EF=BC=8C why not calling=
 FD_CLOEXEC fcntl()
>>> > to shmfds? I guess this omission leads to shm fds leak.

>>> Those file descriptors are created when received by ustcomm_recv_fds_un=
ix_sock,
>>> and
>>> immediately after creation they are set as FD_CLOEXEC.

>>> We should continue this discussion in the bug tracker as suggested by J=
onathan.
>>> It would greatly help if you can provide a small reproducer.

>>> Thanks,

>>> Mathieu

>>> > Thanks
>>> > zhenyu.ren

>>> >> ------------------------------------------------------------------
>>> >> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AJonathan Rajotte-Julien <jonatha=
n.rajotte-julien@efficios.com>
>>> >> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B42=E6=9C=88=
25=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=94) 22:31
>>> >> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren <zhenyu.ren@aliyun.co=
m>
>>> >> =E6=8A=84 =E9=80=81=EF=BC=9Alttng-dev <lttng-dev@lists.lttng.org>
>>> >> =E4=B8=BB =E9=A2=98=EF=BC=9ARe: [lttng-dev] =E5=9B=9E=E5=A4=8D=EF=BC=
=9A =E5=9B=9E=E5=A4=8D=EF=BC=9A shm leak in traced application?

>>> >> Hi zhenyu.ren,

>>> >> Please open a bug on our bug tracker and provide a reproducer agains=
t the latest
>>> >> stable version (2.13.x).

>>> >> https://bugs.lttng.org/

>>> >> Please follow the guidelines: https://bugs.lttng.org/#Bug-reporting-=
guidelines

>>> >> Cheers

>>> >> On Fri, Feb 25, 2022 at 12:47:34PM +0800, zhenyu.ren via lttng-dev w=
rote:
>>> >> > Hi, lttng-dev team
>>> >>> When lttng-sessiond exits, the ust applications should call
>>> >>> lttng_ust_objd_table_owner_cleanup() and clean up all shm resource(=
unmap and
>>> >>> close). Howerver I do find that the ust applications keep opening "=
all" of the
>>> >> > shm fds("/dev/shm/ust-shm-consumer-81132 (deleted)") and do NOT fr=
ee shm.
>>> >>> If we run lttng-sessiond again, ust applications can get a new piec=
e of shm and
>>> >>> a new list of shm fds so double shm usages. Then if we kill lttng-s=
essiond,
>>> >>> what the mostlikely happened is ust applications close the new list=
 of shm fds
>>> >>> and free new shm resource but keeping old shm still. In other word,=
 we can not
>>> >> > free this piece of shm unless we killing ust applications!!!
>>> >>> So Is there any possilbe that ust applications failed calling
>>> >>> lttng_ust_objd_table_owner_cleanup()? Do you have ever see this pro=
blem? Do you
>>> >>> have any advice to free the shm without killling ust applications(I=
 tried to
>>> >> > dig into kernel shm_open and /dev/shm, but not found any ideas)?

>>> >> > Thanks in advance
>>> >> > zhenyu.ren

>>> >> > ------------------------------------------------------------------
>>> >> > =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren via lttng-dev <lttn=
g-dev@lists.lttng.org>
>>> >> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B42=E6=9C=
=8823=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=B8=89) 23:09
>>> >> > =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Alttng-dev <lttng-dev@lists.ltt=
ng.org>
>>> >> > =E4=B8=BB =E9=A2=98=EF=BC=9A[lttng-dev] =E5=9B=9E=E5=A4=8D=EF=BC=
=9A shm leak in traced application?

>>> >>> >"I found these items also exist in a traced application which is a=
 long-time
>>> >> > >running daemon"
>>> >> > Even if lttng-sessiond has been killed!!

>>> >> > Thanks
>>> >> > zhenyu.ren
>>> >> > ------------------------------------------------------------------
>>> >> > =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren via lttng-dev <lttn=
g-dev@lists.lttng.org>
>>> >> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B42=E6=9C=
=8823=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=B8=89) 22:44
>>> >> > =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Alttng-dev <lttng-dev@lists.ltt=
ng.org>
>>> >> > =E4=B8=BB =E9=A2=98=EF=BC=9A[lttng-dev] shm leak in traced applica=
tion?

>>> >> > Hi,
>>> >>> There are many items such as "/dev/shm/ust-shm-consumer-81132 (dele=
ted)" exist
>>> >>> in lttng-sessiond fd spaces. I know it is the result of shm_open() =
and
>>> >> > shm_unlnik() in create_posix_shm().
>>> >>> However, today, I found these items also exist in a traced applicat=
ion which is
>>> >>> a long-time running daemon. The most important thing I found is tha=
t there
>>> >> > seems no reliable way to release share memory.
>>> >>> I tried to kill lttng-sessiond but not always release share memory.=
 Sometimes I
>>> >>> need to kill the traced application to free share memory....But it =
is not a
>>> >> > good idea to kill these applications.
>>> >> > My questions are:
>>> >>> 1. Is there any way to release share memory without killing any tra=
ced
>>> >> > application?
>>> >>> 2. Is it normal that many items such as "/dev/shm/ust-shm-consumer-=
81132
>>> >> > (deleted)" exist in the traced application?

>>> >> > Thanks
>>> >> > zhenyu.ren

>>> >> > _______________________________________________
>>> >> > lttng-dev mailing list
>>> >> > lttng-dev@lists.lttng.org
>>> >> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

>>> >> --
>>> >> Jonathan Rajotte-Julien
>>> >> EfficiOS
>>> > _______________________________________________
>>> > lttng-dev mailing list
>>> > lttng-dev@lists.lttng.org
>>> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>> --
>>> Mathieu Desnoyers
>>> EfficiOS Inc.
>>> http://www.efficios.com
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_33316504-2f92-49a7-a1f5-21db56df6daf
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi Zhenyu,<br></div><div><br data-mce-bogus=
=3D"1"></div><div>Can you try this fix please ?<br data-mce-bogus=3D"1"></d=
iv><div><br data-mce-bogus=3D"1"></div><div>https://review.lttng.org/c/lttn=
g-ust/+/7530<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></=
div><div>And let me know how it goes.<br data-mce-bogus=3D"1"></div><div><b=
r data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><di=
v><br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div=
><div><br></div><div><span id=3D"zwchr" data-marker=3D"__DIVIDER__">----- O=
n Mar 9, 2022, at 11:37 AM, Mathieu Desnoyers &lt;mathieu.desnoyers@efficio=
s.com&gt; wrote:<br></span></div><div data-marker=3D"__QUOTED_TEXT__"><bloc=
kquote style=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:=
5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;fo=
nt-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div style=3D"font-fa=
mily:'arial' , 'helvetica' , sans-serif;font-size:12pt;color:#000000"><div>=
When this happpens, is the process holding a single (or very few) shm file =
references, or references to many<br></div><div>shm files ?<br></div><br><d=
iv>I wonder if you end up in a scenario where an application very frequentl=
y performs exec(), and therefore<br></div><div>sometimes the exec() will ha=
ppen in the window between the unix socket file descriptor reception and<br=
></div><div>call to fcntl FD_CLOEXEC.<br></div><br><div>Thanks,<br></div><b=
r><div>Mathieu<br></div><br><div><span id=3D"zwchr">----- On Mar 8, 2022, a=
t 8:29 PM, zhenyu.ren &lt;zhenyu.ren@aliyun.com&gt; wrote:<br></span></div>=
<div><blockquote style=3D"border-left:2px solid #1010ff;margin-left:5px;pad=
ding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decorati=
on:none;font-family:'helvetica' , 'arial' , sans-serif;font-size:12pt"><div=
 class=3D"__aliyun_email_body_block"><div><span style=3D"font-family:'tahom=
a' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">Thanks a&=
nbsp; lot for reply. I do not reply it in bug tracker since I have not gott=
en a reliable way to reproduce the leak case.&nbsp;</span></div><blockquote=
 style=3D"margin-right:0;margin-top:0;margin-bottom:0"><div><span style=3D"=
font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:=
#000000">------------------------------------------------------------------=
</span></div><div><span style=3D"font-family:'tahoma' , 'arial' , 'stheiti'=
 , 'simsun';font-size:14px;color:#000000">=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=
=9AMathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt;</span></div><di=
v><span style=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font=
-size:14px;color:#000000">=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=
=E5=B9=B43=E6=9C=888=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=8C) 23:26</span></di=
v><div><span style=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun'=
;font-size:14px;color:#000000">=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.r=
en &lt;zhenyu.ren@aliyun.com&gt;</span></div><div><span style=3D"font-famil=
y:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">=
=E6=8A=84=E3=80=80=E9=80=81=EF=BC=9AJonathan Rajotte &lt;jonathan.rajotte-j=
ulien@efficios.com&gt;; lttng-dev &lt;lttng-dev@lists.lttng.org&gt;</span><=
/div><div><span style=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'sims=
un';font-size:14px;color:#000000">=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: [=
lttng-dev] =E5=9B=9E=E5=A4=8D=EF=BC=9A =E5=9B=9E=E5=A4=8D=EF=BC=9A =E5=9B=
=9E=E5=A4=8D=EF=BC=9A shm leak in traced application?</span></div><div><spa=
n style=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:=
14px;color:#000000"><br></span></div><br><br>-----&nbsp;On&nbsp;Mar&nbsp;8,=
&nbsp;2022,&nbsp;at&nbsp;12:18&nbsp;AM,&nbsp;lttng-dev&nbsp;lttng-dev@lists=
.lttng.org&nbsp;wrote:<br><br>&gt;&nbsp;Hi,<br>&gt;&nbsp;In&nbsp;shm_object=
_table_append_shm()/alloc_shm()=EF=BC=8C&nbsp;why&nbsp;not&nbsp;calling&nbs=
p;FD_CLOEXEC&nbsp;fcntl()<br>&gt;&nbsp;to&nbsp;shmfds?&nbsp;I&nbsp;guess&nb=
sp;this&nbsp;omission&nbsp;leads&nbsp;to&nbsp;shm&nbsp;fds&nbsp;leak.<br><b=
r>Those&nbsp;file&nbsp;descriptors&nbsp;are&nbsp;created&nbsp;when&nbsp;rec=
eived&nbsp;by&nbsp;ustcomm_recv_fds_unix_sock,&nbsp;and<br>immediately&nbsp=
;after&nbsp;creation&nbsp;they&nbsp;are&nbsp;set&nbsp;as&nbsp;FD_CLOEXEC.<b=
r><br>We&nbsp;should&nbsp;continue&nbsp;this&nbsp;discussion&nbsp;in&nbsp;t=
he&nbsp;bug&nbsp;tracker&nbsp;as&nbsp;suggested&nbsp;by&nbsp;Jonathan.<br>I=
t&nbsp;would&nbsp;greatly&nbsp;help&nbsp;if&nbsp;you&nbsp;can&nbsp;provide&=
nbsp;a&nbsp;small&nbsp;reproducer.<br><br>Thanks,<br><br>Mathieu<br><br><br=
>&gt;&nbsp;Thanks<br>&gt;&nbsp;zhenyu.ren<br><br>&gt;&gt;&nbsp;------------=
------------------------------------------------------<br>&gt;&gt;&nbsp;=E5=
=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AJonathan&nbsp;Rajotte-Julien&nbsp;&lt;jona=
than.rajotte-julien@efficios.com&gt;<br>&gt;&gt;&nbsp;=E5=8F=91=E9=80=81=E6=
=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B42=E6=9C=8825=E6=97=A5(=E6=98=9F=E6=9C=
=9F=E4=BA=94)&nbsp;22:31<br>&gt;&gt;&nbsp;=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=
=9Azhenyu.ren&nbsp;&lt;zhenyu.ren@aliyun.com&gt;<br>&gt;&gt;&nbsp;=E6=8A=84=
&nbsp;=E9=80=81=EF=BC=9Alttng-dev&nbsp;&lt;lttng-dev@lists.lttng.org&gt;<br=
>&gt;&gt;&nbsp;=E4=B8=BB&nbsp;=E9=A2=98=EF=BC=9ARe:&nbsp;[lttng-dev]&nbsp;=
=E5=9B=9E=E5=A4=8D=EF=BC=9A&nbsp;=E5=9B=9E=E5=A4=8D=EF=BC=9A&nbsp;shm&nbsp;=
leak&nbsp;in&nbsp;traced&nbsp;application?<br><br>&gt;&gt;&nbsp;Hi&nbsp;zhe=
nyu.ren,<br><br>&gt;&gt;&nbsp;Please&nbsp;open&nbsp;a&nbsp;bug&nbsp;on&nbsp=
;our&nbsp;bug&nbsp;tracker&nbsp;and&nbsp;provide&nbsp;a&nbsp;reproducer&nbs=
p;against&nbsp;the&nbsp;latest<br>&gt;&gt;&nbsp;stable&nbsp;version&nbsp;(2=
.13.x).<br><br>&gt;&gt;&nbsp;https://bugs.lttng.org/<br><br>&gt;&gt;&nbsp;P=
lease&nbsp;follow&nbsp;the&nbsp;guidelines:&nbsp;https://bugs.lttng.org/#Bu=
g-reporting-guidelines<br><br>&gt;&gt;&nbsp;Cheers<br><br>&gt;&gt;&nbsp;On&=
nbsp;Fri,&nbsp;Feb&nbsp;25,&nbsp;2022&nbsp;at&nbsp;12:47:34PM&nbsp;+0800,&n=
bsp;zhenyu.ren&nbsp;via&nbsp;lttng-dev&nbsp;wrote:<br>&gt;&gt;&nbsp;&gt;&nb=
sp;Hi,&nbsp;lttng-dev&nbsp;team<br>&gt;&gt;&gt;&nbsp;When&nbsp;lttng-sessio=
nd&nbsp;exits,&nbsp;the&nbsp;ust&nbsp;applications&nbsp;should&nbsp;call<br=
>&gt;&gt;&gt;&nbsp;lttng_ust_objd_table_owner_cleanup()&nbsp;and&nbsp;clean=
&nbsp;up&nbsp;all&nbsp;shm&nbsp;resource(unmap&nbsp;and<br>&gt;&gt;&gt;&nbs=
p;close).&nbsp;Howerver&nbsp;I&nbsp;do&nbsp;find&nbsp;that&nbsp;the&nbsp;us=
t&nbsp;applications&nbsp;keep&nbsp;opening&nbsp;"all"&nbsp;of&nbsp;the<br>&=
gt;&gt;&nbsp;&gt;&nbsp;shm&nbsp;fds("/dev/shm/ust-shm-consumer-81132&nbsp;(=
deleted)")&nbsp;and&nbsp;do&nbsp;NOT&nbsp;free&nbsp;shm.<br>&gt;&gt;&gt;&nb=
sp;If&nbsp;we&nbsp;run&nbsp;lttng-sessiond&nbsp;again,&nbsp;ust&nbsp;applic=
ations&nbsp;can&nbsp;get&nbsp;a&nbsp;new&nbsp;piece&nbsp;of&nbsp;shm&nbsp;a=
nd<br>&gt;&gt;&gt;&nbsp;a&nbsp;new&nbsp;list&nbsp;of&nbsp;shm&nbsp;fds&nbsp=
;so&nbsp;double&nbsp;shm&nbsp;usages.&nbsp;Then&nbsp;if&nbsp;we&nbsp;kill&n=
bsp;lttng-sessiond,<br>&gt;&gt;&gt;&nbsp;what&nbsp;the&nbsp;mostlikely&nbsp=
;happened&nbsp;is&nbsp;ust&nbsp;applications&nbsp;close&nbsp;the&nbsp;new&n=
bsp;list&nbsp;of&nbsp;shm&nbsp;fds<br>&gt;&gt;&gt;&nbsp;and&nbsp;free&nbsp;=
new&nbsp;shm&nbsp;resource&nbsp;but&nbsp;keeping&nbsp;old&nbsp;shm&nbsp;sti=
ll.&nbsp;In&nbsp;other&nbsp;word,&nbsp;we&nbsp;can&nbsp;not<br>&gt;&gt;&nbs=
p;&gt;&nbsp;free&nbsp;this&nbsp;piece&nbsp;of&nbsp;shm&nbsp;unless&nbsp;we&=
nbsp;killing&nbsp;ust&nbsp;applications!!!<br>&gt;&gt;&gt;&nbsp;So&nbsp;Is&=
nbsp;there&nbsp;any&nbsp;possilbe&nbsp;that&nbsp;ust&nbsp;applications&nbsp=
;failed&nbsp;calling<br>&gt;&gt;&gt;&nbsp;lttng_ust_objd_table_owner_cleanu=
p()?&nbsp;Do&nbsp;you&nbsp;have&nbsp;ever&nbsp;see&nbsp;this&nbsp;problem?&=
nbsp;Do&nbsp;you<br>&gt;&gt;&gt;&nbsp;have&nbsp;any&nbsp;advice&nbsp;to&nbs=
p;free&nbsp;the&nbsp;shm&nbsp;without&nbsp;killling&nbsp;ust&nbsp;applicati=
ons(I&nbsp;tried&nbsp;to<br>&gt;&gt;&nbsp;&gt;&nbsp;dig&nbsp;into&nbsp;kern=
el&nbsp;shm_open&nbsp;and&nbsp;/dev/shm,&nbsp;but&nbsp;not&nbsp;found&nbsp;=
any&nbsp;ideas)?<br><br>&gt;&gt;&nbsp;&gt;&nbsp;Thanks&nbsp;in&nbsp;advance=
<br>&gt;&gt;&nbsp;&gt;&nbsp;zhenyu.ren<br><br><br><br>&gt;&gt;&nbsp;&gt;&nb=
sp;------------------------------------------------------------------<br>&g=
t;&gt;&nbsp;&gt;&nbsp;=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren&nbsp;v=
ia&nbsp;lttng-dev&nbsp;&lt;lttng-dev@lists.lttng.org&gt;<br>&gt;&gt;&nbsp;&=
gt;&nbsp;=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B42=E6=9C=
=8823=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=B8=89)&nbsp;23:09<br>&gt;&gt;&nbsp;&gt=
;&nbsp;=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Alttng-dev&nbsp;&lt;lttng-dev@lis=
ts.lttng.org&gt;<br>&gt;&gt;&nbsp;&gt;&nbsp;=E4=B8=BB&nbsp;=E9=A2=98=EF=BC=
=9A[lttng-dev]&nbsp;=E5=9B=9E=E5=A4=8D=EF=BC=9A&nbsp;shm&nbsp;leak&nbsp;in&=
nbsp;traced&nbsp;application?<br><br>&gt;&gt;&gt;&nbsp;&gt;"I&nbsp;found&nb=
sp;these&nbsp;items&nbsp;also&nbsp;exist&nbsp;in&nbsp;a&nbsp;traced&nbsp;ap=
plication&nbsp;which&nbsp;is&nbsp;a&nbsp;long-time<br>&gt;&gt;&nbsp;&gt;&nb=
sp;&gt;running&nbsp;daemon"<br>&gt;&gt;&nbsp;&gt;&nbsp;Even&nbsp;if&nbsp;lt=
tng-sessiond&nbsp;has&nbsp;been&nbsp;killed!!<br><br>&gt;&gt;&nbsp;&gt;&nbs=
p;Thanks<br>&gt;&gt;&nbsp;&gt;&nbsp;zhenyu.ren<br>&gt;&gt;&nbsp;&gt;&nbsp;-=
-----------------------------------------------------------------<br>&gt;&g=
t;&nbsp;&gt;&nbsp;=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren&nbsp;via&n=
bsp;lttng-dev&nbsp;&lt;lttng-dev@lists.lttng.org&gt;<br>&gt;&gt;&nbsp;&gt;&=
nbsp;=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B42=E6=9C=8823=
=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=B8=89)&nbsp;22:44<br>&gt;&gt;&nbsp;&gt;&nbs=
p;=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Alttng-dev&nbsp;&lt;lttng-dev@lists.lt=
tng.org&gt;<br>&gt;&gt;&nbsp;&gt;&nbsp;=E4=B8=BB&nbsp;=E9=A2=98=EF=BC=9A[lt=
tng-dev]&nbsp;shm&nbsp;leak&nbsp;in&nbsp;traced&nbsp;application?<br><br>&g=
t;&gt;&nbsp;&gt;&nbsp;Hi,<br>&gt;&gt;&gt;&nbsp;There&nbsp;are&nbsp;many&nbs=
p;items&nbsp;such&nbsp;as&nbsp;"/dev/shm/ust-shm-consumer-81132&nbsp;(delet=
ed)"&nbsp;exist<br>&gt;&gt;&gt;&nbsp;in&nbsp;lttng-sessiond&nbsp;fd&nbsp;sp=
aces.&nbsp;I&nbsp;know&nbsp;it&nbsp;is&nbsp;the&nbsp;result&nbsp;of&nbsp;sh=
m_open()&nbsp;and<br>&gt;&gt;&nbsp;&gt;&nbsp;shm_unlnik()&nbsp;in&nbsp;crea=
te_posix_shm().<br>&gt;&gt;&gt;&nbsp;However,&nbsp;today,&nbsp;I&nbsp;found=
&nbsp;these&nbsp;items&nbsp;also&nbsp;exist&nbsp;in&nbsp;a&nbsp;traced&nbsp=
;application&nbsp;which&nbsp;is<br>&gt;&gt;&gt;&nbsp;a&nbsp;long-time&nbsp;=
running&nbsp;daemon.&nbsp;The&nbsp;most&nbsp;important&nbsp;thing&nbsp;I&nb=
sp;found&nbsp;is&nbsp;that&nbsp;there<br>&gt;&gt;&nbsp;&gt;&nbsp;seems&nbsp=
;no&nbsp;reliable&nbsp;way&nbsp;to&nbsp;release&nbsp;share&nbsp;memory.<br>=
&gt;&gt;&gt;&nbsp;I&nbsp;tried&nbsp;to&nbsp;kill&nbsp;lttng-sessiond&nbsp;b=
ut&nbsp;not&nbsp;always&nbsp;release&nbsp;share&nbsp;memory.&nbsp;Sometimes=
&nbsp;I<br>&gt;&gt;&gt;&nbsp;need&nbsp;to&nbsp;kill&nbsp;the&nbsp;traced&nb=
sp;application&nbsp;to&nbsp;free&nbsp;share&nbsp;memory....But&nbsp;it&nbsp=
;is&nbsp;not&nbsp;a<br>&gt;&gt;&nbsp;&gt;&nbsp;good&nbsp;idea&nbsp;to&nbsp;=
kill&nbsp;these&nbsp;applications.<br>&gt;&gt;&nbsp;&gt;&nbsp;My&nbsp;quest=
ions&nbsp;are:<br>&gt;&gt;&gt;&nbsp;1.&nbsp;Is&nbsp;there&nbsp;any&nbsp;way=
&nbsp;to&nbsp;release&nbsp;share&nbsp;memory&nbsp;without&nbsp;killing&nbsp=
;any&nbsp;traced<br>&gt;&gt;&nbsp;&gt;&nbsp;application?<br>&gt;&gt;&gt;&nb=
sp;2.&nbsp;Is&nbsp;it&nbsp;normal&nbsp;that&nbsp;many&nbsp;items&nbsp;such&=
nbsp;as&nbsp;"/dev/shm/ust-shm-consumer-81132<br>&gt;&gt;&nbsp;&gt;&nbsp;(d=
eleted)"&nbsp;exist&nbsp;in&nbsp;the&nbsp;traced&nbsp;application?<br><br>&=
gt;&gt;&nbsp;&gt;&nbsp;Thanks<br>&gt;&gt;&nbsp;&gt;&nbsp;zhenyu.ren<br><br>=
<br><br>&gt;&gt;&nbsp;&gt;&nbsp;___________________________________________=
____<br>&gt;&gt;&nbsp;&gt;&nbsp;lttng-dev&nbsp;mailing&nbsp;list<br>&gt;&gt=
;&nbsp;&gt;&nbsp;lttng-dev@lists.lttng.org<br>&gt;&gt;&nbsp;&gt;&nbsp;https=
://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br><br>&gt;&gt;&nbsp;=
--<br>&gt;&gt;&nbsp;Jonathan&nbsp;Rajotte-Julien<br>&gt;&gt;&nbsp;EfficiOS<=
br>&gt;&nbsp;_______________________________________________<br>&gt;&nbsp;l=
ttng-dev&nbsp;mailing&nbsp;list<br>&gt;&nbsp;lttng-dev@lists.lttng.org<br>&=
gt;&nbsp;https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br>--&n=
bsp;<br>Mathieu&nbsp;Desnoyers<br>EfficiOS&nbsp;Inc.<br>http://www.efficios=
.com</blockquote></div><br></blockquote></div><br><div>-- <br></div><div>Ma=
thieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div><br>=
</blockquote></div><div><br></div><div data-marker=3D"__SIG_POST__">-- <br>=
</div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</d=
iv></div></body></html>
--=_33316504-2f92-49a7-a1f5-21db56df6daf--

--===============5146134758815724167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============5146134758815724167==--
