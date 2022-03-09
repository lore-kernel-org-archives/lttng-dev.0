Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8022C433F5
	for <lttng-dev@archiver.kernel.org>; Wed,  9 Mar 2022 16:37:17 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4KDHsm0yBBzB0Z;
	Wed,  9 Mar 2022 11:37:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1646843836;
	bh=hd21WHXe/JsbvpkQovERIUDPta+SY0Hfl50sMgaLktM=;
	h=Date:To:In-Reply-To:References:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=y+ZKiFyoNMuMBV9BoePqebzz3S5MIzmzBZahsoNyCcUPV9zED71EV4N4CbszKTtxH
	 TrD8qn4kH2QaCw8zqLE6n530gExvaqYXlLo/g6uq6EFmlUcgbbTlFgCy8HsHFVROzx
	 Dt6ZvPsnRFWqUIrZ7PjOqzPJLwczvx0xmVUuLicDUz43YWX0jtbF+JXVwOX0onzHW0
	 5SIaMcGwG+pqKpqb85mO95XnF4NsPtu8dtdFgFyGyeKBUoG3qmOiWHf7MlpU8A70Fq
	 ftsG3tBDpOvM/a1a5JdeSR+iaQrUXvSkyf39UGWrOQ521NHrTsw1ccvTRwbX1zM2sG
	 ZOb4BeuVVBmhg==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4KDHsk3WzMzBKH
 for <lttng-dev@lists.lttng.org>; Wed,  9 Mar 2022 11:37:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 293C9393FDC;
 Wed,  9 Mar 2022 11:37:03 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 76kX7oR4PFiD; Wed,  9 Mar 2022 11:37:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 604C7393FDA;
 Wed,  9 Mar 2022 11:37:02 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 604C7393FDA
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 9ogwJaS3nWHh; Wed,  9 Mar 2022 11:37:02 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 4F43D393EDB;
 Wed,  9 Mar 2022 11:37:02 -0500 (EST)
Date: Wed, 9 Mar 2022 11:37:02 -0500 (EST)
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Message-ID: <816104861.134170.1646843822208.JavaMail.zimbra@efficios.com>
In-Reply-To: <1a87b3ee-9983-4db6-b569-e6e6c1ab8411.zhenyu.ren@aliyun.com>
References: <e706d6c8-edea-4f26-a9e2-4a66f067204e.zhenyu.ren@aliyun.com>
 <cbf6b471-85d1-46f5-b10b-2a643b79433c.zhenyu.ren@aliyun.com>
 <c0e023fd-bd52-4125-9e50-c096167386ff.zhenyu.ren@aliyun.com>
 <20220225142111.GC1861057@x>
 <26341add-b962-4027-8c5e-28d940e8f4dc.zhenyu.ren@aliyun.com>
 <2119663162.129405.1646752637020.JavaMail.zimbra@efficios.com>
 <1a87b3ee-9983-4db6-b569-e6e6c1ab8411.zhenyu.ren@aliyun.com>
MIME-Version: 1.0
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF97 (Linux)/8.8.15_GA_4232)
Thread-Topic: =?utf-8?B?5Zue5aSN77yaW2x0dG5nLWRldl0g5Zue5aSN77yaIOWbnuWkje+8miDlm57lpI3vvJo=?=
 shm leak in traced application?
Thread-Index: jw7LRmFAcVsMJPBj4cp2PGx88gfkXA==
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
Content-Type: multipart/mixed; boundary="===============2971732014250284935=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============2971732014250284935==
Content-Type: multipart/alternative; 
	boundary="=_918eaa43-d5ec-4c71-91d5-a88e8d29ff10"

--=_918eaa43-d5ec-4c71-91d5-a88e8d29ff10
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When this happpens, is the process holding a single (or very few) shm file =
references, or references to many=20
shm files ?=20

I wonder if you end up in a scenario where an application very frequently p=
erforms exec(), and therefore=20
sometimes the exec() will happen in the window between the unix socket file=
 descriptor reception and=20
call to fcntl FD_CLOEXEC.=20

Thanks,=20

Mathieu=20

----- On Mar 8, 2022, at 8:29 PM, zhenyu.ren <zhenyu.ren@aliyun.com> wrote:=
=20

> Thanks a lot for reply. I do not reply it in bug tracker since I have not=
 gotten
> a reliable way to reproduce the leak case.

>> ------------------------------------------------------------------
>> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AMathieu Desnoyers <mathieu.desnoyers=
@efficios.com>
>> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B43=E6=9C=888=E6=
=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=8C) 23:26
>> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren <zhenyu.ren@aliyun.com>
>> =E6=8A=84 =E9=80=81=EF=BC=9AJonathan Rajotte <jonathan.rajotte-julien@ef=
ficios.com>; lttng-dev
>> <lttng-dev@lists.lttng.org>
>> =E4=B8=BB =E9=A2=98=EF=BC=9ARe: [lttng-dev] =E5=9B=9E=E5=A4=8D=EF=BC=9A =
=E5=9B=9E=E5=A4=8D=EF=BC=9A =E5=9B=9E=E5=A4=8D=EF=BC=9A shm leak in traced =
application?

>> ----- On Mar 8, 2022, at 12:18 AM, lttng-dev lttng-dev@lists.lttng.org w=
rote:

>> > Hi,
>> > In shm_object_table_append_shm()/alloc_shm()=EF=BC=8C why not calling =
FD_CLOEXEC fcntl()
>> > to shmfds? I guess this omission leads to shm fds leak.

>> Those file descriptors are created when received by ustcomm_recv_fds_uni=
x_sock,
>> and
>> immediately after creation they are set as FD_CLOEXEC.

>> We should continue this discussion in the bug tracker as suggested by Jo=
nathan.
>> It would greatly help if you can provide a small reproducer.

>> Thanks,

>> Mathieu

>> > Thanks
>> > zhenyu.ren

>> >> ------------------------------------------------------------------
>> >> =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AJonathan Rajotte-Julien <jonathan=
.rajotte-julien@efficios.com>
>> >> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B42=E6=9C=882=
5=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=94) 22:31
>> >> =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren <zhenyu.ren@aliyun.com=
>
>> >> =E6=8A=84 =E9=80=81=EF=BC=9Alttng-dev <lttng-dev@lists.lttng.org>
>> >> =E4=B8=BB =E9=A2=98=EF=BC=9ARe: [lttng-dev] =E5=9B=9E=E5=A4=8D=EF=BC=
=9A =E5=9B=9E=E5=A4=8D=EF=BC=9A shm leak in traced application?

>> >> Hi zhenyu.ren,

>> >> Please open a bug on our bug tracker and provide a reproducer against=
 the latest
>> >> stable version (2.13.x).

>> >> https://bugs.lttng.org/

>> >> Please follow the guidelines: https://bugs.lttng.org/#Bug-reporting-g=
uidelines

>> >> Cheers

>> >> On Fri, Feb 25, 2022 at 12:47:34PM +0800, zhenyu.ren via lttng-dev wr=
ote:
>> >> > Hi, lttng-dev team
>> >>> When lttng-sessiond exits, the ust applications should call
>> >>> lttng_ust_objd_table_owner_cleanup() and clean up all shm resource(u=
nmap and
>> >>> close). Howerver I do find that the ust applications keep opening "a=
ll" of the
>> >> > shm fds("/dev/shm/ust-shm-consumer-81132 (deleted)") and do NOT fre=
e shm.
>> >>> If we run lttng-sessiond again, ust applications can get a new piece=
 of shm and
>> >>> a new list of shm fds so double shm usages. Then if we kill lttng-se=
ssiond,
>> >>> what the mostlikely happened is ust applications close the new list =
of shm fds
>> >>> and free new shm resource but keeping old shm still. In other word, =
we can not
>> >> > free this piece of shm unless we killing ust applications!!!
>> >>> So Is there any possilbe that ust applications failed calling
>> >>> lttng_ust_objd_table_owner_cleanup()? Do you have ever see this prob=
lem? Do you
>> >>> have any advice to free the shm without killling ust applications(I =
tried to
>> >> > dig into kernel shm_open and /dev/shm, but not found any ideas)?

>> >> > Thanks in advance
>> >> > zhenyu.ren

>> >> > ------------------------------------------------------------------
>> >> > =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren via lttng-dev <lttng=
-dev@lists.lttng.org>
>> >> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B42=E6=9C=
=8823=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=B8=89) 23:09
>> >> > =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Alttng-dev <lttng-dev@lists.lttn=
g.org>
>> >> > =E4=B8=BB =E9=A2=98=EF=BC=9A[lttng-dev] =E5=9B=9E=E5=A4=8D=EF=BC=9A=
 shm leak in traced application?

>> >>> >"I found these items also exist in a traced application which is a =
long-time
>> >> > >running daemon"
>> >> > Even if lttng-sessiond has been killed!!

>> >> > Thanks
>> >> > zhenyu.ren
>> >> > ------------------------------------------------------------------
>> >> > =E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren via lttng-dev <lttng=
-dev@lists.lttng.org>
>> >> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B42=E6=9C=
=8823=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=B8=89) 22:44
>> >> > =E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Alttng-dev <lttng-dev@lists.lttn=
g.org>
>> >> > =E4=B8=BB =E9=A2=98=EF=BC=9A[lttng-dev] shm leak in traced applicat=
ion?

>> >> > Hi,
>> >>> There are many items such as "/dev/shm/ust-shm-consumer-81132 (delet=
ed)" exist
>> >>> in lttng-sessiond fd spaces. I know it is the result of shm_open() a=
nd
>> >> > shm_unlnik() in create_posix_shm().
>> >>> However, today, I found these items also exist in a traced applicati=
on which is
>> >>> a long-time running daemon. The most important thing I found is that=
 there
>> >> > seems no reliable way to release share memory.
>> >>> I tried to kill lttng-sessiond but not always release share memory. =
Sometimes I
>> >>> need to kill the traced application to free share memory....But it i=
s not a
>> >> > good idea to kill these applications.
>> >> > My questions are:
>> >>> 1. Is there any way to release share memory without killing any trac=
ed
>> >> > application?
>> >>> 2. Is it normal that many items such as "/dev/shm/ust-shm-consumer-8=
1132
>> >> > (deleted)" exist in the traced application?

>> >> > Thanks
>> >> > zhenyu.ren

>> >> > _______________________________________________
>> >> > lttng-dev mailing list
>> >> > lttng-dev@lists.lttng.org
>> >> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

>> >> --
>> >> Jonathan Rajotte-Julien
>> >> EfficiOS
>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> --
>> Mathieu Desnoyers
>> EfficiOS Inc.
>> http://www.efficios.com
--=20
Mathieu Desnoyers=20
EfficiOS Inc.=20
http://www.efficios.com=20

--=_918eaa43-d5ec-4c71-91d5-a88e8d29ff10
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>When this happpens, is the process holding =
a single (or very few) shm file references, or references to many<br data-m=
ce-bogus=3D"1"></div><div>shm files ?<br data-mce-bogus=3D"1"></div><div><b=
r data-mce-bogus=3D"1"></div><div>I wonder if you end up in a scenario wher=
e an application very frequently performs exec(), and therefore<br data-mce=
-bogus=3D"1"></div><div>sometimes the exec() will happen in the window betw=
een the unix socket file descriptor reception and<br data-mce-bogus=3D"1"><=
/div><div>call to fcntl FD_CLOEXEC.<br data-mce-bogus=3D"1"></div><div><br =
data-mce-bogus=3D"1"></div><div>Thanks,<br data-mce-bogus=3D"1"></div><div>=
<br data-mce-bogus=3D"1"></div><div>Mathieu<br data-mce-bogus=3D"1"></div><=
div><br></div><div><span id=3D"zwchr" data-marker=3D"__DIVIDER__">----- On =
Mar 8, 2022, at 8:29 PM, zhenyu.ren &lt;zhenyu.ren@aliyun.com&gt; wrote:<br=
></span></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"bor=
der-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font=
-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica=
,Arial,sans-serif;font-size:12pt;"><div class=3D"__aliyun_email_body_block"=
><div><span style=3D"font-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';=
font-size:14px;color:#000000">Thanks a&nbsp; lot for reply. I do not reply =
it in bug tracker since I have not gotten a reliable way to reproduce the l=
eak case.&nbsp;</span></div><blockquote style=3D"margin-right:0;margin-top:=
0;margin-bottom:0"><div><span style=3D"font-family:'tahoma' , 'arial' , 'st=
heiti' , 'simsun';font-size:14px;color:#000000">---------------------------=
---------------------------------------</span></div><div><span style=3D"fon=
t-family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#00=
0000">=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9AMathieu Desnoyers &lt;mathieu.des=
noyers@efficios.com&gt;</span></div><div><span style=3D"font-family:'tahoma=
' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">=E5=8F=91=
=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B43=E6=9C=888=E6=97=A5(=E6=
=98=9F=E6=9C=9F=E4=BA=8C) 23:26</span></div><div><span style=3D"font-family=
:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000">=
=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren &lt;zhenyu.ren@aliyun.com&gt=
;</span></div><div><span style=3D"font-family:'tahoma' , 'arial' , 'stheiti=
' , 'simsun';font-size:14px;color:#000000">=E6=8A=84=E3=80=80=E9=80=81=EF=
=BC=9AJonathan Rajotte &lt;jonathan.rajotte-julien@efficios.com&gt;; lttng-=
dev &lt;lttng-dev@lists.lttng.org&gt;</span></div><div><span style=3D"font-=
family:'tahoma' , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#0000=
00">=E4=B8=BB=E3=80=80=E9=A2=98=EF=BC=9ARe: [lttng-dev] =E5=9B=9E=E5=A4=8D=
=EF=BC=9A =E5=9B=9E=E5=A4=8D=EF=BC=9A =E5=9B=9E=E5=A4=8D=EF=BC=9A shm leak =
in traced application?</span></div><div><span style=3D"font-family:'tahoma'=
 , 'arial' , 'stheiti' , 'simsun';font-size:14px;color:#000000"><br></span>=
</div><br><br>-----&nbsp;On&nbsp;Mar&nbsp;8,&nbsp;2022,&nbsp;at&nbsp;12:18&=
nbsp;AM,&nbsp;lttng-dev&nbsp;lttng-dev@lists.lttng.org&nbsp;wrote:<br><br>&=
gt;&nbsp;Hi,<br>&gt;&nbsp;In&nbsp;shm_object_table_append_shm()/alloc_shm()=
=EF=BC=8C&nbsp;why&nbsp;not&nbsp;calling&nbsp;FD_CLOEXEC&nbsp;fcntl()<br>&g=
t;&nbsp;to&nbsp;shmfds?&nbsp;I&nbsp;guess&nbsp;this&nbsp;omission&nbsp;lead=
s&nbsp;to&nbsp;shm&nbsp;fds&nbsp;leak.<br><br>Those&nbsp;file&nbsp;descript=
ors&nbsp;are&nbsp;created&nbsp;when&nbsp;received&nbsp;by&nbsp;ustcomm_recv=
_fds_unix_sock,&nbsp;and<br>immediately&nbsp;after&nbsp;creation&nbsp;they&=
nbsp;are&nbsp;set&nbsp;as&nbsp;FD_CLOEXEC.<br><br>We&nbsp;should&nbsp;conti=
nue&nbsp;this&nbsp;discussion&nbsp;in&nbsp;the&nbsp;bug&nbsp;tracker&nbsp;a=
s&nbsp;suggested&nbsp;by&nbsp;Jonathan.<br>It&nbsp;would&nbsp;greatly&nbsp;=
help&nbsp;if&nbsp;you&nbsp;can&nbsp;provide&nbsp;a&nbsp;small&nbsp;reproduc=
er.<br><br>Thanks,<br><br>Mathieu<br><br><br>&gt;&nbsp;Thanks<br>&gt;&nbsp;=
zhenyu.ren<br><br>&gt;&gt;&nbsp;-------------------------------------------=
-----------------------<br>&gt;&gt;&nbsp;=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=
=9AJonathan&nbsp;Rajotte-Julien&nbsp;&lt;jonathan.rajotte-julien@efficios.c=
om&gt;<br>&gt;&gt;&nbsp;=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4=EF=BC=9A2022=
=E5=B9=B42=E6=9C=8825=E6=97=A5(=E6=98=9F=E6=9C=9F=E4=BA=94)&nbsp;22:31<br>&=
gt;&gt;&nbsp;=E6=94=B6=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren&nbsp;&lt;zhenyu=
.ren@aliyun.com&gt;<br>&gt;&gt;&nbsp;=E6=8A=84&nbsp;=E9=80=81=EF=BC=9Alttng=
-dev&nbsp;&lt;lttng-dev@lists.lttng.org&gt;<br>&gt;&gt;&nbsp;=E4=B8=BB&nbsp=
;=E9=A2=98=EF=BC=9ARe:&nbsp;[lttng-dev]&nbsp;=E5=9B=9E=E5=A4=8D=EF=BC=9A&nb=
sp;=E5=9B=9E=E5=A4=8D=EF=BC=9A&nbsp;shm&nbsp;leak&nbsp;in&nbsp;traced&nbsp;=
application?<br><br>&gt;&gt;&nbsp;Hi&nbsp;zhenyu.ren,<br><br>&gt;&gt;&nbsp;=
Please&nbsp;open&nbsp;a&nbsp;bug&nbsp;on&nbsp;our&nbsp;bug&nbsp;tracker&nbs=
p;and&nbsp;provide&nbsp;a&nbsp;reproducer&nbsp;against&nbsp;the&nbsp;latest=
<br>&gt;&gt;&nbsp;stable&nbsp;version&nbsp;(2.13.x).<br><br>&gt;&gt;&nbsp;h=
ttps://bugs.lttng.org/<br><br>&gt;&gt;&nbsp;Please&nbsp;follow&nbsp;the&nbs=
p;guidelines:&nbsp;https://bugs.lttng.org/#Bug-reporting-guidelines<br><br>=
&gt;&gt;&nbsp;Cheers<br><br>&gt;&gt;&nbsp;On&nbsp;Fri,&nbsp;Feb&nbsp;25,&nb=
sp;2022&nbsp;at&nbsp;12:47:34PM&nbsp;+0800,&nbsp;zhenyu.ren&nbsp;via&nbsp;l=
ttng-dev&nbsp;wrote:<br>&gt;&gt;&nbsp;&gt;&nbsp;Hi,&nbsp;lttng-dev&nbsp;tea=
m<br>&gt;&gt;&gt;&nbsp;When&nbsp;lttng-sessiond&nbsp;exits,&nbsp;the&nbsp;u=
st&nbsp;applications&nbsp;should&nbsp;call<br>&gt;&gt;&gt;&nbsp;lttng_ust_o=
bjd_table_owner_cleanup()&nbsp;and&nbsp;clean&nbsp;up&nbsp;all&nbsp;shm&nbs=
p;resource(unmap&nbsp;and<br>&gt;&gt;&gt;&nbsp;close).&nbsp;Howerver&nbsp;I=
&nbsp;do&nbsp;find&nbsp;that&nbsp;the&nbsp;ust&nbsp;applications&nbsp;keep&=
nbsp;opening&nbsp;"all"&nbsp;of&nbsp;the<br>&gt;&gt;&nbsp;&gt;&nbsp;shm&nbs=
p;fds("/dev/shm/ust-shm-consumer-81132&nbsp;(deleted)")&nbsp;and&nbsp;do&nb=
sp;NOT&nbsp;free&nbsp;shm.<br>&gt;&gt;&gt;&nbsp;If&nbsp;we&nbsp;run&nbsp;lt=
tng-sessiond&nbsp;again,&nbsp;ust&nbsp;applications&nbsp;can&nbsp;get&nbsp;=
a&nbsp;new&nbsp;piece&nbsp;of&nbsp;shm&nbsp;and<br>&gt;&gt;&gt;&nbsp;a&nbsp=
;new&nbsp;list&nbsp;of&nbsp;shm&nbsp;fds&nbsp;so&nbsp;double&nbsp;shm&nbsp;=
usages.&nbsp;Then&nbsp;if&nbsp;we&nbsp;kill&nbsp;lttng-sessiond,<br>&gt;&gt=
;&gt;&nbsp;what&nbsp;the&nbsp;mostlikely&nbsp;happened&nbsp;is&nbsp;ust&nbs=
p;applications&nbsp;close&nbsp;the&nbsp;new&nbsp;list&nbsp;of&nbsp;shm&nbsp=
;fds<br>&gt;&gt;&gt;&nbsp;and&nbsp;free&nbsp;new&nbsp;shm&nbsp;resource&nbs=
p;but&nbsp;keeping&nbsp;old&nbsp;shm&nbsp;still.&nbsp;In&nbsp;other&nbsp;wo=
rd,&nbsp;we&nbsp;can&nbsp;not<br>&gt;&gt;&nbsp;&gt;&nbsp;free&nbsp;this&nbs=
p;piece&nbsp;of&nbsp;shm&nbsp;unless&nbsp;we&nbsp;killing&nbsp;ust&nbsp;app=
lications!!!<br>&gt;&gt;&gt;&nbsp;So&nbsp;Is&nbsp;there&nbsp;any&nbsp;possi=
lbe&nbsp;that&nbsp;ust&nbsp;applications&nbsp;failed&nbsp;calling<br>&gt;&g=
t;&gt;&nbsp;lttng_ust_objd_table_owner_cleanup()?&nbsp;Do&nbsp;you&nbsp;hav=
e&nbsp;ever&nbsp;see&nbsp;this&nbsp;problem?&nbsp;Do&nbsp;you<br>&gt;&gt;&g=
t;&nbsp;have&nbsp;any&nbsp;advice&nbsp;to&nbsp;free&nbsp;the&nbsp;shm&nbsp;=
without&nbsp;killling&nbsp;ust&nbsp;applications(I&nbsp;tried&nbsp;to<br>&g=
t;&gt;&nbsp;&gt;&nbsp;dig&nbsp;into&nbsp;kernel&nbsp;shm_open&nbsp;and&nbsp=
;/dev/shm,&nbsp;but&nbsp;not&nbsp;found&nbsp;any&nbsp;ideas)?<br><br>&gt;&g=
t;&nbsp;&gt;&nbsp;Thanks&nbsp;in&nbsp;advance<br>&gt;&gt;&nbsp;&gt;&nbsp;zh=
enyu.ren<br><br><br><br>&gt;&gt;&nbsp;&gt;&nbsp;---------------------------=
---------------------------------------<br>&gt;&gt;&nbsp;&gt;&nbsp;=E5=8F=
=91=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren&nbsp;via&nbsp;lttng-dev&nbsp;&lt;l=
ttng-dev@lists.lttng.org&gt;<br>&gt;&gt;&nbsp;&gt;&nbsp;=E5=8F=91=E9=80=81=
=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B42=E6=9C=8823=E6=97=A5(=E6=98=9F=E6=
=9C=9F=E4=B8=89)&nbsp;23:09<br>&gt;&gt;&nbsp;&gt;&nbsp;=E6=94=B6=E4=BB=B6=
=E4=BA=BA=EF=BC=9Alttng-dev&nbsp;&lt;lttng-dev@lists.lttng.org&gt;<br>&gt;&=
gt;&nbsp;&gt;&nbsp;=E4=B8=BB&nbsp;=E9=A2=98=EF=BC=9A[lttng-dev]&nbsp;=E5=9B=
=9E=E5=A4=8D=EF=BC=9A&nbsp;shm&nbsp;leak&nbsp;in&nbsp;traced&nbsp;applicati=
on?<br><br>&gt;&gt;&gt;&nbsp;&gt;"I&nbsp;found&nbsp;these&nbsp;items&nbsp;a=
lso&nbsp;exist&nbsp;in&nbsp;a&nbsp;traced&nbsp;application&nbsp;which&nbsp;=
is&nbsp;a&nbsp;long-time<br>&gt;&gt;&nbsp;&gt;&nbsp;&gt;running&nbsp;daemon=
"<br>&gt;&gt;&nbsp;&gt;&nbsp;Even&nbsp;if&nbsp;lttng-sessiond&nbsp;has&nbsp=
;been&nbsp;killed!!<br><br>&gt;&gt;&nbsp;&gt;&nbsp;Thanks<br>&gt;&gt;&nbsp;=
&gt;&nbsp;zhenyu.ren<br>&gt;&gt;&nbsp;&gt;&nbsp;---------------------------=
---------------------------------------<br>&gt;&gt;&nbsp;&gt;&nbsp;=E5=8F=
=91=E4=BB=B6=E4=BA=BA=EF=BC=9Azhenyu.ren&nbsp;via&nbsp;lttng-dev&nbsp;&lt;l=
ttng-dev@lists.lttng.org&gt;<br>&gt;&gt;&nbsp;&gt;&nbsp;=E5=8F=91=E9=80=81=
=E6=97=B6=E9=97=B4=EF=BC=9A2022=E5=B9=B42=E6=9C=8823=E6=97=A5(=E6=98=9F=E6=
=9C=9F=E4=B8=89)&nbsp;22:44<br>&gt;&gt;&nbsp;&gt;&nbsp;=E6=94=B6=E4=BB=B6=
=E4=BA=BA=EF=BC=9Alttng-dev&nbsp;&lt;lttng-dev@lists.lttng.org&gt;<br>&gt;&=
gt;&nbsp;&gt;&nbsp;=E4=B8=BB&nbsp;=E9=A2=98=EF=BC=9A[lttng-dev]&nbsp;shm&nb=
sp;leak&nbsp;in&nbsp;traced&nbsp;application?<br><br>&gt;&gt;&nbsp;&gt;&nbs=
p;Hi,<br>&gt;&gt;&gt;&nbsp;There&nbsp;are&nbsp;many&nbsp;items&nbsp;such&nb=
sp;as&nbsp;"/dev/shm/ust-shm-consumer-81132&nbsp;(deleted)"&nbsp;exist<br>&=
gt;&gt;&gt;&nbsp;in&nbsp;lttng-sessiond&nbsp;fd&nbsp;spaces.&nbsp;I&nbsp;kn=
ow&nbsp;it&nbsp;is&nbsp;the&nbsp;result&nbsp;of&nbsp;shm_open()&nbsp;and<br=
>&gt;&gt;&nbsp;&gt;&nbsp;shm_unlnik()&nbsp;in&nbsp;create_posix_shm().<br>&=
gt;&gt;&gt;&nbsp;However,&nbsp;today,&nbsp;I&nbsp;found&nbsp;these&nbsp;ite=
ms&nbsp;also&nbsp;exist&nbsp;in&nbsp;a&nbsp;traced&nbsp;application&nbsp;wh=
ich&nbsp;is<br>&gt;&gt;&gt;&nbsp;a&nbsp;long-time&nbsp;running&nbsp;daemon.=
&nbsp;The&nbsp;most&nbsp;important&nbsp;thing&nbsp;I&nbsp;found&nbsp;is&nbs=
p;that&nbsp;there<br>&gt;&gt;&nbsp;&gt;&nbsp;seems&nbsp;no&nbsp;reliable&nb=
sp;way&nbsp;to&nbsp;release&nbsp;share&nbsp;memory.<br>&gt;&gt;&gt;&nbsp;I&=
nbsp;tried&nbsp;to&nbsp;kill&nbsp;lttng-sessiond&nbsp;but&nbsp;not&nbsp;alw=
ays&nbsp;release&nbsp;share&nbsp;memory.&nbsp;Sometimes&nbsp;I<br>&gt;&gt;&=
gt;&nbsp;need&nbsp;to&nbsp;kill&nbsp;the&nbsp;traced&nbsp;application&nbsp;=
to&nbsp;free&nbsp;share&nbsp;memory....But&nbsp;it&nbsp;is&nbsp;not&nbsp;a<=
br>&gt;&gt;&nbsp;&gt;&nbsp;good&nbsp;idea&nbsp;to&nbsp;kill&nbsp;these&nbsp=
;applications.<br>&gt;&gt;&nbsp;&gt;&nbsp;My&nbsp;questions&nbsp;are:<br>&g=
t;&gt;&gt;&nbsp;1.&nbsp;Is&nbsp;there&nbsp;any&nbsp;way&nbsp;to&nbsp;releas=
e&nbsp;share&nbsp;memory&nbsp;without&nbsp;killing&nbsp;any&nbsp;traced<br>=
&gt;&gt;&nbsp;&gt;&nbsp;application?<br>&gt;&gt;&gt;&nbsp;2.&nbsp;Is&nbsp;i=
t&nbsp;normal&nbsp;that&nbsp;many&nbsp;items&nbsp;such&nbsp;as&nbsp;"/dev/s=
hm/ust-shm-consumer-81132<br>&gt;&gt;&nbsp;&gt;&nbsp;(deleted)"&nbsp;exist&=
nbsp;in&nbsp;the&nbsp;traced&nbsp;application?<br><br>&gt;&gt;&nbsp;&gt;&nb=
sp;Thanks<br>&gt;&gt;&nbsp;&gt;&nbsp;zhenyu.ren<br><br><br><br>&gt;&gt;&nbs=
p;&gt;&nbsp;_______________________________________________<br>&gt;&gt;&nbs=
p;&gt;&nbsp;lttng-dev&nbsp;mailing&nbsp;list<br>&gt;&gt;&nbsp;&gt;&nbsp;ltt=
ng-dev@lists.lttng.org<br>&gt;&gt;&nbsp;&gt;&nbsp;https://lists.lttng.org/c=
gi-bin/mailman/listinfo/lttng-dev<br><br>&gt;&gt;&nbsp;--<br>&gt;&gt;&nbsp;=
Jonathan&nbsp;Rajotte-Julien<br>&gt;&gt;&nbsp;EfficiOS<br>&gt;&nbsp;_______=
________________________________________<br>&gt;&nbsp;lttng-dev&nbsp;mailin=
g&nbsp;list<br>&gt;&nbsp;lttng-dev@lists.lttng.org<br>&gt;&nbsp;https://lis=
ts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br>--&nbsp;<br>Mathieu&nbsp=
;Desnoyers<br>EfficiOS&nbsp;Inc.<br>http://www.efficios.com</blockquote></d=
iv><br></blockquote></div><div><br></div><div data-marker=3D"__SIG_POST__">=
-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios=
.com</div></div></body></html>
--=_918eaa43-d5ec-4c71-91d5-a88e8d29ff10--

--===============2971732014250284935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2971732014250284935==--
